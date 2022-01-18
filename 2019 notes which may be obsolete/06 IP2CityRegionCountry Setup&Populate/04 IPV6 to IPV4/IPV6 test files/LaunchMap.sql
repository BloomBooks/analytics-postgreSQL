select 
DISTINCT ON 
(a.user_id, a.ip) USER_ID, IP, 
(SELECT d.country_name from public.ip2loc_sm_tab AS d 
 WHERE public.ip2ipv4(a.ip) = d.context_ip) AS Country,
a.timestamp
from bloomapp.launch AS a
order by a.user_id, a.ip;

select 
DISTINCT ON 
(a.user_id, a.ip) USER_ID, IP,
a.country, a.timestamp,
(SELECT d.country_name from public.ip2loc_sm_tab AS d 
 WHERE public.ip2ipv4(a.ip) = d.context_ip) AS Country
from bloomapp.launch AS a
--WHERE STRPOS(a.ip,':') > 0 AND
--NOT (STRPOS(a.ip,'<') > 0) 
order by a.user_id, a.ip;

select public.ip2int2('2a02:c7f:982a:c900:40af:20d8:cc89:96a0');
SELECT public.ipv62country_name(42219915152422010371871408110514619333);
select public.ipv62country_name(2984692898625);
select public.ipv62country_name(2984688604831);
select public.ipv62country_name(1908931773);
SELECT public.ip2country_name('113.199.252.189');
SELECT public.ip2country_name('199.15.152.42');