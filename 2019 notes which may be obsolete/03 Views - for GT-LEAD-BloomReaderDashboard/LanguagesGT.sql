REVOKE SELECT ON bloomreader.Languages FROM bloomreaderuser;
DROP VIEW bloomreader.Languages ;

CREATE VIEW bloomreader.Languages AS
	SELECT  COUNT (DISTINCT(b.BookLanguage)) AS language_count, b.Country
          FROM bloomreader.Books  AS b
          WHERE b.Country = 'Guatemala'
          GROUP BY  b.Country ;

GRANT SELECT ON bloomreader.Languages TO bloomreaderuser;
select * FROM bloomreader.Languages;

