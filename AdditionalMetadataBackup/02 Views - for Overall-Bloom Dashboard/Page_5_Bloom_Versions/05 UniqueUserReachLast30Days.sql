--REVOKE SELECT ON bloomreadertest.UniqueUserReachLast30Days FROM readbloomtester;
--DROP VIEW bloomreadertest.UniqueUserReachLast30Days;

CREATE VIEW bloomreadertest.UniqueUserReachLast30Days AS
	select DISTINCT ON (a.user_id) USER_ID,
			a.channel, a.timestamp
	from bloomapp.create_book AS a
		where a.channel = 'REACH' AND
	 a.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '1 months');
	
GRANT SELECT ON bloomreadertest.UniqueUserReachLast30Days TO readbloomtester;
select * FROM bloomreadertest.UniqueUserReachLast30Days;