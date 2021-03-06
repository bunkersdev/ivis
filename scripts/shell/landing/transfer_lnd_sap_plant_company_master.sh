#! /bin/bash
/*
###########################################################################################
# File:   : transfer_lnd_sap_plant_company_master.sh
# Script  : 0
# Version : 1.0.0
# Date    : May 3, 2016
# Author  : Bowen, Jared
# Comments: Copy SAP source data to Hive landing location for LND_SAP_PLANT_COMPANY_MASTER
###########################################################################################        
*/

#Check if file exists
hadoop fs -test -e $1/srcfile/*PLANT*.csv

if [ $? == 0 ]

then
	#Remove existing file from landing table location
	hadoop fs -rm $1/landing/sap/lnd_sap_plant_company_master/*

	#Copy new file from source into landing table location
	hadoop fs -cp $1/srcfile/*SCSP_PLANT*.csv $1/landing/sap/lnd_sap_plant_company_master

	#Remove file from source location and copy it into the archive location
	#hadoop fs -mv $1/srcfile/*PLANT*.csv $1/landing/sap/archive
else
	#Send failure event
	exit 1
fi