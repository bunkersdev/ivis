#!/bin/bash
set -eo pipefail


current_date="$(date +'%Y/%m/%d')"

#mkdir -p /home/moscivisdev/ivis/scripts/hive/failure/$current_date
rm -rf /tmp/ivis/
mkdir -p /tmp/ivis/email/failure/$current_date/
type=$1
UPLOAD_TABLE=$2
ENV=$3
PHOENIX_HBASE_CLUSTER=$4

echo "starting kinit"
kinit -kt /home/moscivisdev/moscivisdev.keytab moscivisdev@ABBVIENET.COM
klist;

echo "Executing Phoenix Query to get Email Id and records uploaded and failed "

cd /etc/hbase/conf

/opt/cloudera/parcels/CLABS_PHOENIX/bin/phoenix-sqlline.py ${PHOENIX_HBASE_CLUSTER}:/hbase <<END
UPSERT INTO $ENV.UPLOAD_PROCESS_SUMMARY (UPLOAD_ID,USR_EML_ID,RECORDS_UPLOADED,RECORDS_FAIL,RECORDS_PASS) 
select CAST(FINAL.UPLOAD_ID as VARCHAR) as UPLOAD_ID,CAST(FINAL.USR_EML_ID as VARCHAR) as USR_EML_ID,TO_CHAR(FINAL.RECORDS_UPLOADED) as RECORDS_UPLOADED ,TO_CHAR(FINAL.RECORDS_FAIL) as RECORDS_FAIL ,TO_CHAR((FINAL.RECORDS_UPLOADED - FINAL.RECORDS_FAIL)) as RECORDS_PASS from (
select UPLOAD_PROCESS_SUMMARY1.UPLOAD_ID ,UPLOAD_PROCESS_SUMMARY1.USR_EML_ID,UPLOAD_PROCESS_SUMMARY1.RECORDS_UPLOADED,(COALESCE(UPLOAD_FAILURE_DETAILS.FAIL_RECORDS,0)) as RECORDS_FAIL from ( 
select DISTINCT $ENV.UPLOAD_PROCESS_SUMMARY.UPLOAD_ID,UPLOAD_TABLE_TEMP2.USR_EML_ID,UPLOAD_TABLE_TEMP2.RECORDS_UPLOADED from (
select UPLOAD_TABLE_TEMP.UPLOAD_ID,$ENV.USR_PERMISSION_MASTER.USR_EML_ID,UPLOAD_TABLE_TEMP.RECORDS_UPLOADED from  (
select UPLOAD_ID,CREATED_BY,count(*) as RECORDS_UPLOADED from $ENV.$UPLOAD_TABLE GROUP BY  UPLOAD_ID,CREATED_BY ) UPLOAD_TABLE_TEMP
JOIN $ENV.USR_PERMISSION_MASTER on 
UPLOAD_TABLE_TEMP.CREATED_BY = $ENV.USR_PERMISSION_MASTER.USR_SCM_ID ) UPLOAD_TABLE_TEMP2
JOIN $ENV.UPLOAD_PROCESS_SUMMARY on  
UPLOAD_TABLE_TEMP2.UPLOAD_ID = $ENV.UPLOAD_PROCESS_SUMMARY.UPLOAD_ID where $ENV.UPLOAD_PROCESS_SUMMARY.STATUS='IN-PROCESS' and $ENV.UPLOAD_PROCESS_SUMMARY.TYPE='$type') UPLOAD_PROCESS_SUMMARY1
LEFT OUTER join
( select UPLOAD_ID,USR_EML_ID,count(*) as FAIL_RECORDS from $ENV.UPLOAD_FAILURE_DETAILS GROUP BY  UPLOAD_ID,USR_EML_ID)
UPLOAD_FAILURE_DETAILS
on 
UPLOAD_FAILURE_DETAILS.UPLOAD_ID = UPLOAD_PROCESS_SUMMARY1.UPLOAD_ID ) FINAL;
END

/opt/cloudera/parcels/CLABS_PHOENIX/bin/phoenix-sqlline.py ${PHOENIX_HBASE_CLUSTER}:/hbase <<END
!outputformat tsv
!record /tmp/ivis/email/uploadids.txt
select UPLOAD_ID,USR_EML_ID,RECORDS_UPLOADED,RECORDS_FAIL,RECORDS_PASS from $ENV.UPLOAD_PROCESS_SUMMARY where STATUS='IN-PROCESS' and TYPE='$type';
!record
END


file=$(cat /tmp/ivis/email/uploadids.txt)
template=$( hadoop fs -cat /applications/ivis/scripts/shell/emailtemplate.html )


