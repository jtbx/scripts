#!/bin/sh
# Script to install Deno on systems that don't have Deno in their repositories.
# https://github.com/jtbx/scripts

# Functions

doNothing()
{
	printf ""
}

isRoot()
{
	# Am I root?
	if [ $USER = "root" ];
		then root=true;
		else root=false;
	fi
}

detectDistro()
{
	DISTRO=unix
	[ -e /bin/apt    ] && [ -e /bin/dpkg ] && DISTRO="debian"
	[ -e /bin/dnf    ] && [ -e /bin/rpm  ] && DISTRO="redhat"
	[ -e /bin/zypper ] && [ -e /bin/rpm  ] && DISTRO="suse"
	[ -e /bin/pacman ] && DISTRO="arch"
}

msg1()
{
	TEXT=$1
	printf "\t\033[32;1m*\033[0m \033[1m$TEXT\033[0m\n"
}

msg2()
{
	TEXT=$1
	printf "\t\033[34;1m*\033[0m \033[1m$TEXT\033[0m\n"
}

error()
{
	TEXT=$1
	printf "\t\033[31;1m*\033[0m \033[1m$TEXT\033[0m\n"
}

inputInto()
{
	printf "\t\033[34;1m->\033[0m"
	read -p " " $1
}

selectiveList()
{
	ENTRY1=$1
	ENTRY2=$2
	ENTRY3=$3
	ENTRY4=$4
	ENTRY5=$5
	ENTRY6=$6
	ENTRY7=$7
	ENTRY8=$8
	printf "\t\033[7m1\033[0m $ENTRY1\n"
	printf "\t\033[7m2\033[0m $ENTRY2\n"
	if [ -z $3 ]; then doNothing; else printf "\t\033[7m3\033[0m $ENTRY3\n"; fi
	if [ -z $4 ]; then doNothing; else printf "\t\033[7m4\033[0m $ENTRY4\n"; fi
	if [ -z $5 ]; then doNothing; else printf "\t\033[7m5\033[0m $ENTRY5\n"; fi
	if [ -z $6 ]; then doNothing; else printf "\t\033[7m6\033[0m $ENTRY6\n"; fi
	if [ -z $7 ]; then doNothing; else printf "\t\033[7m7\033[0m $ENTRY7\n"; fi
	if [ -z $8 ]; then doNothing; else printf "\t\033[7m8\033[0m $ENTRY8\n"; fi
	inputInto listChoice
}

enterPrompt()
{
	printf "\t\033[34;1m>\033[0;1m Press Enter to begin \033[34;1m<\033[0m"
	read -p "" tempvar
}

confirmation()
{
	msg2 $1
	printf "\t\033[34;1m->\033[0m"
	read -p " " confirmChoice
}

# End functions

msg1 "Deno Installation Script\n\t  https://github.com/jtbx/scripts"

enterPrompt

msg2 "Select the install location."
selectiveList "/bin (System-wide, recommended)" "$HOME/bin (Your user only)" "Custom location..."
[ $listChoice = 1 ] && msg2 "Selected /bin as the install location."; INSTLOCATION=/bin
[ $listChoice = 2 ] && msg2 "Selected $HOME/bin as the install location."; INSTLOCATION=$HOME/bin
[ $listChoice = 3 ] && msg2 "Enter the custom location: "; inputInto customLocation && confirmation "Are you sure you want to install Deno into $customLocation? You may need to add it to your PATH later. [y/n]"

