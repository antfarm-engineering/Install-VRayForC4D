#!/bin/bash
# Mac OS Script to automatically install VRay for C4D
#
# Created by Sam Frankiel
# Creation date 7/28/2017
# Modified date 
#

#Verify script is being run as root
if [[ "$EUID" > 0 ]];then 
	printf "Please run as root\n"
	exit
fi

#Find the directory that the script is being run from 
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
R17PATH="/Applications/MAXON/CINEMA\ 4D\ R17"
R18PATH="/Applications/MAXON/CINEMA\ 4D\ R18"
CGPATH="/Applications/ChaosGroup"
HOSTNAME=$(hostname)

#Verify that the user wants to overwrite files
read -p  "WARNING!! you will be overwriting files if they exist. Please confirm (y|n) - Default n :  " -n 1 -r  
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	#Figure out which version(s) of C4D need VRay
	read -p "Do you want to install for R17 (1), R18 (2) or both (3):  " -n 1 -r
	echo
	if	[[ $REPLY == 1 ]]; then
		#Check if R17 is installed - if not move to R18
		if [ -d "$R17PATH" ]; then  
			cp -R $DIR/C4DR17-C4DR17App-Contents-MacOS /Applications/MAXON/CINEMA4D\ R17/CINEMA4D\ R17.app/Contents/MacOS/
			cp -R $DIR/Library-MatPreviews/* /Applications/MAXON/CINEMA4D\ R17/library/materialpreviews
			printf "Changing R17 Permissions\n"
			chmod -R 755 /Applications/MAXON/CINEMA4D\ R17/CINEMA4D\ R17.app/Contents/MacOS/lib*
			chmod -R 755 /Applications/MAXON/CINEMA4D\ R17/CINEMA4D\ R17.app/Contents/MacOS/vray_stuff.dylib
			chmod -R 755 /Applications/MAXON/CINEMA4D\ R17/library/materialpreviews
		else
			printf "Cinema 4D R17 folder not detected\n"
			:
		fi
	elif [[ $REPLY == 2 ]]; then
		#Check if R18 is installed - if not move to exit
		if [ -d "$R18PATH" ]; then  
			cp -R $DIR/C4DR18-C4DR18App-Contents-MacOS /Applications/MAXON/CINEMA4D\ R18/CINEMA4D\ R18.app/Contents/MacOS/
			cp -R $DIR/Library-MatPreviews/* /Applications/MAXON/CINEMA4D\ R18/library/materialpreviews
			chmod -R 755 /Applications/MAXON/CINEMA4D\ R18/CINEMA4D\ R18.app/Contents/MacOS/lib*
			chmod -R 755 /Applications/MAXON/CINEMA4D\ R18/CINEMA4D\ R18.app/Contents/MacOS/vray_stuff.dylib
			chmod -R 755 /Applications/MAXON/CINEMA4D\ R18/library/materialpreviews
		else
			printf "Cinema 4D R18 folder not detected\n"
			:
		fi
	else
		if [[ $REPLY != 3 ]]; then 
			printf "Incorrect input detected - please rerun script to try again\n"
			exit
		else
			#Check if R17 is installed - if not move to R18
			if [ -d "$R17PATH" ]; then  
				cp -R $DIR/C4DR17-C4DR17App-Contents-MacOS /Applications/MAXON/CINEMA4D\ R17/CINEMA4D\ R17.app/Contents/MacOS/
				cp -R $DIR/Library-MatPreviews/* /Applications/MAXON/CINEMA4D\ R17/library/materialpreviews
				printf "Changing R17 Permissions\n"
				chmod -R 755 /Applications/MAXON/CINEMA4D\ R17/CINEMA4D\ R17.app/Contents/MacOS/lib*
				chmod -R 755 /Applications/MAXON/CINEMA4D\ R17/CINEMA4D\ R17.app/Contents/MacOS/vray_stuff.dylib
				chmod -R 755 /Applications/MAXON/CINEMA4D\ R17/library/materialpreviews
			else
				printf "Cinema 4D R17 folder not detected\n"
				:
			fi
			#Check if R18 is installed - if not move to exit
			if [ -d "$R18PATH" ]; then  
				cp -R $DIR/C4DR18-C4DR18App-Contents-MacOS /Applications/MAXON/CINEMA4D\ R18/CINEMA4D\ R18.app/Contents/MacOS/
				cp -R $DIR/Library-MatPreviews/* /Applications/MAXON/CINEMA4D\ R18/library/materialpreviews
				chmod -R 755 /Applications/MAXON/CINEMA4D\ R18/CINEMA4D\ R18.app/Contents/MacOS/lib*
				chmod -R 755 /Applications/MAXON/CINEMA4D\ R18/CINEMA4D\ R18.app/Contents/MacOS/vray_stuff.dylib
				chmod -R 755 /Applications/MAXON/CINEMA4D\ R18/library/materialpreviews
			else
				printf "Cinema 4D R18 folder not detected\n"
				:
			fi
		fi
	fi
	#Check if Chaos Group stuff is installed - if not create Chaos Group directory and copy files
	if [ -d "$CGPATH" ]; then 
		cp -R $DIR/Applications-ChaosGroup /Applications/ChaosGroup/
		chmod -R 755 /Applications/ChaosGroup/bin
	else
		printf "Maya/Max Chaos Group plugins not detected - creating Chaos Group folder\n"
		mkdir /Applications/ChaosGroup
		chmod 755 /Applications/ChaosGroup
		cp -R $DIR/Applications-ChaosGroup /Applications/ChaosGroup/
		chmod -R 755 /Applications/ChaosGroup/bin
	fi
fi
exit
