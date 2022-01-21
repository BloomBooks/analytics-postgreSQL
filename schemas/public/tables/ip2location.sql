-- This file contains instructions for updating the ip2location table.
-- These steps are based on the instructions in https://docs.google.com/document/d/1LPjtHsab7b_gBN_Ifwic2BrtfQt3KE2Jn6ZilB_eD0A/edit,
-- but more scripted/automatic and less manual steps.
--
-- 1) Backup existing table (if needed)
-- Optional - Determine the date of the last update. If a table already exists named public/ip2location_as_of_[dateOfLastUpdate], then you are done. Skip to step 2.
-- Otherwise, copy public/ip2location to public/ip2location_up_to_[today'sDate]
-- You can use bash-scripts/ip2location-step0-backup.sh to create the "up_to" table backups if needed. Set the boolean flags at the top of the script.

-- 2) Download input data
-- The input data comes from https://lite.ip2location.com/
-- This data is updated on the first of each month.
-- You need an account in order to download it, but signing up for the account is free (with attribution).
-- Find download instructions at the top of bash-scripts/ip2location-step1-uploadNewData.sh

-- 3) Upload input data to new tables
-- Run bash-scripts/ip2location-step1-uploadNewData.sh using Cygwin

-- 4) Review the new tables to ensure data looks ok

-- 5) Run bash-scripts/ip2location-step2-createUpdateCommands.sh to prepare the SQL update commands

-- 6) Review the SQL commands generated at bash-scripts/temp_psqlUpdateCommands.txt.
--    Make sure all the commands look right, especially the table names.

-- 7) To update the database for real, run "bash-scripts/ip2location-step2-createUpdateCommands.sh --execute"
--    Note the "--execute" flag argument, which causes the script to update it for real.
--
-- Note: I do not recommend deleting the _as_of tables. We want to keep them around to have a historical archive.