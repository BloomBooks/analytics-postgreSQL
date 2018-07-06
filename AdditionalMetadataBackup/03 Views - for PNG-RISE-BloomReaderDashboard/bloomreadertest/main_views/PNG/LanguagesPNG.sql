REVOKE SELECT ON bloomreadertest.Languages FROM readbloomtester;
DROP VIEW bloomreadertest.Languages ;

CREATE VIEW bloomreadertest.Languages AS
	SELECT  COUNT (DISTINCT(b.BookLanguage)) AS language_count, b.Country
          FROM bloomreadertest.Books  AS b
          WHERE b.Country = 'Papua New Guinea'
          GROUP BY  b.Country ;


GRANT SELECT ON bloomreadertest.Languages TO readbloomtester;
select * FROM bloomreadertest.Languages;

