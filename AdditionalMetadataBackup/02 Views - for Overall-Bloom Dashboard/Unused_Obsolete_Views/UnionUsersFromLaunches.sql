REVOKE SELECT ON bloomreadertest.UnionUsers FROM readbloomtester;
DROP VIEW bloomreadertest.UnionUsers ;

CREATE VIEW bloomreadertest.UnionUsers AS
	SELECT * FROM bloomreadertest.UsersLastThreeMonthsFromLaunch 
	UNION ALL
	SELECT * FROM bloomreadertest.UsersLastSixMonthsFromLaunch
    UNION ALL
 	SELECT * FROM bloomreadertest.LastYearsUsersFromLaunch ;
    

GRANT SELECT ON bloomreadertest.UnionUsers TO readbloomtester;
select * FROM bloomreadertest.UnionUsers ;
GRANT ALL PRIVILEGES on bloomreadertest.UnionUsers to bloomappuser,readbloom, silpgadmin, segment;
select * FROM bloomreadertest.UnionUsers where timeperiod = '6 Months';

select count(*) from bloomapp.launch; --order by user_id ASC LIMIT 100;