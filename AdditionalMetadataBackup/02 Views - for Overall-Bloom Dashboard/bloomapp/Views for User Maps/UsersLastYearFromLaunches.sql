--REVOKE SELECT ON bloomreadertest.LastYearsUsersFromLaunch FROM readbloomtester;
--DROP VIEW bloomreadertest.LastYearsUsersFromLaunch;

CREATE VIEW bloomreadertest.LastYearsUsersFromLaunch AS
	select DISTINCT ON (a.user_id) USER_ID,  
		(SELECT d.country_name from public.ip2loc_sm_tab AS d 
		 WHERE public.ip2ipv4(a.ip) = d.context_ip) AS Country,
		CAST('1 Year' as text) AS TimePeriod
	from bloomapp.launch AS a
	where
     a.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '12 months') 
	order by  a.user_id, Country;  
	

GRANT SELECT ON bloomreadertest.LastYearsUsersFromLaunch TO readbloomtester;
select * FROM bloomreadertest.LastYearsUsersFromLaunch;

select count(*) from bloomapp.launch; --order by user_id ASC LIMIT 100;
GRANT ALL PRIVILEGES on bloomreadertest.LastYearsUsersFromLaunch to bloomappuser,readbloom, silpgadmin, segment;