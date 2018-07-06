REVOKE SELECT ON bloomapp.user_languages FROM bloomappuser;
DROP VIEW bloomapp.user_languages;

CREATE VIEW bloomapp.user_languages AS
    SELECT a.id, a.received_at, a.organization as organization_raw, 
	  (SELECT c.language_name FROM public.used_languages AS c WHERE a.uilanguage=c.language_id) AS UILanguage
    FROM bloomapp.users AS a;
 
GRANT ALL PRIVILEGES on bloomapp.user_languages to bloomappuser,readbloom, silpgadmin;
select * FROM bloomapp.user_languages;

select * from bloomapp.users where length(uilanguage)>2;
select langid2,clname from public.languagecodes where langid ='pbu';


CREATE INDEX language_idx3
    ON bloomapp.users USING btree
    (uilanguage COLLATE pg_catalog."default")
    TABLESPACE pg_default;
