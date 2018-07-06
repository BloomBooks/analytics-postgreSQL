--REVOKE SELECT ON bloomreadertest.LaunchLocs FROM readbloomtester;
--DROP VIEW bloomreadertest.LaunchLocs;

CREATE VIEW bloomreadertest.LaunchLocs AS
	select DISTINCT ON (a.user_id, a.ip) USER_ID, IP, 
			(SELECT d.country_name from public.ip2loc_sm_tab AS d 
			 WHERE public.ip2ipv4(a.ip) = d.context_ip) AS Country
	from bloomapp.launch AS a
	order by  a.user_id, a.ip ;  
	
GRANT SELECT ON bloomreadertest.LaunchLocs TO readbloomtester;
select * FROM bloomreadertest.LaunchLocs;

select * from bloomapp.launch order by user_id ASC LIMIT 100;

GRANT ALL PRIVILEGES on bloomreadertest.LaunchLocs to bloomappuser,readbloom, silpgadmin, segment;

select min (timestamp ) from bloomapp.launch;