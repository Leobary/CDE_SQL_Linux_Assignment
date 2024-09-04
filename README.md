# Linux, Git and SQL Assignment

This assignment is part of the requirement to fulfill the participation in the **CDE BootCamp Cohort 1**

### Task 1: A simple ETL process using *Bash Scripting*

#### Methodology

This involves using a well sequenced and detailed bash script to perform ETL (Extract, Transform and Load) on a csv file downloade via a URL link. The different stages
for this process are captured below.

- **Extract:** The csv file used for this task can be downloaded by clicking on this [link](https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv).
The file is saved to a folder called `raw`.

- **Transform:** The column named `Variable_code` in the csv file is renamed `variable_code`. Also columns, `year`, `value`, `units` and `variable_code` are selected 
and saved to a csv file called `2023_year_finance.csv`. After which the csv file is saved in a folder called `Transformed`.

- **Load:** The csv file in transformed folder in then loaded in a folder called `Gold`.

The `cde_etl.sh` script to carry out this ETL process is located in the sub-folder, `bash` inside the `scripts` folder.

### Task 2: A scheduler using *cron jobs*

#### Methodology

To carry out *Task 1* above, a crontab job has been schedule to run daily at 12:00am. This job is run by the `cron_job.sh` in the `bash` sub-folder.

### Task 3: Moving of CSV and JSON files using *Bash Scripting*

#### Methodology

This is a simple script written to move one or more csv and json files from one folder to another. The `move_json_csv.sh` script in the `bash` sub-folder
helps to achieve this task seamlessly.

### Task 4: Case Study of Posey database using *Bash and SQL*

CoreDataEngineers is diversifying into the sales of goods and services. To understand the market, my organization needs to analyze our competitor,
Parch and Posey. 

#### Methodology

- Download a csv file containing the required data to populate a database called `posey` by clicking this [link]("https://wetransfer.com/downloads/b04296265aee9fe85d21c2da088564c720240828210323/c88ae0").

- The downloaded file is zipped. A bash script, `load_csv_sql.sh` is used to unzip the file, create a database called `posey`, create a schema called `cde`,
create various tables using the unzipped files (`orders`, `accounts`, `web_events`, `region`, `sales_reps`) as the basename for the tables and load the files into them.

- The SQL queries, `queries.sql` used to solve the questions posed can be found in the `sql` sub-folder.

#### Questions posed and their corresponding queries

1. Find a list of order IDs where either gloss_qty or poster_qty is greater than 4000. Only include the id field in the resulting table.

	Query:
	```
	SELECT id FROM orders
	WHERE gloss_qty > 4000 OR poster_qty > 4000;
	```
2. Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000.

	Query:
	```
	SELECT * FROM orders
	WHERE standard_qty = 0 
	AND (gloss_qty > 1000 OR poster_qty > 1000);
	```
3. Find all the company names that start with a 'C' or 'W', and where the primary contact contains 'ana' or 'Ana', but does not contain 'eana'.

	Query:
	```
	SELECT * FROM accounts
	WHERE (name LIKE 'C%' OR name LIKE 'W%')
	AND (primary_poc LIKE 'Ana%' OR primary_poc LIKE '%ana%')
	AND (primary_poc NOT LIKE '%eana%');
	```
4. Provide a table that shows the region for each sales rep along with their associated accounts. Your final table should include three columns: 
the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) by account name.

	Query:
	```
	SELECT  TRIM(r.name) region_name, TRIM(s.name) sales_rep_name, TRIM(a.name) account_name
	FROM accounts a 
	LEFT JOIN sales_reps s ON s.id = a.sales_rep_id
	LEFT JOIN region r ON r.id = s.region_id
	ORDER BY 3 ASC;
	```
	
**N.B:** The `Scripts` folder has two sub-folders, `Bash` and `SQL` which contains all the bash and SQL scripts used for this project.