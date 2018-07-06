select * from bloomreadertest.mpdata_change_content_languages;

SELECT to_timestamp(EXTRACT(EPOCH FROM INTERVAL '1369845877'));
SELECT to_timestamp('1369845877');
SELECT to_timestamp(a.received_at) from 
bloomreadertest.mpdata_change_content_languages AS a ;

select a.id from bloomreadertest.clone_change_content_languages AS a where a.timestamp::date > '2017-02-23';
select min (a.timestamp) from bloomreadertest.clone_change_content_languages AS a;