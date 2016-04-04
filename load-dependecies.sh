#!/bin/bash
# This is a script which publishes all documents to Nexus
# It requires $POS_VERSION to be set


#################
# CONFIGURATION #
#################
args=("$@")         # Capture arguments
. .profile          # basic configuration
. colors            # colors utils
. logo.sh           # logo
. dependencies.sh   # includes jars we need to load to maven/nexus
. load_methods.sh   # all methods to load jars

#############
# EXECUTION #
#############

header             # print header

if [ "$POS_VERSION" = "" ]
then
   echo 'You need to set POS_VERSION first'
   exit -1
else
	if [ -z "$1" ]     # checks whether destination is set either as --local or --nexus
	then 
		usage          # print usage and exit
		exit -1
	else 
		load           # perform loading to specified destination
	fi
fi
