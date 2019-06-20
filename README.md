# analytics-postgreSQL
Database definition and other metadata we want to store for our postgreSQL database which contains Bloom analytics data

## Database metadata backup
The main purpose of this repository is to backup the bloomsegment database metadata. That is stored in bloomsegment.schema.backup.

### Creation of schema dump
To create the schema dump, I used pgAdmin 4, version 4.8:
- Connect as silpgadmin.
- Right click the bloomsegment database.
- Select "Backup...".
- Select a filename.
- For Format, choose Plain.
- Click the Dump Options Tab.
- Only schema => Yes.
- Include CREATE DATABASE statement => Yes.
- Click the "Backup" button.

You should be able to do the same thing using the command line tool, but we were having issues with it.
https://www.postgresql.org/docs/10/static/app-pgdump.html

## Additional metadata backup
We are also storing some other files which were helpful during the initial creation and setup of the database. These files are in the AdditionalMetadataBackup directory. Much of this likely duplicates table, view, and trigger creation script already included in bloomsegment.schema.backup, but we wanted to store both to be safe.
