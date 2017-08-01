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
APPPATH="Applications/MAXON"
R17PATH="/Applications/MAXON/CINEMA 4D R17"
R18PATH="/Applications/MAXON/CINEMA 4D R18"
CGPATH="/Applications/ChaosGroup"
CGBPATH="/Applications/ChaosGroup/bin"
HOSTNAME=$(hostname)

#Verify that the user wants to overwrite files
printf "WARNING!! you will be overwriting files if they exist.\n"
read -p  "Please confirm (y|n) - Default n :  " -n 1 -r  
echo
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	#Figure out which version(s) of C4D need VRay
	read -p "Do you want to install for R17 (1), R18 (2) or both (3):  " -n 1 -r
	echo
	echo
	echo
	if	[[ $REPLY == 1 ]]; then
		#Check if R17 is installed - if not move to R18
		if [ -d "$R17PATH" ]; then  
			if [ -d "$CGPATH" ]; then
				tar -Pxf $DIR/vrayforc4d-R17.tar.gz
				printf "R17 VRay for C4D have been installed\n\n"
				printf "Copy the appropriate license key to the C4D folder and test please.\n\n"
			else
				mkdir /Applications/ChaosGroup
				chmod 755 /Applications/ChaosGroup
				tar -Pxzf $DIR/vrayforc4d-R17.tar.gz
				printf "R17 VRay for C4D have been installed\n\n"
				printf "Copy the appropriate license key to the C4D folder and test please.\n\n"
			fi
		else
			printf "Cinema 4D R17 folder not detected - exiting\n\n"
			exit
		fi
	elif [[ $REPLY == 2 ]]; then
		#Check if R18 is installed - if not move to exit
		if [ -d "$R18PATH" ]; then  
			if [ -d "$CGPATH" ]; then
				tar -Pxf $DIR/vrayforc4d-R18.tar.gz
				printf "R18 VRay for C4D have been installed\n\n"
				printf "Copy the appropriate license key to the C4D folder and test please.\n\n"
			else
				mkdir /Applications/ChaosGroup
				chmod 755 /Applications/ChaosGroup
				tar -Pxzf $DIR/vrayforc4d-R18.tar.gz
				printf "R18 VRay for C4D have been installed\n\n"
				printf "Copy the appropriate license key to the C4D folder and test please.\n\n"
			fi
		else
			printf "Cinema 4D R18 folder not detected - exiting\n\n"
			exit
		fi
	else
		if [[ $REPLY != 3 ]]; then 
			printf "Incorrect input detected - please rerun script to try again\n\n"
			exit
		else
			#Check if R17 and R18 are installed - if not move to R18
			if [ -d "$R17PATH" ] && [ "$R18PATH" ]; then  
				if [ -d "$CGPATH" ]; then
					tar -Pxf $DIR/vrayforc4d-R17R18.tar.gz
					printf "R17 and R18 VRay for C4D have been installed\n\n"
					printf "Copy the appropriate license key to the C4D folder and test please.\n\n"
				else
					mkdir /Applications/ChaosGroup
					chmod 755 /Applications/ChaosGroup
					tar -Pxzf $DIR/vrayforc4d-R17R18.tar.gz
				printf "R17 and R18 VRay for C4D have been installed\n\n"
				printf "Copy the appropriate license key to the C4D folder and test please.\n\n"
				fi
			else
				printf "Cinema 4D R17 & R18 folder not detected - exiting\n"
				exit
			fi
		fi
	fi
fi
exit
