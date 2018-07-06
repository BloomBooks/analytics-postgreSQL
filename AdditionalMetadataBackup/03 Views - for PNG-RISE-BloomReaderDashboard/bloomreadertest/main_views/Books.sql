REVOKE SELECT ON bloomreadertest.Books FROM readbloomtester;
DROP VIEW bloomreadertest.Books CASCADE;

CREATE VIEW bloomreadertest.Books AS
	SELECT a.timestamp AS BookTimeStamp,
          a.title AS BookTitle,
          CASE WHEN a.last_numbered_page_read=TRUE THEN 1
          	   ELSE 0 END AS Finished,
          a.branding_project_name AS Branding,
          c.clname AS  BookLanguage, 
 		  CASE WHEN EXISTS (SELECT 'x' from bloomreadertest.UnionQuestions AS q  
                            WHERE lower(q.title) = lower(a.title) ) THEN
                            CASE WHEN a.audio_pages > 0 THEN  
								 	CAST ('Audio, Quiz' AS text) 
		  						 WHEN  a.audio_pages = 0 THEN
                                 	CAST ('Quiz' AS text)
                            	 ELSE NULL END 
               ELSE CASE WHEN a.audio_pages > 0 THEN  
								 	CAST ('Audio' AS text) 
                            	 ELSE NULL END
               END AS Media,
		  (SELECT d.country_name from public.ip2loc_sm_tab AS d
		   WHERE public.ip2int(a.context_ip) = d.context_ip) AS Country
	FROM   bloomreadertest.UnionPages AS a
        INNER JOIN public.languagecodes AS c 
           	ON a.content_lang=c.langid OR a.content_lang=c.langid2
    ORDER BY a.title;
    
GRANT SELECT ON bloomreadertest.Books TO readbloomtester;
select * FROM bloomreadertest.Books;
select * FROM bloomreadertest.Books AS a where a.Country NOT IN ('United States');
select * from public.ip2loc_sm_tab;