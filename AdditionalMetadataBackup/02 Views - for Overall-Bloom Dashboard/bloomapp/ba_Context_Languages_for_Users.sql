REVOKE SELECT ON bloomapp.Context_Languages_for_Users FROM readbloomtester;
DROP VIEW bloomapp.Context_Languages_for_Users CASCADE;

CREATE VIEW bloomapp.Context_Languages_for_Users AS
	SELECT a.language_count, a.month_used--, a.timestamp
	FROM ( select COUNT (DISTINCT(b.context_language)) AS language_count,
		   CAST (date_part('YEAR',
                    b.received_at AT TIME ZONE 'AEST'       
                     ) as text)||
		   CAST (LPAD((date_part('MONTH',b.received_at AT TIME ZONE 'AEST'))::text, 2, '0')  as text)		
					AS Month_Used,
      --     b.received_at::timestamp::date AS timestamp, 
           rank() over (partition by 
						CAST (date_part('YEAR',
                    b.received_at AT TIME ZONE 'AEST'       
                     ) as text)||
		   CAST (LPAD((date_part('MONTH',b.received_at AT TIME ZONE 'AEST'))::text, 2, '0')  as text)		
						order by 
						CAST (date_part('YEAR',
                    b.received_at AT TIME ZONE 'AEST'       
                     ) as text)||
		   CAST (LPAD((date_part('MONTH',b.received_at AT TIME ZONE 'AEST'))::text, 2, '0')  as text)		
						asc) as rank
           FROM bloomapp.users AS b
		   GROUP BY b.received_at::timestamp::date, b.received_at AT TIME ZONE 'AEST'
            ) as a
			where rank = 1;

GRANT ALL PRIVILEGES on bloomapp.Context_Languages_for_Users to bloomappuser,readbloom, silpgadmin,readbloomtester;
GRANT SELECT ON bloomapp.Context_Languages_for_Users TO readbloomtester;
select * FROM bloomapp.Context_Languages_for_Users;

select max(language_count) from bloomapp.Context_Languages_for_Users;