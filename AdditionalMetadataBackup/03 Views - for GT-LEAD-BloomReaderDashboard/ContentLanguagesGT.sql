REVOKE SELECT ON bloomreader.ContentLanguagesGT FROM readbloomtester;
DROP VIEW bloomreader.ContentLanguagesGT ;

CREATE OR REPLACE VIEW bloomreader.ContentLanguagesGT AS
	SELECT  DISTINCT(a.content_lang) AS language_count
          FROM (SELECT DISTINCT(content_lang), context_ip 
					FROM bloomreader.book_or_shelf_opened AS c
					WHERE c.branding_project_name = 'Juarez-Guatemala'
				UNION
		  		SELECT DISTINCT(content_lang), context_ip 
					FROM bloomreaderbeta.book_or_shelf_opened AS d
			   		WHERE d.branding_project_name = 'Juarez-Guatemala') AS a
		  WHERE EXISTS (SELECT 1 FROM public.ip2location AS b 
                   		WHERE ip2int(a.context_ip) BETWEEN b.ip_from and b.ip_to
						AND b.country_name = 'Guatemala') ;

GRANT SELECT ON bloomreader.ContentLanguagesGT TO readbloomtester;
GRANT SELECT ON bloomreader.ContentLanguagesGT TO bloomgtuser;
GRANT SELECT ON bloomreader.book_or_shelf_opened TO bloomgtuser;
GRANT SELECT ON bloomreaderbeta.book_or_shelf_opened TO bloomgtuser;
select * FROM bloomreader.ContentLanguagesGT ;