readarray -t lines < <(sed '1,2d;$d' /tmp/ivis/email/uploadids.txt )
tLen=${#lines[@]}


failure_email(){
MAILTO="$1";
SUBJECT="$2";
BODY="$5";
ATTACH="$3";
FROM="$4";
MAILPART=`uuidgen`
MAILPART_BODY=`uuidgen`
echo "About to send Failue Email "
(
 echo "To: $MAILTO"
 echo "Subject: $SUBJECT"
 echo "MIME-Version: 1.0"
 echo "Content-Type: multipart/mixed; boundary=\"$MAILPART\""
 echo ""
 echo "--$MAILPART"
 echo "Content-Type: multipart/alternative; boundary=\"$MAILPART_BODY\""
 echo ""
 echo "--$MAILPART_BODY"
 echo "Content-Type: text/plain; charset=ISO-8859-1"
 echo "You need to enable HTML option for email"
 echo "--$MAILPART_BODY"
 echo "Content-Type: text/html; charset=ISO-8859-1"
 echo "Content-Disposition: inline"
 echo "$BODY"
 echo "--$MAILPART_BODY--"

 echo "--$MAILPART"
 echo 'Content-Type: application/csv; name="'$(basename $ATTACH)'"'
 echo "Content-Transfer-Encoding: uuencode"
 echo 'Content-Disposition: attachment; filename="'$(basename $ATTACH)'"'
 echo ""
 #uuencode -m $ATTACH $(basename $ATTACH)
 uuencode $ATTACH $(basename $ATTACH)
 echo "--$MAILPART--"

) | /usr/sbin/sendmail -F "$FROM" $MAILTO
}


success_email(){
MAILTO="$1"
SUBJECT="$2"
BODY="$3"
MAILPART=`uuidgen`
MAILPART_BODY=`uuidgen`
(
 echo "To: $MAILTO"
 echo "Subject: $SUBJECT"
 echo "MIME-Version: 1.0"
 echo "Content-Type: multipart/mixed; boundary=\"$MAILPART\""
 echo ""
 echo "--$MAILPART"
 echo "Content-Type: multipart/alternative; boundary=\"$MAILPART_BODY\""
 echo ""
 echo "--$MAILPART_BODY"
 echo "Content-Type: text/plain; charset=ISO-8859-1"
 echo "You need to enable HTML option for email"
 echo "--$MAILPART_BODY"
 echo "Content-Type: text/html; charset=ISO-8859-1"
 echo "Content-Disposition: inline"
 echo "$BODY"
 echo "--$MAILPART_BODY--"
echo "--$MAILPART"
echo ""
) | /usr/sbin/sendmail $MAILTO

}



# Loop through the Upload id's to send success/Failure Email 

for (( i=0; i<${tLen}; i++ ));
do
echo "Printing Number of records returned for sending Email ${tLen}"
upload_id=$(echo ${lines[$i]} | cut -d "\t" -f 1 |sed 's/'\''//g' )
email_id=$(echo ${lines[$i]} | cut -d "\t" -f 2|sed   's/'\''//g'  )
#email_id="kaviyarasan.selvakalathi@abbvie.com"
rec_uploaded=$(echo ${lines[$i]} | cut -d "\t" -f 3 |sed  's/'\''//g' )
rec_failed=$(echo ${lines[$i]} | cut -d "\t" -f 4 |sed 's/'\''//g'  )
emailBody=$(echo "${template}" |  sed -e "s/UPLOAD_ID/$upload_id/g" |  sed -e "s/EMAIL_ID/$email_id/g" |  sed -e "s/REC_UPLOADED/$rec_uploaded/g" | sed -e "s/REC_FAILED/$rec_failed/g"  )
#echo "Email Template with values populated $emailBody"

# If record failed count greater than zero then sent Failure meail with attachment else Success Email 
if [ $rec_failed -eq 0 ]; then
success_email  ${email_id} "All $UPLOAD_TABLE loaded to db" "${emailBody}" 
  echo "Uploaded records upserted to Phoenix successfully and Success Email Sent to $email_id"
else
# Get all the failed records for upload id to be sent as attachment in Email 
/opt/cloudera/parcels/CLABS_PHOENIX/bin/phoenix-sqlline.py ${PHOENIX_HBASE_CLUSTER}:2181:/hbase <<END
!outputformat csv
!record /tmp/ivis/email/failure/$current_date/failure_$upload_id.csv
select * from $ENV.UPLOAD_FAILURE_DETAILS WHERE UPLOAD_ID='$upload_id';
!record
END
# Removing First and Last Lines with header and tail information before sending email
echo "Removing Header and Footer details before sending Email"
sed -i '1d;$d' /tmp/ivis/email/failure/$current_date/failure_$upload_id.csv
#echo "Failure Email Body ${emailBody}"

#echo -e "${emailBody}" | failure_email ${email_id} "$UPLOAD_TABLE load failed - Please check the attachment for failed records"  "/tmp/ivis/email/failure/$current_date/failure_$upload_id.csv"  "ivis@mail.com"
#echo "Email Body ${emailBody}"
#echo -e ${emailBody} | failure_email ${email_id} "$UPLOAD_TABLE load failed - Please check the attachment for failed records"  "/tmp/ivis/email/failure/$current_date/failure_$upload_id.csv"  "ivis@mail.com"
failure_email ${email_id} "$UPLOAD_TABLE load failed - Please check the attachment for failed records"  "/tmp/ivis/email/failure/$current_date/failure_$upload_id.csv"  "ivis@mail.com" "${emailBody}"

echo "One/More Uploaded records  failed while upserting to Phoenix and Failure Email with failed records as attachment sent to ${email_id}"
fi
done


