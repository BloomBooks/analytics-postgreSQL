--REVOKE SELECT ON bloomapp.UniqueUserChannelLast30Days FROM bloomappuser;
--DROP VIEW bloomapp.UniqueUserChannelLast30Days;

CREATE VIEW bloomapp.UniqueUserChannelLast30Days AS
	select DISTINCT ON (a.user_id) USER_ID,
			a.channel, a.timestamp
	from bloomapp.create_book AS a
		where a.channel <> 'REACH' AND
	 a.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '1 months');
	
GRANT SELECT ON bloomapp.UniqueUserChannelLast30Days TO bloomappuser;
select * FROM bloomapp.UniqueUserChannelLast30Days;