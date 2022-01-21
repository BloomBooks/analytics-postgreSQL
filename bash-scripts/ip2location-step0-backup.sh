#!/bin/sh
#
# Only execute this script if you need to create backups. You do not normally need to run this.

########
## MODIFY THESE VARIABLES
########
sqlHost=bloom-analytics.postgres.database.azure.com
backupIpToLocation=false
backupIpV4ToLocation=false
backupIpV6ToLocation=false
########
## END MODIFY
########


dateStr=$(date +"%Y_%m_%d")

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
commandsFileName=$SCRIPT_DIR/temp_psqlBackupCommands.txt
commandsFileNameWin=$(cygpath -w $commandsFileName)

needToExecute=false;

rm $commandsFileName

########
## ip -> location (ip2location)
########
if [ $backupIpToLocation == true ]; then
    ipToLocationTableName=ip2location_up_to_$dateStr
    echo "CREATE TABLE IF NOT EXISTS $ipToLocationTableName (" >> $commandsFileName
    echo "    ip_from bigint NOT NULL," >> $commandsFileName
    echo "    ip_to bigint NOT NULL," >> $commandsFileName
    echo "    country_code character(2) COLLATE pg_catalog."default" NOT NULL," >> $commandsFileName
    echo "    country_name character varying(64) COLLATE pg_catalog.\"default\" NOT NULL," >> $commandsFileName
    echo "    CONSTRAINT "$ipToLocationTableName"_db1_pkey PRIMARY KEY(ip_from, ip_to)" >> $commandsFileName
    echo ");" >> $commandsFileName
    echo "INSERT INTO public.$ipToLocationTableName SELECT * FROM public.ip2location;" >> $commandsFileName
    echo >> $commandsFileName
    needToExecute=true
fi

########
## ipv4 -> location (ipv42location)
########
if [ $backupIpV4ToLocation == true ]; then
    ipv4ToLocationTableName=ipv42location_up_to_$dateStr
    echo "CREATE TABLE IF NOT EXISTS $ipv4ToLocationTableName (" >> $commandsFileName
    echo "    ip_from bigint NOT NULL," >> $commandsFileName
    echo "    ip_to bigint NOT NULL," >> $commandsFileName
    echo "    country_code character(2) COLLATE pg_catalog."default" NOT NULL," >> $commandsFileName
    echo "    country_name character varying(64) COLLATE pg_catalog.\"default\" NOT NULL," >> $commandsFileName
    echo "    region character varying(100) COLLATE pg_catalog.\"default\" NOT NULL," >> $commandsFileName
    echo "    city character varying(100) COLLATE pg_catalog.\"default\" NOT NULL," >> $commandsFileName
    echo "    CONSTRAINT "$ipv4ToLocationTableName"_db1_pkey PRIMARY KEY(ip_from, ip_to)" >> $commandsFileName
    echo ");" >> $commandsFileName
    echo "INSERT INTO public.$ipv4ToLocationTableName SELECT * FROM public.ipv42location;" >> $commandsFileName
    echo >> $commandsFileName
    needToExecute=true
fi

########
## ipv6 -> location (ipv62location)
########
if [ $backupIpV6ToLocation == true ]; then
    ipv6ToLocationTableName=ipv62location_up_to_$dateStr
    echo "CREATE TABLE IF NOT EXISTS $ipv6ToLocationTableName (" >> $commandsFileName
    echo "    ip_from numeric(39,0) NOT NULL," >> $commandsFileName
    echo "    ip_to numeric(39,0) NOT NULL," >> $commandsFileName
    echo "    country_code character(2) COLLATE pg_catalog."default" NOT NULL," >> $commandsFileName
    echo "    country_name character varying(64) COLLATE pg_catalog.\"default\" NOT NULL," >> $commandsFileName
    echo "    region character varying(100) COLLATE pg_catalog.\"default\" NOT NULL," >> $commandsFileName
    echo "    city character varying(100) COLLATE pg_catalog.\"default\" NOT NULL," >> $commandsFileName
    echo "    CONSTRAINT "$ipv6ToLocationTableName"_db1_pkey PRIMARY KEY(ip_from, ip_to)" >> $commandsFileName
    echo ");" >> $commandsFileName
    echo "INSERT INTO public.$ipv6ToLocationTableName SELECT * FROM public.ipv62location;" >> $commandsFileName
    echo >> $commandsFileName
    needToExecute=true
fi

if [ $needToExecute == true ]; then
    psql --host=$sqlHost --port=5432 --username=silpgadmin --dbname=bloomsegment --echo-queries -f $commandsFileNameWin
fi