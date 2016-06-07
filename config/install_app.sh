#!/bin/bash

. util_funcs.sh

find ../workflows/* -type d -not -path "config" -exec cp job.properties {} \;

find ../bundle/* -type d -not -path "config" -exec cp bundle_job.properties {} \;

 echo "********************************************"
 echo "****** GENERATE WORKFLOW PROPERTIES ********"
 echo "********************************************"
find ../workflows/* -iname "*.properties" -o -iname "*.xml" | while read fname; do
replaceAllEnvParamsInFile $fname
filepath=$( echo $(cd $(dirname "$fname") && pwd -P)/ | cut -d'/' -f4- )
xmlFile=$( find $( echo $(cd $(dirname "$fname") && pwd -P)/ ) -type f -iname '*.xml' -printf "%f\n" )

#Add oozie.wf.application.path to *.properties file
if [[ $fname == *.properties ]]; then 
echo "oozie.wf.application.path=/${filepath}$xmlFile"|cat - "$fname" > /tmp/out && mv /tmp/out "$fname"
fi

done

 echo "********************************************"
 echo "******** GENERATE BUNDLE PROPERTIES ********"
 echo "********************************************"
find ../bundle/* -iname "*.properties" -o -iname "*.xml" | while read fname; do
replaceAllEnvParamsInFile $fname
filepath=$( echo $(cd $(dirname "$fname") && pwd -P)/ | cut -d'/' -f4- )
xmlFile=$( find $( echo $(cd $(dirname "$fname") && pwd -P)/ ) -type f -iname '*.xml' -printf "%f\n" )

#Add oozie.bundle.application.path to *.properties file
if [[ $fname == *.properties ]]; then 
echo "oozie.bundle.application.path=/${filepath}$xmlFile"|cat - "$fname" > /tmp/out && mv /tmp/out "$fname"
fi

done

 echo "********************************************"
 echo "************ EXECUTE HIVE DDLS *************"
 echo "********************************************"
find ../ddl/hive/ -type f -iname "*.sql" | while read fname; do
 hive -hiveconf ENV_VAR=${ENV_VAR} -hiveconf DATABASE=${APP_HIVE_DB_NAME} -f $fname
 #echo $fname
done

 echo "********************************************"
 echo "************ EXECUTE PHOENIX DDLS **********"
 echo "********************************************"
echo "starting kinit"
kinit -kt /home/${ENV_USER_NAME}/${ENV_USER_NAME}.keytab ${ENV_USER_NAME}@ABBVIENET.COM
klist;

 echo "Executing Phoenix Query to create table"

 find ../ddl/phoenix/ -type f -iname "*.sql" | while read fname; do
	file=$( readlink -f $fname )
	replaceAllEnvParamsInFile  ${file}
	cd /etc/hbase/conf
	/opt/cloudera/parcels/CLABS_PHOENIX/bin/phoenix-sqlline.py ${CLUSTER_HBASE_CONFIG}:2181:/hbase  ${file}
 done

 echo "********************************************"
 echo "************ SUBMIT CODE TO HDFS ***********"
 echo "********************************************"
hadoop fs -copyFromLocal -f ../* /applications/mosc/${ENV_VAR}/${APP_NAME}