-- This script was run 2/14.
-- When we migrated from the old 9.6 server to the new one,
-- we didn't bring over segment user's ownership of its tables.
-- This corrects that so segment can add new columns as needed.

ALTER TABLE bloomapp.audit OWNER TO segment;
ALTER TABLE bloomapp.change_content_languages OWNER TO segment;
ALTER TABLE bloomapp.change_page_layout OWNER TO segment;
ALTER TABLE bloomapp.change_picture OWNER TO segment;
ALTER TABLE bloomapp.change_video OWNER TO segment;
ALTER TABLE bloomapp.create_bloom_pack OWNER TO segment;
ALTER TABLE bloomapp.create_book OWNER TO segment;
ALTER TABLE bloomapp.create_new_vernacular_collection OWNER TO segment;
ALTER TABLE bloomapp.created OWNER TO segment;
ALTER TABLE bloomapp.created_new_source_collection OWNER TO segment;
ALTER TABLE bloomapp.delete_page OWNER TO segment;
ALTER TABLE bloomapp.downloaded_book_failure OWNER TO segment;
ALTER TABLE bloomapp.downloaded_book_success OWNER TO segment;
ALTER TABLE bloomapp.duplicate_page OWNER TO segment;
ALTER TABLE bloomapp.exception OWNER TO segment;
ALTER TABLE bloomapp.exported_to_doc_format OWNER TO segment;
ALTER TABLE bloomapp.exported_xml_for_in_design OWNER TO segment;
ALTER TABLE bloomapp.identifies OWNER TO segment;
ALTER TABLE bloomapp.insert_template_page OWNER TO segment;
ALTER TABLE bloomapp.launch OWNER TO segment;
ALTER TABLE bloomapp.print_pdf OWNER TO segment;
ALTER TABLE bloomapp.publish_android OWNER TO segment;
ALTER TABLE bloomapp.register OWNER TO segment;
ALTER TABLE bloomapp.relocate_page OWNER TO segment;
ALTER TABLE bloomapp.save_e_pub OWNER TO segment;
ALTER TABLE bloomapp.save_epub OWNER TO segment;
ALTER TABLE bloomapp.save_pdf OWNER TO segment;
ALTER TABLE bloomapp.select_page OWNER TO segment;
ALTER TABLE bloomapp.team_collection_checkin_book OWNER TO segment;
ALTER TABLE bloomapp.team_collection_checkout_book OWNER TO segment;
ALTER TABLE bloomapp.team_collection_conflicting_edit_or_checkout OWNER TO segment;
ALTER TABLE bloomapp.team_collection_create OWNER TO segment;
ALTER TABLE bloomapp.team_collection_join OWNER TO segment;
ALTER TABLE bloomapp.team_collection_open OWNER TO segment;
ALTER TABLE bloomapp.tracks OWNER TO segment;
ALTER TABLE bloomapp.upgrade OWNER TO segment;
ALTER TABLE bloomapp.upload_book_success OWNER TO segment;
ALTER TABLE bloomapp.upload_book_failure OWNER TO segment;
ALTER TABLE bloomapp.upload_book_failure_system_time OWNER TO segment;
ALTER TABLE bloomapp.users OWNER TO segment;

ALTER TABLE bloomlibrary_org.book_detail OWNER TO segment;
ALTER TABLE bloomlibrary_org.book_or_shelf_opened OWNER TO segment;
ALTER TABLE bloomlibrary_org.book_search OWNER TO segment;
ALTER TABLE bloomlibrary_org.comprehension OWNER TO segment;
ALTER TABLE bloomlibrary_org.download_book OWNER TO segment;
ALTER TABLE bloomlibrary_org.log_in OWNER TO segment;
ALTER TABLE bloomlibrary_org.log_out OWNER TO segment;
ALTER TABLE bloomlibrary_org.open_collection OWNER TO segment;
ALTER TABLE bloomlibrary_org.pages OWNER TO segment;
ALTER TABLE bloomlibrary_org.pages_read OWNER TO segment;
ALTER TABLE bloomlibrary_org.preview OWNER TO segment;
ALTER TABLE bloomlibrary_org.search_failed OWNER TO segment;
ALTER TABLE bloomlibrary_org.tracks OWNER TO segment;

ALTER TABLE bloomreader.accounts OWNER TO segment;
ALTER TABLE bloomreader.application_backgrounded OWNER TO segment;
ALTER TABLE bloomreader.application_installed OWNER TO segment;
ALTER TABLE bloomreader.application_opened OWNER TO segment;
ALTER TABLE bloomreader.application_updated OWNER TO segment;
ALTER TABLE bloomreader.book_or_shelf_opened OWNER TO segment;
ALTER TABLE bloomreader.check_for_sending_events OWNER TO segment;
ALTER TABLE bloomreader.comprehension OWNER TO segment;
ALTER TABLE bloomreader.groups OWNER TO segment;
ALTER TABLE bloomreader.identifies OWNER TO segment;
ALTER TABLE bloomreader.install_attributed OWNER TO segment;
ALTER TABLE bloomreader.pages_read OWNER TO segment;
ALTER TABLE bloomreader.questions_correct OWNER TO segment;
ALTER TABLE bloomreader.request_gps OWNER TO segment;
ALTER TABLE bloomreader.screens OWNER TO segment;
ALTER TABLE bloomreader.tracks OWNER TO segment;
ALTER TABLE bloomreader.users OWNER TO segment;

