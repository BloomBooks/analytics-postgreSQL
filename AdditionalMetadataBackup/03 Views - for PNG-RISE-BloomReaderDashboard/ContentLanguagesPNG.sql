REVOKE SELECT ON bloomreader.ContentLanguagesPNG FROM bloomreaderuser;
DROP VIEW bloomreader.ContentLanguagesPNG ;

CREATE VIEW bloomreader.ContentLanguagesPNG AS
	SELECT  DISTINCT(a.content_lang) AS language_count
          FROM (SELECT DISTINCT(content_lang), context_ip from bloomreader.book_or_shelf_opened 
				UNION
				SELECT DISTINCT(content_lang), context_ip from bloomreaderbeta.book_or_shelf_opened) AS a
		  WHERE EXISTS (SELECT 1 FROM public.ip2location AS b 
                   		WHERE ip2int(a.context_ip) BETWEEN b.ip_from and b.ip_to
						AND b.country_name = 'Papua New Guinea') ;

GRANT SELECT ON bloomreader.ContentLanguagesPNG TO bloomreaderuser;
select * FROM bloomreader.ContentLanguagesPNG ;
