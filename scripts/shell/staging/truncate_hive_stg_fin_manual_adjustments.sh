#! /bin/bash
/*
##########################################################################
# File:   : truncate_stg_fin_manual_adjustments.sh
# Script  : 0
# Version : 1.0.0
# Date    : May 3, 2016
# Author  : Bowen, Jared
# Comments: Truncate Hive staging location for STG_FIN_MANUAL_ADJUSTMENTS
##########################################################################      
*/

hadoop fs -rm $1/ivis/staging/hive/selfservice/stg_fin_manual_adjustments/*