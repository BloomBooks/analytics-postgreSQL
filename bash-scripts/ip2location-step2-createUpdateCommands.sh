#!/bin/sh
#
# If called without --execute flag, then generates SQL commands to update the database's IP tables,
# but does not actually execute them.
#
# If called with --execute as the first argument, then it executes what commands are in the command file.
# (That is, it will not overwrite any edits that have been manually, but rather will execute them)
# Segment sync should be paused before running with --execute, then re-enabled afterward.

sqlHost=bloom-analytics.postgres.database.azure.com

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
commandsFileName=$SCRIPT_DIR/temp_psqlUpdateCommands.txt
commandsFileNameWin=$(cygpath -w $commandsFileName)

dateStr=$(date +"%Y_%m_%d")
# Or manually set the date...
#dateStr="2022_01_19"

if [ "$1" != "--execute" ]; then
    ########
    ## ip -> location (ip2location)
    ########
    # Note: The purpose of delete all rows (instead of drop table) is just to avoid any potential complications
    # with indexes or something get accidentally deleted and needed to be re-created
    echo "DELETE FROM ONLY public.ip2location;" > $commandsFileName
    echo "INSERT INTO public.ip2location SELECT * FROM public.ip2location_as_of_$dateStr;" >> $commandsFileName
    echo >> $commandsFileName

    ########
    ## ipv4 -> location (ipv42location)
    ########
    echo "DELETE FROM ONLY public.ipv42location;" >> $commandsFileName
    echo "INSERT INTO public.ipv42location SELECT * FROM public.ipv42location_as_of_$dateStr;" >> $commandsFileName
    echo >> $commandsFileName

    ########
    ## ipv6 -> location (ipv62location)
    ########
    echo "DELETE FROM ONLY public.ipv62location;" >> $commandsFileName
    echo "INSERT INTO public.ipv62location SELECT * FROM public.ipv62location_as_of_$dateStr;" >> $commandsFileName
    echo >> $commandsFileName

else
    ########
    ## Execute command
    ########
    psql --host=$sqlHost --port=5432 --username=silpgadmin --dbname=bloomsegment --echo-queries -f $commandsFileNameWin
fi