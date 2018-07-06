--REVOKE SELECT ON bloomreadertest.BooksCreatedAllTime FROM readbloomtester;
--DROP VIEW bloomreadertest.BooksCreatedAllTime ;

CREATE VIEW bloomreadertest.BooksCreatedAllTime AS
	SELECT a.user_id, a.id, a.language1_iso639_code,
          a.timestamp 
	FROM   bloomapp.create_book AS a
		where
	a.timestamp < date_trunc('month', CURRENT_DATE); 

GRANT SELECT ON bloomreadertest.BooksCreatedAllTime TO readbloomtester;
select * FROM bloomreadertest.BooksCreatedAllTime;