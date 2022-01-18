--REVOKE SELECT ON bloomapp.BooksUploadedAllTime FROM bloomappuser;
--DROP VIEW bloomapp.BooksUploadedAllTime;

CREATE OR REPLACE VIEW bloomapp.BooksUploadedAllTime AS
	SELECT a.url,
          MAX(a.timestamp) 
	FROM   bloomapp.upload_book_success AS a
		where a.timestamp < date_trunc('month', CURRENT_DATE)
		GROUP BY a.url; 

GRANT SELECT ON bloomapp.BooksUploadedAllTime TO bloomappuser;
select * FROM bloomapp.BooksUploadedAllTime;