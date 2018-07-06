/* ALTER TABLE bloomreadertest.pages_read DROP CONSTRAINT title_idx1; 
   ALTER TABLE bloomreadertest.questions_correct DROP CONSTRAINT title_idx2; */
   
CREATE INDEX title_idx1 ON bloomreadertest.pages_read((lower(title)));
CREATE INDEX Language_idx1 ON bloomreadertest.pages_read(content_lang);
CREATE INDEX audio_idx2 ON bloomreadertest.pages_read(audio_pages);
CREATE INDEX context_idx2 ON bloomreadertest.pages_read(context_ip);
CREATE INDEX lastpage_idx2 ON bloomreadertest.pages_read(last_numbered_page_read);

CREATE INDEX title_idx2 ON bloomreadertest.questions_correct((lower(title)));

CREATE INDEX Language_idx2 ON public.languagecodes(langid);
CREATE INDEX Language_idx3 ON public.languagecodes(langid2);

CREATE INDEX ipfrom_idx1 ON public.ip2location(ip_from);
CREATE INDEX ipto_idx2 ON public.ip2location(ip_to);
CREATE INDEX country_idx3 ON public.ip2location(country_name);

select * from pg_indexes where tablename = 'pages_read';
select * from pg_indexes where tablename = 'languagecodes';
select * from pg_indexes where tablename = 'questions_correct';
SELECT indexdef FROM pg_indexes WHERE indexname like 'title_idx%'



