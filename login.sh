#!/bin/bash
number=$1

# Test for number
if ! [[ $number =~ ^[0-9]+$ ]]; then
	echo Please enter a number.
	exit 1
fi

# Get password if exists, otherwise prompt
if ! [[ -f "passwords/$number" ]]; then
	echo -n 'Enter password: '
	read password
	echo $password > "passwords/$number"
fi

sshpass -v -f passwords/$number ssh -p 2220 bandit$number@bandit.labs.overthewire.org
