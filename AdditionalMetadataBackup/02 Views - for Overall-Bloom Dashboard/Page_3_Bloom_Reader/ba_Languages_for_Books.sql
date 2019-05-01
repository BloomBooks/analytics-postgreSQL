--REVOKE SELECT ON bloomreader.Languages_for_books FROM bloomreaderuser;
--DROP VIEW bloomreader.Languages_for_books CASCADE;

CREATE VIEW bloomreader.Languages_for_books AS
	SELECT DISTINCT(a.content_lang) AS lang FROM 
		(SELECT DISTINCT(content_lang) FROM bloomreader.book_or_shelf_opened 
		 UNION 
		 SELECT DISTINCT(content_lang) FROM bloomreaderbeta.book_or_shelf_opened) AS a;

GRANT SELECT ON bloomreader.Languages_for_books TO bloomreaderuser;
select * FROM bloomreader.Languages_for_books;


