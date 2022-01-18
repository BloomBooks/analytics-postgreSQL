--REVOKE SELECT ON bloomreadertest.DayRows FROM readbloomtester;
--DROP VIEW bloomreadertest.DayRows;

CREATE VIEW bloomreadertest.DayRows AS
	select COUNT(a.user_id) AS User_Count, 
		(SELECT d.country_name from public.ip2loc_sm_tab AS d 
		 WHERE public.ip2ipv4(a.ip) = d.context_ip) AS Country,
		 a.channel, a.version, a.browser,
		 a.timestamp::timestamp::date AS Day_User
	from bloomapp.launch AS a
	GROUP by a.user_id, Day_User, Country, a.ip, a.channel,  a.version, a.browser
	order by  a.ip, Day_User DESC;  
	
GRANT SELECT ON bloomreadertest.DayRows TO readbloomtester;
select * FROM bloomreadertest.DayRows;

select * from bloomapp.launch AS a WHERE a.timestamp::timestamp::date = '2017-10-26' and a.ip = '103.14.60.169';

GRANT ALL PRIVILEGES on bloomreadertest.DayRows to bloomappuser,readbloom, silpgadmin, segment;