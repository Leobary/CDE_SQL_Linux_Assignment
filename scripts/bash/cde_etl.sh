#!/bin/bash

## Solution 1

# ************** Extraction Phase ********************

#pass the link into a variable called URL
export URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"

echo "Extracting and downloading file ..."

#creates the folder(assignment) and subfolder(raw) 
#also downloads the file from the URL and gives it the basename
mkdir -p assignment/raw && curl -L $URL -o assignment/raw/$(basename "$URL")

echo "Download completed!"
sleep 2s

#change directory
cd assignment/raw

#list content of the folder
ls -l

filename=$(basename "$URL")

#Confirm that the file has been saved to raw folder
[ -f $filename ] && echo "File exists." || echo "File does not exist."


# ************** Transformation Phase ********************

#sample of the first 5 rows of the file
echo "This is a sample of the first 5 rows ..."
echo
head -5 $filename
echo
echo "File undergoing transformation ..."

#rename the column named Variable_code to variable_code
sed -i '1s/Variable_code/variable_code/' $filename

#selects only the columns: year(1), Value(9), Units(5), variable_code(6)
#and saves the content of these columns into a new_file called 2023_year_finance.csv

cut -f 1,9,5,6 -d , $filename > 2023_year_finance.csv

#sample of the first 5 rows of the transformed file
echo
echo "This is a sample of the first 5 rows of the transformed file ..."
head -5 2023_year_finance.csv
echo

#new_file is moved to a new_folder called Transformed
mkdir ../Transformed

cp 2023_year_finance.csv ../Transformed

#change directory
cd ../Transformed

#declared a variable called transformed_file
transformed_file='2023_year_finance.csv'

#Confirm that the file has been saved to Transformed folder
[ -f $transformed_file ] && echo "File exists." || echo "File does not exist."


# ************** Loading Phase ********************

#Load the transformed data into a directory named Gold
mkdir ../Gold
echo
echo "File loading ..."
echo
cp $transformed_file ../Gold

#confirm that the file has been saved into the folder
cd ../Gold
[ -f $transformed_file ] && echo "File exists and successfully loaded!" || echo "File does not exist."




