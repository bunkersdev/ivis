#!/bin/bash 

APP_NAME=ivis
APP_HIVE_DB_NAME="mosc_dev_plng_ivis_hive"
APP_HBASE_DB_NAME="IVIS_DEV"
APP_SUCCESS_MAILS="shubhankar.sharma@abbvie.com,jared.bowen@abbvie.com,lovy.george@Abbvie.com,naga.rayapudi@abbvie.com,hemantha.bandari@abbvie.com"
APP_FAILURE_MAILS="shubhankar.sharma@abbvie.com,jared.bowen@abbvie.com,lovy.george@Abbvie.com,naga.rayapudi@abbvie.com,hemantha.bandari@abbvie.com"
COST_OVERRIDE_MAILS="shubhankar.sharma@abbvie.com,jared.bowen@abbvie.com,lovy.george@Abbvie.com,naga.rayapudi@abbvie.com,hemantha.bandari@abbvie.com"
APP_JDBC_CONNECT=jdbc:oracle:thin:@10.72.45.76:1521:SCPSUND1
STGMGR_SCHEMA=stgmgr
KPI_SCHEMA=kpi
APP_SQOOP_USER=SCMADHOC
TCGM_SQOOP_USER=SCMADHOC