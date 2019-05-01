--REVOKE SELECT ON bloomreader.LanguagesAnyCountry FROM bloomreaderuser;
--DROP VIEW bloomreader.LanguagesAnyCountry ;

CREATE VIEW bloomreader.LanguagesAnyCountry AS
	SELECT  COUNT (DISTINCT(a.BookLanguage)) AS language_count, a.Country
          FROM bloomreader.Books  AS a
		GROUP BY a.Country;

GRANT SELECT ON bloomreader.LanguagesAnyCountry TO bloomreaderuser;
GRANT SELECT ON bloomreader.LanguagesAnyCountry TO readbloomtester;
select * FROM bloomreader.LanguagesAnyCountry;

