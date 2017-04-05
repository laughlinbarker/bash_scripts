#!/bin/bash
# This script (attempts) to clone each student's homework from the LCSR git server, and save to a directory given by their JHEDID.
# It takes the expected repo name as the command argument, like this: 
# ./hwCloner.sh beginner_tutorials
#
# hwCloner.sh - 02/16/2017 Laughlin Barker

#place list of jhedid's here; one per line

JHEDIDS="jsmith4
jdoe1
"



ASSIGNMENT=$1

$(touch $ASSIGNMENT.txt)

echo "JHEDID,assignment,clone_status,current_date,head_commit_time,build_success" >> $ASSIGNMENT.txt


for jhedid in $JHEDIDS
do
	if [ ! -d "$jhedid" ]; then  #Check if student's folder exists, if not, make it
		mkdir "$jhedid"
		echo "Making $jhedid folder"; echo
	fi
	
	echo "Downloading $jhedid assignment:$ASSIGNMENT"; echo

	cd $jhedid;

	clone_failed="false"

	# clone_failed var only runs if git clone command fails	
	git clone git@git-teach.lcsr.jhu.edu:$jhedid/$ASSIGNMENT.git || clone_failed="true"

	if [ $clone_failed = "true" ]; then
		echo "CLONE FAILURE:$jhedid"; echo      
		
		cd ../
	        
		#Make note of inability to pull assignment
        	echo "$jhedid,$ASSIGNMENT,FAILURE,$(date),," >> $ASSIGNMENT.txt

        	#Note failures in single file, for easier reference
        	echo "$jhedid,$ASSIGNMENT" >> FAILURES.txt

	else
		#Get time of last commit
        	cd $ASSIGNMENT 
        	commit_time="$(git rev-list --format=format:'%ai' --max-count=1 `git rev-parse HEAD` |tail -n 1)"

        	cd ../../;
        
        	echo "$jhedid,$ASSIGNMENT,SUCCESS,$(date),$commit_time," >> $ASSIGNMENT.txt

	fi

sleep 3
	
done

exit 0
