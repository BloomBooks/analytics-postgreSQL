REVOKE SELECT ON bloomreadertest.UniqueUserOS FROM readbloomtester;
DROP VIEW bloomreadertest.UniqueUserOS;

CREATE VIEW bloomreadertest.UniqueUserOS AS
	select DISTINCT ON (a.user_id) USER_ID,
			a.browser
	from bloomapp.create_book AS a;
	
GRANT SELECT ON bloomreadertest.UniqueUserOS TO readbloomtester;
select * FROM bloomreadertest.UniqueUserOS;
