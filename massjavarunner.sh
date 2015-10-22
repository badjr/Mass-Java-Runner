#!/bin/bash

# How to use:
# massjavarunner.sh or massjavarunner.sh inputfile1, inputfile2, inputfile3, ...
# If input file arguments supplied, each input file is used to feed stdin input to the Java programs.

processedfolder="./processed/" #folder to place processed Java files in.
# The files here will have the output followed by the original source code in a .txt file.

# Makes dir if doesn't already exist.
mkdir -p $processedfolder

for i in *.java; #For all .java files in this directory

do (	
	base=$(basename $i .java) #base is the file name without extension
	
	if [ $# -ge 1 ] #if argument(s) supplied, use argument(s) as input file(s) for feeding stdin input to Java programs.
	then
		iteration=0
		for inFileIdx in "$@" #for all input files
		do

			javaMethodRegex="((public|static|private|protected|\s)*(void|int|String|double|float)\s+\w+\s*\(\s*[^)]*\)\s*)"
			
			#This sed does the following:
			#1. puts throws exception for main (only needed for programs that read input)
				# so we don't have to put a try catch around the File object.
			#2. removes package statement
			#3. renames class to file name
			#4. removes public, and renames class to file name
			#5. Puts System.in for the file to read
			# The i.bak makes the backup files, which aren't changed.
			sed -i.bak -r -e "s/$javaMethodRegex/\1throws java.lang.Exception / g" \
			-e "s/^[ |\t]*package .*//g" \
			-e "s/^[ |\t]*class ([a-zA-Z0-9_]*)([ ]*\{)*/class $base \2/g" \
			-e "s/^[ |\t]*public class ([a-zA-Z0-9_]*)([ ]*\{)*/class $base \2/g" \
			-e "s/System.in/new java.io.File(\"$inFileIdx\")/g" $i
			
			#debug print
			#cat $i
			
			#compile modified file
			javac $i
			
			if [ $iteration -eq 0 ]; then
				# Replaces file if it exists already, so we don't append it to older runs of "massjavarunner.sh"
				java $base > $processedfolder"$base.txt"
			else
				#run modified file, append to txt file
				# Want to append the outputs from the different input files.
				java $base >> $processedfolder"$base.txt"
			fi
			
			#append hor bar
			echo -e "\n------------------------------------------" >> $processedfolder"$base.txt"
			
			#remove edited file
			rm $i			
			
			#rename backup file back to original file name
			mv $i.bak $i			
			
			#cat $i #debug to print the modified file to see if regexes were replaced correctly

			((iteration++))
		done
		
		#append original java source to output
		cat $i >> $processedfolder"$base.txt"
	
		#remove class file
		rm "$base.class"
		
	else

		#This sed does the following:
		#1. removes package statement
		#2. renames class to file name
		#3. removes public, and renames class to file name
		# The i.bak makes the backup files, which aren't changed.
		sed -r -i.bak -e "s/^[ |\t]*package .*//g" \
		-e "s/^[ |\t]*class ([a-zA-Z0-9_]*)([ ]*\{)*/class $base \2/g" \
		-e "s/^[ |\t]*public class ([a-zA-Z0-9_]*)([ ]*\{)*/class $base \2/g" $i
		
		#cat $i #debug to print the modified file to see if regexes were replaced correctly
	
		#compile modified file
		javac $i
	
		#run and redirect output to .txt file in location specified above
		java $base > $processedfolder"$base.txt"
	
		#append horizontal bar to .txt file
		echo -e "\n------------------------------------------" >> $processedfolder"$base.txt"
	
		#append original java source to output
		cat $i.bak >> $processedfolder"$base.txt"
	
		#remove edited file
		rm $i

		#rename backup file back to original file name
		mv $i.bak $i
	
		#remove class file
		rm "$base.class" 
	fi
	) &

done

wait
