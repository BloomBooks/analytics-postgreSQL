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

Today (11/2021), it took 381 seconds.

You should be able to do the same thing using the command line tool, but we were having issues with it.
https://www.postgresql.org/docs/10/static/app-pgdump.html

## Dropping and Creating Views

Sometimes, you can just run the `CREATE OR REPLACE` command. Good.

But other times, you must drop the view because the data types changes, etc.
In those cases, you will often find you can't drop the view because other views depend on it. Then you must drop all the dependent views, drop your view, then recreate everything. Needless to say, it is painful.

The most recent time we did this, we made a separate file in which we copied all the drop and create statements in the right order. We started with `BEGIN;` and ended with `COMMIT;`. When there were errors, no changes were made, so we were not left in a broken state.

I've committed what we actually used as a sample at `/queries/sample_drop_and_replace_views.sql`.
You can use `/queries/find_dependent_views.sql` to query for which views depend on a particular view.

Don't forget the recreation of indexes or the rerunning of any `GRANT` statements which are needed!

## Updating geographic information

The file UPDATE-IP-TABLES.md contains instructions on how to update the tables we currently use
for mapping from IP addresses to geographic locations.  This updating should be done periodically
but not too often since each time we update it, we leave the old data in place.

## Geographic information (historical?)

The `bash-scripts` folder contains a pair of bash shell scripts that were used to create and populate the public geography_city_centers and geography_regioncodes tables. The data for these tables (which provide latitude and longitude information for cities and towns around the world) is from download.geonames.org/export/dump/. The exact details are provided in these shell scripts.

A table named public.countrycodes already existed, so the corresponding data from geonames was not handled the same way. After comparing the existing data with the geonames data, 3 new rows were added to the existing table. (These particular codes may be obsolete or provisional, but are likely to be found in the geonames dataset.)

Our use of geographic information is entirely point-based, which has some limitations. For heavily populated areas, the incoming latitude and longitude for a given location may be closer to the center of a smaller town adjacent to a larger city even though the location is actually within the boundaries of the larger city. (An example of this would be portions of southwest Dallas near the International Linguistic Center which are closer to the centers of Duncanville or Cedar Hill than they are to the center of Dallas.) The only dataset we have found provides only this single point of reference. Completely accurate results would require geographic data that has vector based boundaries for all the cities and towns, not just a single point of latitude or longitude. Even if we had this data, it would require a much greater amount of table space, and would probably be slower to process.

### Ideas for enhanced geographic information

Several services can provide better reverse geocoding, but start costing money around 40,000 requests per month. We could tell our users that we'll give them the "nearest city" information for free. If they want, we can run all requests from their collection through a paid service, which they would have to pay for. The latter (paid) approach could be optimized by saving the results in a local table, but with the latitude and longitude rounded off to about a 1 km granularity (about 2 decimal places). Then requests for the city that round off to that level of granularity would still be accurate enough but would keep from asking the paid service repeatedly for the same device being used in the same place.

There's about 64 million square km of inhabited land on earth. The chances that we would ever get 40,000 new km-sq locations in a single month must be small. Conceivably we could even issue the request for the four surrounding 1-km-away points, and narrow things down to say 100m (3 decimal places) if we get different answers.
