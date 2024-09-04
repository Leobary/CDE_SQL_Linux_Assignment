#!/bin/bash

## Solution 3

# A Bash script to move all CSV and JSON files from one folder to another folder named json_and_CSV

# Create variables for the source and target folders
user_path="C:/Users/HP/Desktop/CDE"
source_folder=$user_path/Linux_Git
target_folder=$user_path/Linux_Git/json_and_CSV

# Creates the target folder if it does not exist
mkdir -p $target_folder

# Move all .csv and .json files from the source directory to the target directory
echo "Moving all .csv and .json files ..."
mv $source_folder/*.csv $source_folder/*.json $target_folder
sleep 2s

# Print message
echo "All .csv and .json files have been moved from $source_folder to $target_folder."

