#!/bin/sh
# Script to decide based on 1-10

action_1 () {
	# If 1 is selected, do this:
	echo "1 was selected."
}

action_2 () {
	# If 2 is selected, do this:
	echo "2 was selected."
}

action_3 () {
	# If 3 is selected, do this:
	echo "3 was selected."
}

action_4 () {
	# If 4 is selected, do this:
	echo "4 was selected."
}

action_5 () {
	# If 5 is selected, do this:
	echo "5 was selected."
}

action_6 () {
	# If 6 is selected, do this:
	echo "6 was selected."
}

action_7 () {
	# If 7 is selected, do this:
	echo "7 was selected."
}

action_8 () {
	# If 8 is selected, do this:
	echo "8 was selected."
}

action_9 () {
	# If 9 is selected, do this:
	echo "9 was selected."
}

action_0 () {
	# If 0 is selected, do this:
	echo "0 was selected."
}

RANDOMNO=$(shuf -n 1 -i 0-9)

if   echo "$RANDOMNO" | grep -Eq "^1";
then action_1;
elif echo "$RANDOMNO" | grep -Eq "^2";
then action_2;
elif echo "$RANDOMNO" | grep -Eq "^3";
then action_3;
elif echo "$RANDOMNO" | grep -Eq "^4";
then action_4;
elif echo "$RANDOMNO" | grep -Eq "^5";
then action_5;
elif echo "$RANDOMNO" | grep -Eq "^6";
then action_6;
elif echo "$RANDOMNO" | grep -Eq "^7";
then action_7;
elif echo "$RANDOMNO" | grep -Eq "^8";
then action_8;
elif echo "$RANDOMNO" | grep -Eq "^9";
then action_9;
elif echo "$RANDOMNO" | grep -Eq "^0";
then action_0;
fi
