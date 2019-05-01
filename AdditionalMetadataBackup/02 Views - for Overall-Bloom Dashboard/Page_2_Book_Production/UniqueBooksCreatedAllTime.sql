--REVOKE SELECT ON bloomapp.BooksCreatedAllTime FROM bloomappuser;
--DROP VIEW bloomapp.BooksCreatedAllTime ;

CREATE VIEW bloomapp.BooksCreatedAllTime AS
	SELECT a.user_id, a.id, a.language1_iso639_code,
          a.timestamp 
	FROM   bloomapp.create_book AS a
--	WHERE a.timestamp <= (date_trunc('month', current_date)) ;
	WHERE a.timestamp > 
	((date_trunc('month', current_date) - interval '1 day') - INTERVAL '35 months');
--WHERE a.timestamp <= (date_trunc('month', current_date)) ;	
	--	where a.timestamp < date_trunc('month', CURRENT_DATE); 

GRANT SELECT ON bloomapp.BooksCreatedAllTime TO bloomappuser;
select * FROM bloomapp.BooksCreatedAllTime;

select * from bloomapp.create_book AS a where (a.timestamp < date_trunc('month', CURRENT_DATE))
	and a.timestamp >= '2019-01-01'

																		
	SELECT a.user_id, a.id, a.language1_iso639_code,
          a.timestamp 
	FROM   bloomapp.create_book AS a
	WHERE a.timestamp <= (date_trunc('month', current_date)) ;
--	WHERE a.timestamp > 
--	((date_trunc('month', current_date) - interval '1 day') - INTERVAL '35 months');
--WHERE a.timestamp <= (date_trunc('month', current_date)) ;	
	--	where a.timestamp < date_trunc('month', CURRENT_DATE);																		
																		
																		
CREATE VIEW bloomapp.BooksCreatedAllTime AS
	SELECT a.timestamp, DISTINCT a.id,
           
	FROM   bloomapp.create_book AS a
--	WHERE a.timestamp <= (date_trunc('month', current_date)) ;
	WHERE a.timestamp > 
	((date_trunc('month', current_date) - interval '1 day') - INTERVAL '35 months');
																		