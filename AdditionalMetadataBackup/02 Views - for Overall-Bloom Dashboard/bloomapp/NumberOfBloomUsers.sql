REVOKE SELECT ON bloomreadertest.NumOfBloomUsers FROM readbloomtester;
DROP VIEW bloomreadertest.NumOfBloomUsers CASCADE;

CREATE VIEW bloomreadertest.NumOfBloomUsers AS
	SELECT COUNT(id) AS num_users,
          CAST (date_part('YEAR',
                    a.received_at AT TIME ZONE 'AEST'       
                     ) as text)||
		  CAST (LPAD((date_part('MONTH', a.received_at AT TIME ZONE 'AEST'))::text, 2, '0')  as text)	
					AS Month_Published,
          a.received_at::timestamp::date --,
	--	(SELECT d.country_name from public.ip2loc_sm_tab AS d
	--	   WHERE public.ip2ipv4(a.context_ip) = d.context_ip) AS Country
	FROM   bloomapp.users AS a
    GROUP BY a.received_at, a.received_at::timestamp::date; --, a.context_ip;

GRANT SELECT ON bloomreadertest.NumOfBloomUsers TO readbloomtester;
select * FROM bloomreadertest.NumOfBloomUsers;
