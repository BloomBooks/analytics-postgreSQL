INSERT INTO bloomreader.pages_read(
	id, received_at, uuid_ts, anonymous_id, context_app_build, context_app_name, context_app_namespace, context_app_version, 
	context_device_id, context_device_manufacturer, context_device_model, context_device_name, context_device_type, context_ip, 
	context_library_name, context_library_version, context_locale, context_major_minor, context_network_carrier, context_os_name, 
	context_os_version, context_screen_density, context_screen_height, context_screen_width, context_timezone, 
	context_traits_anonymous_id, context_user_agent, event, event_text, last_page, original_timestamp, sent_at, "timestamp", 
	title, audio_pages, non_audio_pages, context_traits_user_id, user_id, branding_project_name, context_network_bluetooth, 
	context_network_cellular, context_network_wifi, content_lang, last_numbered_page_read, total_numbered_pages, question_count, 
	country_name)
	VALUES 
('1ba71f1b-d8eb-4000-ae65-0f5a38651d56',TIMESTAMP '2017-10-04 14:54:44+00',NULL,'30cc7568-bd93-43ea-813d-ad6c2710ea16',100085,
 'Bloom Reader','org.sil.bloom.reader.alpha','1.0.85-alpha','7d8de3d27560d8e8','LGE','LG-D855','g3','android','108.177.6.56',
 'analytics-android','4.3.0','en-US','1',NULL,'Android','4.4.2',4,2392,1440,'America/Los_Angeles',
 '30cc7568-bd93-43ea-813d-ad6c2710ea16',
 'Dalvik/1.6.0 (Linux; U; Android 4.4.2; LG-D855 Build/KVT49L.A1401987978)','pages_read','Pages Read',-1,
 TIMESTAMP '2017-10-04 14:54:18.666+00',TIMESTAMP '2017-10-04 14:54:44+00',TIMESTAMP '2017-10-04 14:54:18.728+00',
 'The Moon and the Cap',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
 
 select bloomreader.pages_read.country_name from bloomreader.pages_read 
 where bloomreader.pages_read.id='1ba71f1b-d8eb-4000-ae65-0f5a38651d56';
 
 DELETE FROM bloomreader.pages_read WHERE bloomreader.pages_read.id='1ba71f1b-d8eb-4000-ae65-0f5a38651d56' RETURNING *;