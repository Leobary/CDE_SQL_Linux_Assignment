#!/bin/bash

# define postgres database connection variables

db_name="posey"
db_user="postgres"
db_host="localhost"
db_port="5432"

# define a variable to create schema and necessary tables in the database

schema_sql="
CREATE SCHEMA IF NOT EXISTS cde;

CREATE TABLE IF NOT EXISTS cde.accounts (
	id INTEGER PRIMARY KEY,
	name VARCHAR(50),
	website VARCHAR(50),
	lat NUMERIC,
	long NUMERIC,
	primary_poc VARCHAR(50),
	sales_rep_id INTEGER
	);
	
CREATE TABLE IF NOT EXISTS cde.orders (
	id INTEGER PRIMARY KEY,
	account_id INTEGER,
	occurred_at TIMESTAMP,
	standard_qty INTEGER,
	gloss_qty INTEGER,
	poster_qty INTEGER,
	total INTEGER,
	standard_amt_usd NUMERIC,
	gloss_amt_usd NUMERIC,
	poster_amt_usd NUMERIC,
	total_amt_usd NUMERIC
	);
	
CREATE TABLE IF NOT EXISTS cde.region (
	id INTEGER PRIMARY KEY,
	name VARCHAR(50)
	);
	
CREATE TABLE IF NOT EXISTS cde.sales_reps (
	id INTEGER PRIMARY KEY,
	name VARCHAR(50),
	region_id INTEGER
	);
	
CREATE TABLE IF NOT EXISTS cde.web_events (
	id INTEGER PRIMARY KEY,
	account_id INTEGER,
	occurred_at TIMESTAMP,
	channel VARCHAR(50)
	);
"

# The required csv files are downloaded to your local machine using the link below

url="https://wetransfer.com/downloads/b04296265aee9fe85d21c2da088564c720240828210323/c88ae0"

# change directory into the path where the download zip file is store on your local computer
# also create a folder to hold the unzipped files
cd sql_assignment
mkdir -p unzipcsv

# a function to unzip the csv files

unzip_csv() {
	
	echo "Unzipping csv files ..."
	
	# to unzip csv files
	unzip wetransfer_parch_posey_data.zip -d ./unzipcsv
	
	echo "csv files unzip completed."
	echo
	sleep 2s
}

# a function to create database, schema and tables in postgreSQL db_host
create_db_schema() {
	echo "Creating $db_name database ..."
	
	# the DB is password-protected (default is postgres)
	read -s -p "Enter PostgreSQL password for $db_user user: " db_password
	echo
	
	# Use PGPASSWORD environment variable to give access to psql
	#PGPASSWORD="$db_password" psql -h "$db_host" -U "$db_user" -p "$db_port" -c "CREATE DATABASE $db_name;"
	
	PGPASSWORD=$db_password createdb -h $db_host -U $db_user -p $db_port $db_name
	
	echo "$db_name database created"
	echo
	sleep 2s
	
	# to create schema and tables using the schema_sql variable
	echo "Creating schema and tables ..."
	
	PGPASSWORD=$db_password psql -h $db_host -U $db_user -d $db_name -p $db_port -c "$schema_sql"
	
	echo "Schema and tables created successfully!"
	echo
	sleep 2s
}

# a function to load csv files in postgreSQL tables
load_csv() {
	
	# define a variable to the folder where the csv files are stored
	files="./unzipcsv/*.csv"
	
	# loops through the folder to get file details
	for file in $files; do
	
		# Variable to hold the basename of each file as filename and tablename respectively
		filename=$(basename $file)
		tablename="cde."$(basename $file .csv)
		
		# Use the COPY command of psql to load data into the PostgreSQL tables
		echo "Copying $filename into table -> $tablename ..."

		# Using double quotes around variables to handle file paths with spaces
		PGPASSWORD=$db_password psql -h $db_host -U $db_user -d $db_name -p $db_port -c "\COPY $tablename FROM $file CSV HEADER"

		if [ $? -eq 0 ]; then
			echo "Successfully copied $filename into table $tablename."
		else
			echo "Copying $filename into table $tablename failed!"
		fi
		echo
	done
	
	
}

# Execution stages using the defined functions above
unzip_csv
create_db_schema
load_csv

echo "Successfully completed!"


#if [ $? -eq 0 ]; then
	#echo "Schema and tables created successfully!"
#else
	#echo "Failed to create schema and tables."
	#exit 1
#fi