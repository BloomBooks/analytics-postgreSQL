--REVOKE SELECT ON bloomreadertest.PDFsPerMon FROM readbloomtester;
--DROP VIEW bloomreadertest.PDFsPerMon CASCADE;

CREATE VIEW bloomreadertest.PDFsPerMon AS
	SELECT COUNT(*) AS num_published,
          CAST (date_part('YEAR',
                    a.timestamp AT TIME ZONE 'AEST'       
                     ) as text)||
		  CAST (LPAD((date_part('MONTH',a.timestamp AT TIME ZONE 'AEST'))::text, 2, '0')  as text)	
					AS Month_Published,
          a.timestamp::timestamp::date,
		(SELECT d.country_name from public.ip2loc_sm_tab AS d
		   WHERE public.ip2ipv4(a.ip) = d.context_ip) AS Country,
          a.event
	FROM   bloomapp.print_pdf AS a
    GROUP BY a.timestamp, a.timestamp::timestamp::date, a.ip, a.event;

GRANT SELECT ON bloomreadertest.PDFsPerMon TO readbloomtester;
select * FROM bloomreadertest.PDFsPerMon;

select Count(DISTINCT(a.book_id)) from bloomapp.print_pdf AS a where (NOT exists 
(select b.book_id from bloomapp.publish_android AS b where a.book_id = b.book_id) AND (NOT exists 
(select c.book_id from bloomapp.save_e_pub AS c where a.book_id = c.book_id)));

select Count(DISTINCT(a.book_id)) from bloomapp.publish_android  AS a where (NOT exists 
(select b.book_id from bloomapp.print_pdf AS b where a.book_id = b.book_id) AND (NOT exists 
(select c.book_id from bloomapp.save_e_pub AS c where a.book_id = c.book_id)));

select Count(DISTINCT(a.book_id)) from bloomapp.save_e_pub AS a where (NOT exists 
(select b.book_id from bloomapp.print_pdf AS b where a.book_id = b.book_id) AND (NOT exists 
(select c.book_id from bloomapp.publish_android AS c where a.book_id = c.book_id)));

select Count(DISTINCT(a.book_id)) from bloomapp.print_pdf AS a 
INNER JOIN bloomapp.publish_android AS b ON a.book_id = b.book_id
INNER JOIN bloomapp.save_e_pub AS c ON a.book_id = c.book_id;

select Count(DISTINCT(a.book_id)) from bloomapp.print_pdf AS a 
INNER JOIN bloomapp.publish_android AS b ON a.book_id = b.book_id

select Count(DISTINCT(a.book_id)) from bloomapp.publish_android AS a 
INNER JOIN bloomapp.save_e_pub AS b ON a.book_id = b.book_id

select Count(DISTINCT(a.book_id)) from bloomapp.save_e_pub  AS a 
INNER JOIN bloomapp.print_pdf AS b ON a.book_id = b.book_id

select * from bloomapp.print_pdf AS a 
FULL OUTER JOIN bloomapp.save_e_pub  AS b ON a.book_id = b.book_id
FULL OUTER JOIN bloomapp.publish_android AS c ON a.book_id = c.book_id;
