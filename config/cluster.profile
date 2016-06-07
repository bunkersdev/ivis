#!/bin/bash 

CLUSTER_HCAT_METASTORE=thrift://en01.nonprod.scn:9083
CLUSTER_HCAT_PRINCIPAL=hive/en01.nonprod.scn@ABBVIENET.COM
CLUSTER_NAMENODE="hdfs://devqaha"
CLUSTER_HIVE_JDBC_URL=jdbc:hive2://en01.nonprod.scn:7183/default
CLUSTER_HIVE_PRINCIPAL=hive/en01.nonprod.scn@ABBVIENET.COM
CLUSTER_JOB_TRACKER="nn01.nonprod.scn:8032"
CLUSTER_HBASE_CONFIG="nn01.nonprod.scn,sn01.nonprod.scn,en02.nonprod.scn"
CLUSTER_NAME=devqaha
CLUSTER_MAP_REDUCE_USR=moscivisdev
CLUSTER_EDGE_NODE_USR=moscivisdev
CLUSTER_QUEUE_NAME=default

