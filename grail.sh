#!/bin/bash

#set the default file name
filename="$HOME/ShellTools/default"
#make a mutable copy of the input array
input="$@"

#printing the help text
if [ -z $1 ]
then
	echo "jgrep <Filename> <Prime Term> <Additional Terms>"
	echo "<Filename> : the file to be searched. If not included will search $filename"
	echo "<Prime Term> : A space delimited word to search for in the file"
	echo "<Additional Terms> : Any other filters you want to apply, not space delimited."
	echo ""
	echo "Will first grep the file for the terms, then it will tail the file with those terms as well."
	echo ""
	exit 0;
fi

#if a file name was the first input
if [ -f $1 ]
then
	#replace the file name with user defined one
	filename="$1"
	#remove the found file name from the input array
	input=$(echo $input | sed "s/$1 //")
fi

#make an empty string for the filter array
filters=""
#make a copy of the file name, will be made empty after the first iteration
#of the parse additional terms loop
temp_filename="$filename"
#the "exact term" flag used on only the first search term, will also be made 
#empty after the first loop
username_flag="-w"

#for each of the input filters
for filter in $input;
do
	#append the new filter to the filter terms.
	filters="$filters grep $username_flag \"$filter\" $temp_filename |"
	#empty the terms that are only used once.
	temp_filename=""
	username_flag=""
done

#remove the trailing pipe
filters=$(echo $filters | sed "s/|$//" )

#run the grep
eval $filters
echo "------- STARTING TAIL -------"
#rewrite the filters for the tail and run the tail
eval "tail -f $filename | $( echo $filters | sed 's/grep/grep --line-buffered/g' | sed 's,'"$filename"',,g' )"

exit 0

