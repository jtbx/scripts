#!/bin/sh
# Script to install LibreWolf
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

install_arch()
{
	msg1 "Installing AUR package 'librewolf-bin' manually..."
	git clone https://aur.archlinux.org/librewolf-bin.git /tmp/librewolf_INSTALL.sh.tmp
	cd /tmp/librewolf_INSTALL.sh.tmp
	makepkg -sci
}

install_debian()
{
	msg1 "Installing package 'librewolf' from https://deb.librewolf.net..."
	echo "deb [arch=amd64] http://deb.librewolf.net $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/librewolf.list
	wget https://deb.librewolf.net/keyring.gpg -O /etc/apt/trusted.gpg.d/librewolf.gpg
	apt update
	apt install librewolf -y
}

install_redhat()
{
	msg1 "Installing package 'librewolf' from https://rpm.librewolf.net..."
	rpm --import https://keys.openpgp.org/vks/v1/by-fingerprint/034F7776EF5E0C613D2F7934D29FBD5F93C0CFC3
	dnf config-manager --add-repo https://rpm.librewolf.net
	dnf update
	dnf install librewolf -y
}

install_rpm()
{
	msg1 "Installing rpm package 'librewolf-96.0-1.fc35.x86_64.rpm' from librewolf.io..."
	msg2 "Note: This will not auto-update with your other packages.\n\t  You will be required to go to this website: https://librewolf.net/installation/fedora/ and install the .rpm file manually." ; sleep 5
	rpm -i https://fresh.librewolf.io/librewolf-96.0/librewolf-96.0-1.fc35.x86_64.rpm
}
# End functions

# Check if running as root
[ $USER != "root" ] && error "Authentication failed. Try running the script as sudo." && exit 1

# Begin
clear
msg1 "LibreWolf Installation Script\n\t  https://github.com/jtbx/scripts\n"
enterPrompt

# Detect distro and install
msg1 "Detecting distribution..."
detectDistro
msg2 "Detected distribution: $DISTRO"
msg1 "Installing dependencies..."
[ $DISTRO = arch   ] && install_arch
[ $DISTRO = redhat ] && install_redhat
[ $DISTRO = suse   ] && install_rpm
[ $DISTRO = debian ] && install_debian

msg_check "Installation completed."
