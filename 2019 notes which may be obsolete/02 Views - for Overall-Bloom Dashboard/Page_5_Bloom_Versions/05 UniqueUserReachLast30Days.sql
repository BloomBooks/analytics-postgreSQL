--REVOKE SELECT ON bloomapp.UniqueUserReachLast30Days FROM bloomappuser;
--DROP VIEW bloomapp.UniqueUserReachLast30Days;

CREATE VIEW bloomapp.UniqueUserReachLast30Days AS
	select DISTINCT ON (a.user_id) USER_ID,
			a.channel, a.timestamp
	from bloomapp.create_book AS a
		where a.channel = 'REACH' AND
	 a.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '1 months');
	
GRANT SELECT ON bloomapp.UniqueUserReachLast30Days TO bloomappuser;
select * FROM bloomapp.UniqueUserReachLast30Days;