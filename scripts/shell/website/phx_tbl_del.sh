#!/bin/bash
set -eo pipefail

current_date="$(date +'%Y/%m/%d')"

#mkdir -p /home/moscivisdev/ivis/scripts/hive/failure/$current_date
ENV=$1
PHOENIX_HBASE_CLUSTER=$2
TABLE=$3

echo "starting kinit"
kinit -kt /home/moscivisdev/moscivisdev.keytab moscivisdev@ABBVIENET.COM
klist;

echo "Executing Phoenix Query to delete the table"

cd /etc/hbase/conf

/opt/cloudera/parcels/CLABS_PHOENIX/bin/phoenix-sqlline.py ${PHOENIX_HBASE_CLUSTER}:2181:/hbase <<END
delete from $TABLE
END

echo "Delete $TABLE is successful"

