REVOKE SELECT ON bloomreadertest.Languages_for_books FROM readbloomtester;
DROP VIEW bloomreadertest.Languages_for_books CASCADE;

CREATE VIEW bloomreadertest.Languages_for_books AS
	SELECT DISTINCT(a.content_lang) AS lang FROM 
		(SELECT DISTINCT(content_lang) FROM bloomreader.book_or_shelf_opened 
		 UNION 
		 SELECT DISTINCT(content_lang) FROM bloomreaderbeta.book_or_shelf_opened) AS a;
/*
	select DISTINCT(b.language1_iso639_code) AS lang
           FROM bloomapp.create_book AS b
           GROUP BY b.language1_iso639_code;
*/

GRANT SELECT ON bloomreadertest.Languages_for_books TO readbloomtester;
select * FROM bloomreadertest.Languages_for_books;


