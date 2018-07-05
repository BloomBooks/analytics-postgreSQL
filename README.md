# analytics-postgreSQL
Database definition and other metadata we want to store for our postgreSQL database which contains Bloom analytics data

## Database metadata backup
The main purpose of this repository is to backup the bloomsegment database metadata. That is stored in bloomsegment.schema.backup.

### Creation of schema dump
To create the schema dump, I used pgAdmin.
- Right click the bloomsegment database.
- Select a filename.
- For Format, choose Plain.
- Click the Dump Options Tab.
- Only schema => Yes.
- Blobs => No (this shouldn't matter with Only schema set to Yes).
- Include CREATE DATABASE statement => Yes.
- Include DROP DATABASE statement => Yes.
- On the General tab, click Create.

You should be able to do the same thing using the command line tool, but we were having issues with it.
https://www.postgresql.org/docs/10/static/app-pgdump.html
