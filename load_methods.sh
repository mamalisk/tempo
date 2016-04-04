# prints the header 
header()
{
	# printf "\033c"
	printf "${GREEN}"
	print_logo
	printf "${NO_COLOUR}\n\n"
}

# prints usage
usage()
{
	printf "In order to load locally you have to run: ${GREEN}./load-depedencies.sh --local${NO_COLOUR}\n"
	printf "Whereas for nexus you have to run: ${GREEN}./load-depedencies.sh --nexus${NO_COLOUR}\n\n"
}

#load endpoint
load()
{
	
	if [ "$args" == "--local" ]; then
		loadToLocalMavenRepo
	else 
		if [ "$args" == "--nexus" ]; then
			loadToNexus
		else
			usage
			exit -1
		fi
	fi
}

# loads to local maven repo
loadToLocalMavenRepo()
{
	printf "Installing Locally version ${RED}${POS_VERSION}${NO_COLOUR} of the following files:\n"
	for jar in "${JARS[@]}"
	do
    	printf "\n\n\n• Installing: ${YELLOW} ${jar} ${NO_COLOUR}\n\n"
    	FILENAME=$(echo $jar | sed 's/.*\///' | awk -F. '{ print $1 }' )
    	EXTENSION=$(echo $jar | sed 's/.*\///' | sed 's/.*\.//')
    	printf "${PURPLE}"
    	mvn install:install-file -Dfile=$ROOT_DIR$jar -DgroupId=com.mns.pos.auto -DartifactId=$FILENAME -Dversion=$POS_VERSION -Dpackaging=$EXTENSION
    	printf "${NO_COLOUR}"
	done
}

# loads to main nexus repo
loadToNexus()
{
	printf "${RED} !!!! NOT IMPLEMENTED YET... !!!! ${NO_COLOUR}\n\n\n"
	printf "Installing to Nexus version ${RED}${POS_VERSION}${NO_COLOUR} of the following files:\n"
	for jar in "${JARS[@]}"
	do
    	printf "\n\n\n• Installing: ${YELLOW} ${jar} ${NO_COLOUR}\n\n"
    	FILENAME=$(echo $jar | sed 's/.*\///' |awk -F. '{ print $1 }' )
    	EXTENSION=$(echo $jar | sed 's/.*\///' | sed 's/.*\.//')
    	printf "${PURPLE}"
   		mvn deploy:deploy-file -DgroupId=com.mns.pos.auto \
			  -DartifactId=$FILENAME\
			  -Dversion=$POS_VERSION \
			  -Dpackaging=$EXTENSION \
			  -Dfile=$ROOT_DIR$jar \
			  -DrepositoryId=mns_nexus \
			  -Durl=http://to_be_confirmed
		printf "${NO_COLOUR}" 	
   	done
}