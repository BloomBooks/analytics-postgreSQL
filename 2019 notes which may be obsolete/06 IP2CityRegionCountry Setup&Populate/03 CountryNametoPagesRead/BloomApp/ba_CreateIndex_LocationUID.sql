CREATE INDEX loc_uid_idx on public.countryregioncitylu USING btree (loc_uid) TABLESPACE pg_default;

CREATE INDEX launch_loc_uid_idx ON bloomapp.launch USING btree (location_uid) TABLESPACE pg_default;
CREATE INDEX created_loc_uid_idx ON bloomapp.created USING btree (location_uid) TABLESPACE pg_default;    
CREATE INDEX create_book_loc_uid_idx ON bloomapp.create_book USING btree (location_uid) TABLESPACE pg_default;
CREATE INDEX app_installed_loc_uid_idx ON bloomreader.application_installed
		USING btree (location_uid) TABLESPACE pg_default;