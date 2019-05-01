--REVOKE SELECT ON bloomreader.ComprehensionAnyCountry FROM bloomreaderuser;
--DROP VIEW bloomreader.ComprehensionAnyCountry CASCADE;

CREATE OR REPLACE VIEW bloomreader.ComprehensionAnyCountry AS
	SELECT DISTINCT a.title AS Title_Tested,
          COUNT(a.title) AS Tests_Taken,
          a.timestamp,
          a.percent_right,
          a.right_first_time AS Number_Right_1st_Time,
          a.question_count AS Number_of_Questions,
          a.branding_project_name AS Branding,
          x.Country,
          x.title, x.median_percent_right 
          FROM (SELECT y.Country, y.title, ROUND(AVG(y.percent_right), 0) AS median_percent_right  
	 			FROM (
   				 SELECT b.country_name AS Country, z.title, z.percent_right, COUNT(z.title),
      				ROW_NUMBER() OVER (ORDER BY z.title ASC, COUNT(z.title)*z.percent_right  ASC) AS rows_ascending,
      				ROW_NUMBER() OVER (ORDER BY z.title ASC, COUNT(z.title)*z.percent_right DESC) AS rows_descending
                    FROM ( SELECT * FROM bloomreader.questions_correct 
			   				UNION ALL
			   				SELECT * FROM bloomreaderbeta.questions_correct ) AS z
    			INNER JOIN (SELECT DISTINCT c.country_name, c.loc_uid 
            			FROM countryregioncitylu AS c) AS b ON 
            			z.location_uid = b.loc_uid
                    GROUP BY b.country_name, z.title, z.percent_right
	 			     ) AS y
                 WHERE rows_ascending BETWEEN rows_descending - 1 AND rows_descending + 1
                 GROUP BY y.Country, y.title
             ) AS x 
    INNER JOIN bloomreader.UnionQuestions AS a ON a.title = x.title 
    GROUP BY x.Country, a.title, x.title,  x.median_percent_right,  
             a.question_count, a.right_first_time, a.percent_right, a.branding_project_name, a.timestamp  
    ORDER BY a.title;

GRANT SELECT ON bloomreader.ComprehensionAnyCountry TO bloomreaderuser;
select * FROM bloomreader.ComprehensionAnyCountry;