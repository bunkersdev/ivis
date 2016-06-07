#! /bin/bash
/*
####################################################################################
# File:   : sendVarianceMail.sh
# Script  : 0
# Version : 1.0.0
# Date    : May 3, 2016
# Author  : Sharma, Shubhankar
# Comments: Send email when the variance is greater than $900,000
####################################################################################           
*/

file=$( hadoop fs -cat $1 )
template=$( hadoop fs -cat $2 )

email(){
  content="$(cat - )"; email="$1"; subject="$2"; fromname="$3"; from="$4"; bcc="$5"
  {
    echo "Subject: $subject"
    echo "From: $fromname <$from>";
    echo "To: $email";
    echo "Bcc: $bcc";
    echo "$content"
  } | $(which sendmail) -F "$from" "$email" "$bcc"
}
readarray -t lines < <(echo "$file")
tLen=${#lines[@]}

for (( i=0; i<${tLen}; i++ ));
do
  aff_code=$(echo ${lines[$i]} | cut -d "|" -f 1 )
  prod_grp=$(echo  ${lines[$i]} | cut -d'|' -f2 )
  act_boh=$(echo ${lines[$i]} | cut -d'|' -f3 )
  net_boh=$( echo ${lines[$i]} | cut -d'|' -f4 )
  to_mail=$(echo ${lines[$i]} | cut -d'|' -f5 )
  bcc_mail=$( echo ${lines[$i]} | cut -d'|' -f6 )
  default_mail=$( echo ${lines[$i]} | cut -d'|' -f7 )
  year=$( echo ${lines[$i]} | cut -d'|' -f8 )
  period=$( echo ${lines[$i]} | cut -d'|' -f9 )
if [ -z "${to_mail}" ]; then
to_mail=${default_mail}
fi
emailBody=$( echo "${template}" | sed -e "s/AFFILIATE_CODE/$aff_code/g" | sed -e "s/PRODUCT_DESC/$prod_grp/g" | sed -e "s/ACT_BOH_VARNC/$act_boh/g" | sed -e "s/NET_BOH_VARNC/$net_boh/g")
echo -e "${emailBody}" | email ${to_mail} "IVis Variance($year-$period) - $aff_code -$prod_grp" "IVis" "ivis@mail.com" ${bcc_mail}
done