ALTER TABLE bloomreaderbeta.accounts OWNER TO segment;
ALTER TABLE bloomreaderbeta.application_backgrounded OWNER TO segment;
ALTER TABLE bloomreaderbeta.application_installed OWNER TO segment;
ALTER TABLE bloomreaderbeta.application_opened OWNER TO segment;
ALTER TABLE bloomreaderbeta.application_updated OWNER TO segment;
ALTER TABLE bloomreaderbeta.book_or_shelf_opened OWNER TO segment;
ALTER TABLE bloomreaderbeta.check_for_sending_events OWNER TO segment;
ALTER TABLE bloomreaderbeta.comprehension OWNER TO segment;
ALTER TABLE bloomreaderbeta.groups OWNER TO segment;
ALTER TABLE bloomreaderbeta.identifies OWNER TO segment;
ALTER TABLE bloomreaderbeta.install_attributed OWNER TO segment;
ALTER TABLE bloomreaderbeta.pages_read OWNER TO segment;
ALTER TABLE bloomreaderbeta.questions_correct OWNER TO segment;
ALTER TABLE bloomreaderbeta.request_gps OWNER TO segment;
ALTER TABLE bloomreaderbeta.screens OWNER TO segment;
ALTER TABLE bloomreaderbeta.tracks OWNER TO segment;
ALTER TABLE bloomreaderbeta.users OWNER TO segment;

ALTER TABLE bloomreadertest.accounts OWNER TO segment;
ALTER TABLE bloomreadertest.application_backgrounded OWNER TO segment;
ALTER TABLE bloomreadertest.application_installed OWNER TO segment;
ALTER TABLE bloomreadertest.application_opened OWNER TO segment;
ALTER TABLE bloomreadertest.application_updated OWNER TO segment;
ALTER TABLE bloomreadertest.book_or_shelf_opened OWNER TO segment;
ALTER TABLE bloomreadertest.check_for_sending_events OWNER TO segment;
ALTER TABLE bloomreadertest.comprehension OWNER TO segment;
ALTER TABLE bloomreadertest.groups OWNER TO segment;
ALTER TABLE bloomreadertest.identifies OWNER TO segment;
ALTER TABLE bloomreadertest.install_attributed OWNER TO segment;
ALTER TABLE bloomreadertest.pages_read OWNER TO segment;
ALTER TABLE bloomreadertest.questions_correct OWNER TO segment;
ALTER TABLE bloomreadertest.request_gps OWNER TO segment;
ALTER TABLE bloomreadertest.screens OWNER TO segment;
ALTER TABLE bloomreadertest.tracks OWNER TO segment;
ALTER TABLE bloomreadertest.users OWNER TO segment;

ALTER TABLE hearthis.added_skipped_style OWNER TO segment;
ALTER TABLE hearthis.created OWNER TO segment;
ALTER TABLE hearthis.error_setting_paratext_projects_folder OWNER TO segment;
ALTER TABLE hearthis.exception OWNER TO segment;
ALTER TABLE hearthis.flubbed_record_press OWNER TO segment;
ALTER TABLE hearthis.identifies OWNER TO segment;
ALTER TABLE hearthis.launch OWNER TO segment;
ALTER TABLE hearthis.loaded_glyssen_script_project OWNER TO segment;
ALTER TABLE hearthis.loaded_paratext_project OWNER TO segment;
ALTER TABLE hearthis.loaded_text_release_bundle_project OWNER TO segment;
ALTER TABLE hearthis.play OWNER TO segment;
ALTER TABLE hearthis.project_created_from_bundle OWNER TO segment;
ALTER TABLE hearthis.project_created_from_glyssen_script OWNER TO segment;
ALTER TABLE hearthis.published OWNER TO segment;
ALTER TABLE hearthis.punctuation_settings_changed OWNER TO segment;
ALTER TABLE hearthis.re_recorded_a_clip OWNER TO segment;
ALTER TABLE hearthis.re_recorded_a_line OWNER TO segment;
ALTER TABLE hearthis.recorded_a_line OWNER TO segment;
ALTER TABLE hearthis.recording_clip OWNER TO segment;
ALTER TABLE hearthis.set_project OWNER TO segment;
ALTER TABLE hearthis.tracks OWNER TO segment;
ALTER TABLE hearthis.upgrade OWNER TO segment;
ALTER TABLE hearthis.users OWNER TO segment;

ALTER TABLE pdfdropletapp.created OWNER TO segment;
ALTER TABLE pdfdropletapp.exception OWNER TO segment;
ALTER TABLE pdfdropletapp.identifies OWNER TO segment;
ALTER TABLE pdfdropletapp.launch OWNER TO segment;
ALTER TABLE pdfdropletapp.show_about OWNER TO segment;
ALTER TABLE pdfdropletapp.show_instructions OWNER TO segment;
ALTER TABLE pdfdropletapp.tracks OWNER TO segment;
ALTER TABLE pdfdropletapp.upgrade OWNER TO segment;
ALTER TABLE pdfdropletapp.users OWNER TO segment;