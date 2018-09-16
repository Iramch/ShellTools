#!/bin/bash


phrase=""
RANDOM=`date +%N|sed s/...$//` 
for i in `seq 1 4`;
do
	index=$(( ($RANDOM % 6) + 1 ))$(( ($RANDOM % 6) + 1 ))$(( ($RANDOM % 6) + 1 ))$(( ($RANDOM % 6) + 1 ))$(( ($RANDOM % 6) + 1 ))
	word=$(grep $index $HOME/ShellTools/wordlist.txt | sed 's/[1-6]\{5\}\t//' | sed 's/\W/ /')
	phrase="$phrase $word" 
done

echo $phrase


