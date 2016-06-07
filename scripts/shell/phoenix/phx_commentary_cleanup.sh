#!/bin/bash
set -eo pipefail

current_date="$(date +'%Y/%m/%d')"
ENV=$1
PHOENIX_HBASE_CLUSTER=$2
DB_SCHEMA=$3
TABLE=$4
CLAUSE=$5
OWNER=$6

echo "starting kinit"
kinit -kt /home/$OWNER/$OWNER.keytab $OWNER@ABBVIENET.COM
klist;

echo "Executing Phoenix Query to delete the table"

cd /etc/hbase/conf

/opt/cloudera/parcels/CLABS_PHOENIX/bin/phoenix-sqlline.py ${PHOENIX_HBASE_CLUSTER}:2181:/hbase <<END
delete from $DB_SCHEMA.$TABLE $CLAUSE 
END

echo "Delete $TABLE is successful"