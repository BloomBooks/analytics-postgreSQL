--REVOKE SELECT ON bloomreadertest.UsersLastSixMonthsFromLaunch FROM readbloomtester;
--DROP VIEW bloomreadertest.UsersLastSixMonthsFromLaunch;

CREATE VIEW bloomreadertest.UsersLastSixMonthsFromLaunch AS
	select DISTINCT ON (a.user_id) USER_ID,  
		(SELECT d.country_name from public.ip2loc_sm_tab AS d 
		 WHERE public.ip2ipv4(a.ip) = d.context_ip) AS Country,
		CAST('6 Months' as text) AS TimePeriod
	from bloomapp.launch AS a
	where
     a.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '6 months') 
	order by  a.user_id, Country;  
	

GRANT SELECT ON bloomreadertest.UsersLastSixMonthsFromLaunch TO readbloomtester;
select * FROM bloomreadertest.UsersLastSixMonthsFromLaunch;

select count(*) from bloomapp.launch; --order by user_id ASC LIMIT 100;
GRANT ALL PRIVILEGES on bloomreadertest.UsersLastSixMonthsFromLaunch to bloomappuser,readbloom, silpgadmin, segment;