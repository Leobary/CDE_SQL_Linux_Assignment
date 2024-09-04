#!/bin/bash


## Solution 2
#  A crontab job to run daily at 12:00 am

#crontab -e -> used to open crontab file for editing

# chmod +x /$PATH/test.sh -> grants execute mode to the .sh file

# the below reads to 0th minute, 0th hour, every day, every month, every week
# hence, the cron job would run daily at 12:00am

0 0 * * * /$PATH/cde_etl.sh