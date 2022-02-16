#!/usr/bin/env bash

# This is a simple bash script that exemplifies a few bash scripting features

echo "you called the script with ${#} arguments"

# check if we have no or more arguments than needed
if [ $# -eq 0 ] || [ $# -gt 2 ]; then
	# if not get script name (not working when invoked with "source")
	scriptname=$(basename $0)
	# complain
	echo -e "please call me using \n\t./${scriptname} [STRING] [LENGTH]\n or \n\tbash ${scriptname} [STRING] [LENGTH]\nwhere [LENGTH] is optional."
	# and exit the script
	exit 1 # a return value != 0 indicates an error/failure of the script
fi

# this is a selfdefined function for some output below
function printInput {
	if [ "$3" == "" ]; then
		echo "# arg $1 was not provided"
	else
		echo "# given ${1}. arg \$$2 = '${3}'"
	fi
}

# let's repeat the user's input using our selfdefined function
printInput 1 STRING $1
printInput 2 LENGTH $2

# init variable from first argument
STRING=$1
# init variable from second argument or default if not given
LENGTH=${2:-1}

# get number of characters in given string
STRINGLENGTH=${#STRING}

# compute maximal start index = length of input minus substring length (to get only full substrings)
MAXINDEX=$(($STRINGLENGTH -$LENGTH))

function printSubstring {
	echo -n " '${STRING:$i:$1}'"
}

# print all substrings of length=$LENGTH (one for each position in STRING)
echo -n "substrings of length $LENGTH are:"
for i in $(seq 0 $MAXINDEX); do
	echo -n " '${STRING:$i:$LENGTH}'"
	printSubstring $i
done
echo # final line break after listing
