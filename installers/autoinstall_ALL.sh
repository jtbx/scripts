#!/bin/sh
# Install everything in jtbx/scripts/installers
# https://github.com/jtbx/scripts

set -e

# Functions

doNothing()
{
	printf ""
}

detectDistro()
{
	DISTRO=unix
	[ -e /bin/apt    ] && [ -e /bin/dpkg ] && DISTRO="debian"
	[ -e /bin/dnf    ] && [ -e /bin/rpm  ] && DISTRO="redhat"
	[ -e /bin/zypper ] && [ -e /bin/rpm  ] && DISTRO="suse"
	[ -e /bin/pacman ] && DISTRO="arch"
}

msg_check()
{
	TEXT=$1
	printf "\t\033[32;1m✓\033[0m \033[1m$TEXT\033[0m\n"
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
	case $confirmChoice in
		y)
			doNothing
			;;
		Y)
			doNothing
			;;
		n)
			doNothing
			;;
		N)
			doNothing
			;;
		*)
			error "Invalid choice. Exiting..." ; exit 1
			;;
	esac
}

# End functions

# Check if running as root
[ $USER != "root" ] && error "Authentication failed. Try running the script as sudo." && exit 1

# Begin
clear
msg1 "jtbx/scripts/installers AutoInstall Script\n\t  https://github.com/jtbx/scripts\n"
enterPrompt

sleep 1

# LibreWolf
msg1 "Curling librewolf_INSTALL.sh..."
curl -fsSL https://raw.githubusercontent.com/jtbx/scripts/main/installers/librewolf_INSTALL.sh | sh
sleep 1
msg_check "\nLibreWolf completed. Next script..."

# dwm
msg1 "Curling dwm_INSTALL.sh..."
curl -fsSL https://raw.githubusercontent.com/jtbx/dwm/main/INSTALL.sh | sh
sleep 1
msg_check "dwm completed.\n"

msg_check "All installers have completed."
