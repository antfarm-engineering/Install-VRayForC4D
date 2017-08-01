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

#Set path variables
R17PATH="/Applications/MAXON/CINEMA 4D R17"
R18PATH="/Applications/MAXON/CINEMA 4D R18"
CGPATH="/Applications/ChaosGroup"
CGBPATH="/Applications/ChaosGroup/bin"
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
			cp -R $DIR/C4DR17-C4DR17App-Contents-MacOS/* /Applications/MAXON/CINEMA\ 4D\ R17/CINEMA\ 4D.app/Contents/MacOS/
			cp -R $DIR/Library-MatPreviews/* /Applications/MAXON/CINEMA\ 4D\ R17/library/materialpreview/
			cp -R $DIR/C4DR17-plugins/* /Applications/MAXON/CINEMA\ 4D\ R17/plugins/
			chmod -R 755 /Applications/MAXON/CINEMA\ 4D\ R17/CINEMA\ 4D.app/Contents/MacOS/lib*
			chmod -R 755 /Applications/MAXON/CINEMA\ 4D\ R17/CINEMA\ 4D.app/Contents/MacOS/vray_stuff.dylib
			chmod -R 755 /Applications/MAXON/CINEMA\ 4D\ R17/library/materialpreview/*
			chmod -R 755 /Applications/MAXON/CINEMA\ 4D\ R17/plugins/VrayBridge/			
			printf "Solo R17 installed.\n"
		else
			printf "Cinema 4D R17 folder not detected\n"
			:
		fi
	elif [[ $REPLY == 2 ]]; then
		#Check if R18 is installed - if not move to exit
		if [ -d "$R18PATH" ]; then  
			cp -R $DIR/C4DR18-C4DR18App-Contents-MacOS/* /Applications/MAXON/CINEMA\ 4D\ R18/CINEMA\ 4D.app/Contents/MacOS/
			cp -R $DIR/Library-MatPreviews/* /Applications/MAXON/CINEMA\ 4D\ R18/library/materialpreview/
			cp -R $DIR/C4DR18-plugins/* /Applications/MAXON/CINEMA\ 4D\ R18/plugins/
			chmod -R 755 /Applications/MAXON/CINEMA4D\ R18/CINEMA\ 4D.app/Contents/MacOS/lib*
			chmod -R 755 /Applications/MAXON/CINEMA4D\ R18/CINEMA\ 4D.app/Contents/MacOS/vray_stuff.dylib
			chmod -R 755 /Applications/MAXON/CINEMA4D\ R18/library/materialpreview/*
			chmod -R 755 /Applications/MAXON/CINEMA\ 4D\ R18/plugins/VrayBridge/			
			printf "Solo R18 installed.\n"
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
				cp -R $DIR/C4DR17-C4DR17App-Contents-MacOS/* /Applications/MAXON/CINEMA\ 4D\ R17/CINEMA\ 4D.app/Contents/MacOS/
				cp -R $DIR/Library-MatPreviews/* /Applications/MAXON/CINEMA\ 4D\ R17/library/materialpreview/
				cp -R $DIR/C4DR17-plugins/* /Applications/MAXON/CINEMA\ 4D\ R17/plugins/
				chmod -R 755 /Applications/MAXON/CINEMA\ 4D\ R17/CINEMA\ 4D.app/Contents/MacOS/lib*
				chmod -R 755 /Applications/MAXON/CINEMA\ 4D\ R17/CINEMA\ 4D.app/Contents/MacOS/vray_stuff.dylib
				chmod -R 755 /Applications/MAXON/CINEMA\ 4D\ R17/library/materialpreview/*
				chmod -R 755 /Applications/MAXON/CINEMA\ 4D\ R17/plugins/VrayBridge/			
				printf "Combo part 1 - R17 Installed\n"
			else
				printf "Cinema 4D R17 folder not detected\n"
				:
			fi
			#Check if R18 is installed - if not move to exit
			if [ -d "$R18PATH" ]; then  
				cp -R $DIR/C4DR18-C4DR18App-Contents-MacOS/* /Applications/MAXON/CINEMA\ 4D\ R18/CINEMA\ 4D.app/Contents/MacOS/
				cp -R $DIR/Library-MatPreviews/* /Applications/MAXON/CINEMA\ 4D\ R18/library/materialpreview/
				cp -R $DIR/C4DR18-plugins/* /Applications/MAXON/CINEMA\ 4D\ R18/plugins/
				chmod -R 755 /Applications/MAXON/CINEMA\ 4D\ R18/CINEMA\ 4D.app/Contents/MacOS/lib*
				chmod -R 755 /Applications/MAXON/CINEMA\ 4D\ R18/CINEMA\ 4D.app/Contents/MacOS/vray_stuff.dylib
				chmod -R 755 /Applications/MAXON/CINEMA\ 4D\ R18/library/materialpreview/*
				chmod -R 755 /Applications/MAXON/CINEMA\ 4D\ R18/plugins/VrayBridge/			
				printf "Combo part 2 - C4D R18 Installed\n"
			else
				printf "Cinema 4D R18 folder not detected\n"
				:
			fi
		fi
	fi
	#Check if Chaos Group stuff is installed - if not create Chaos Group directory and copy files
	if [ -d "$CGPATH" ]; then 
		if [ -d "$CGBPATH" ]; then
			printf "Vray for C4D bin folder already exists. Skipping step.\n"
			:
		else
			cp -R $DIR/Applications-ChaosGroup/* /Applications/ChaosGroup/
			chmod -R 755 /Applications/ChaosGroup/bin
		fi
	else
		printf "Maya/Max Chaos Group plugins not detected - creating Chaos Group folder\n"
		mkdir /Applications/ChaosGroup
		chmod 755 /Applications/ChaosGroup
		cp -R $DIR/Applications-ChaosGroup/* /Applications/ChaosGroup/
		chmod -R 755 /Applications/ChaosGroup/bin
	fi
fi
exit
