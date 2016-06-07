#! /bin/bash
/*
#################################################################
# File:   : truncate_stg_plan_upd_gap.sh
# Script  : 0
# Version : 1.0.0
# Date    : May 3, 2016
# Author  : Bowen, Jared
# Comments: Truncate Hive staging location for STG_PLAN_UPD_GAP
#################################################################    
*/

hadoop fs -rm $1/ivis/staging/hive/selfservice/stg_plan_upd_gap/*