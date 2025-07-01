#!/bin/sh
# (These comments have been incorporated and expanded upon in UPDATE-IP-TABLES.md
# Preconditions
# 1) psql must be accessible, either on the PATH or you can run this script from the directory containing the psql executable.
# The folder is normally something like C:\Program Files\PostgreSQL\13\bin. (Replace 13 with whatever version number of PostgreSQL you have))
# 2) Manually download the files and place them in the ./downloads directory.
#    (I tried to use wget, but it didn't cooperate, so we can just do it manually)
#    Go to https://lite.ip2location.com/database-download.  (This will require login.)
#    Download the following three files
#      a) IP-COUNTRY (IPv4, CSV): https://lite.ip2location.com/download?id=1
#      b) IP-COUNTRY-REGION-CITY (IPv4, CSV): https://lite.ip2location.com/download?id=3
#      c) IP-COUNTRY-REGION-CITY (IPv6, CSV): https://lite.ip2location.com/download?id=13
#    Unzip the zip files.
#    Copy just the 3 CSV files to the ./downloads directory.
# 3) This script is designed to run from cygwin


sqlHost=bloom-analytics.postgres.database.azure.com

# This returns the directory that contains the script file.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SCRIPT_DIR_WIN=$(cygpath -w $SCRIPT_DIR)
#echo SCRIPTDIR=$SCRIPT_DIR

commandsFileName=$SCRIPT_DIR/temp_psqlHelperCommands.txt
commandsFileNameWin=$(cygpath -w $commandsFileName)
#echo commandsFileName=$commandsFileName

dateStr=$(date +"%Y_%m_%d")

########
## ip -> location (ip2location)
########
ipToLocationTableName=ip2location_as_of_$dateStr
#echo ipToLocationTableName=$ipToLocationTableName

# FYI: ip2location uses double quote as the quote character and as the escape character.
#      If desired, you can explicitly set these options in the \copy command (quote '"' escape '"'), but they're the default, so I didn't bother
echo "CREATE TABLE IF NOT EXISTS $ipToLocationTableName (" > $commandsFileName
echo "    ip_from bigint NOT NULL," >> $commandsFileName
echo "    ip_to bigint NOT NULL," >> $commandsFileName
echo "    country_code character(2) COLLATE pg_catalog."default" NOT NULL," >> $commandsFileName
echo "    country_name character varying(64) COLLATE pg_catalog.\"default\" NOT NULL," >> $commandsFileName
echo "    CONSTRAINT "$ipToLocationTableName"_db1_pkey PRIMARY KEY(ip_from, ip_to)" >> $commandsFileName
echo ");" >> $commandsFileName
echo "\copy $ipToLocationTableName FROM $SCRIPT_DIR_WIN\downloads\IP2LOCATION-LITE-DB1.CSV delimiter ',' csv " >> $commandsFileName

########
## ipv4 -> location (ipv42location)
########
ipv4ToLocationTableName=ipv42location_as_of_$dateStr
echo "CREATE TABLE IF NOT EXISTS $ipv4ToLocationTableName (" >> $commandsFileName
echo "    ipv4_from bigint NOT NULL," >> $commandsFileName
echo "    ipv4_to bigint NOT NULL," >> $commandsFileName
echo "    country_code character(2) COLLATE pg_catalog."default" NOT NULL," >> $commandsFileName
echo "    country_name character varying(64) COLLATE pg_catalog.\"default\" NOT NULL," >> $commandsFileName
echo "    region character varying(100) COLLATE pg_catalog.\"default\" NOT NULL," >> $commandsFileName
echo "    city character varying(100) COLLATE pg_catalog.\"default\" NOT NULL," >> $commandsFileName
echo "    CONSTRAINT "$ipv4ToLocationTableName"_db1_pkey PRIMARY KEY(ipv4_from, ipv4_to)" >> $commandsFileName
echo ");" >> $commandsFileName
echo "\copy $ipv4ToLocationTableName FROM $SCRIPT_DIR_WIN\downloads\IP2LOCATION-LITE-DB3.CSV delimiter ',' csv " >> $commandsFileName

########
## ipv6 -> location (ipv62location)
########
ipv6ToLocationTableName=ipv62location_as_of_$dateStr
echo "CREATE TABLE IF NOT EXISTS $ipv6ToLocationTableName (" >> $commandsFileName
echo "    ipv6_from numeric(39,0) NOT NULL," >> $commandsFileName
echo "    ipv6_to numeric(39,0) NOT NULL," >> $commandsFileName
echo "    country_code character(2) COLLATE pg_catalog."default" NOT NULL," >> $commandsFileName
echo "    country_name character varying(64) COLLATE pg_catalog.\"default\" NOT NULL," >> $commandsFileName
echo "    region character varying(100) COLLATE pg_catalog.\"default\" NOT NULL," >> $commandsFileName
echo "    city character varying(100) COLLATE pg_catalog.\"default\" NOT NULL," >> $commandsFileName
echo "    CONSTRAINT "$ipv6ToLocationTableName"_db1_pkey PRIMARY KEY(ipv6_from, ipv6_to)" >> $commandsFileName
echo ");" >> $commandsFileName
echo "\copy $ipv6ToLocationTableName FROM $SCRIPT_DIR_WIN\downloads\IP2LOCATION-LITE-DB3.IPV6.CSV delimiter ',' csv " >> $commandsFileName

########
## Execute the PostgreSQL commands
########
psql --host=$sqlHost --port=5432 --username=silpgadmin --dbname=bloomsegment --echo-queries -f $commandsFileNameWin
