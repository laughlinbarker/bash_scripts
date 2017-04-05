#!/bin/bash
#This quick 'n dirty script diffs all the files in the current directory, and generates a list of duplicate files.
#TODO: Currently inefficient as it will diff A B and at a later time diff B A. Fix this.
#TODO: Adjust to possibly diff contents of different directories. 
outputFile="DiffReport.txt"

$(touch $outputFile)

#First file
for fileA in *; do 

	#Second File
	for fileB in *; do 
	
	#we don't care about comparing a file to itself,
	if [ "$fileA" != "$fileB" ]; then

		# cmp exit status is 0 if inputs the same, 1 if diferent
		# -s surpresses output (difference between files)
		cmp -s $fileA $fileB
		result=$?
		if [ "$result" -eq "0" ]; then
			echo "$fileA and $fileB are Identical!" >> $outputFile
		fi
	fi
	done
done
