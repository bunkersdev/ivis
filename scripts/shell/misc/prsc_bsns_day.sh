#!/bin/bash -e
echo "bsnsDayInd=`hadoop fs -cat $1| cut -d "|" -f 1`"
echo "bsnsDayNum=`hadoop fs -cat $1| cut -d "|" -f 2`"