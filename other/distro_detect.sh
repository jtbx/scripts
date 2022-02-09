#!/bin/sh
# Script to detect a distribution of a user.
# It detects what package manager exists, and that determines the distro.
# The distribution goes into $DISTRO, but this can be changed, of course.

# Based on the original package managers
#[ -e /bin/dpkg   ] && DISTRO="debian"
#[ -e /bin/rpm    ] && DISTRO="redhat"
#[ -e /bin/pacman ] && DISTRO="arch"

# More narrow way of doing it
#[ -e /bin/apt    ] && [ -e /bin/dpkg ] && DISTRO="debian"
#[ -e /bin/dnf    ] && [ -e /bin/rpm  ] && DISTRO="redhat"
#[ -e /bin/zypper ] && [ -e /bin/rpm  ] && DISTRO="suse"
#[ -e /bin/pacman ] && DISTRO="arch"
# You could do /bin/makepkg here ^^^ but systems that don't have base-devel don't have makepkg

# Based on just the frontends
[ -e /bin/apt    ] && DISTRO="debian"
[ -e /bin/dnf    ] && DISTRO="redhat"
[ -e /bin/zypper ] && DISTRO="suse"
[ -e /bin/pacman ] && DISTRO="arch"

# Echo the distribution (testing)
#echo $DISTRO
