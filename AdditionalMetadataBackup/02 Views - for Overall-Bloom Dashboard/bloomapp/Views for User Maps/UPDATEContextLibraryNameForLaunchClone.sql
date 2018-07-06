
   	UPDATE bloomapp.upload_book_success 
	SET  context_library_name = context_library_name||' via Mixpanel'
	WHERE timestamp < '2017-07-26 19:00:24.774+00';

SELECT *  from bloomapp.upload_book_success AS a
   ORDER BY a.timestamp DESC;
   
SELECT REPLACE(a.context_library_name,' via Mixpanel via Mixpanel','  via Mixpanel') from bloomapp.launch AS a
		WHERE a.timestamp < '2017-07-21 19:42:16.883+00'
		AND a.context_library_name <>'Segment: Analytics.NET';   
   
SELECT a.context_library_name||' via Mixpanel'  from bloomapp.launch AS a
		WHERE a.timestamp < '2017-07-21 19:42:16.883+00'
		AND a.context_library_name <>'Segment: Analytics.NET';
SELECT a.context_library_name||' via Mixpanel' from bloomapp.launch AS a
		WHERE a.timestamp > '2017-07-21 19:42:16.883+00'
		AND POSITION('Segment' in a.context_library_name)>0;
SELECT a.context_library_name||' via Mixpanel'  from bloomreadertest.clone_launch AS a
      WHERE a.timestamp > '2017-07-21 19:42:16.883+00' 
	  AND a.ip IS NOT NULL 
	  AND (STRPOS(a.ip,'<') = 0)  
	  AND (STRPOS(ip,':') = 0);
	  
SELECT * from bloomapp.launch AS a
		WHERE a.timestamp < '2017-07-21 19:42:16.883+00'
		AND a.context_library_name ='Segment: analytics-.NET';
		AND a.context_library_name <>'Segment: Analytics.NET';
select current_user;
