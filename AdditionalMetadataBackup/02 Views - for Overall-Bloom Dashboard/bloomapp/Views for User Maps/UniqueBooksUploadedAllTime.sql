--REVOKE SELECT ON bloomreadertest.BooksUploadedAllTime FROM readbloomtester;
--DROP VIEW bloomreadertest.BooksUploadedAllTime;

CREATE VIEW bloomreadertest.BooksUploadedAllTime AS
	SELECT a.id,
          a.timestamp 
	FROM   bloomapp.upload_book_success AS a
		where
	a.timestamp < date_trunc('month', CURRENT_DATE); 

GRANT SELECT ON bloomreadertest.BooksUploadedAllTime TO readbloomtester;
select * FROM bloomreadertest.BooksUploadedAllTime;