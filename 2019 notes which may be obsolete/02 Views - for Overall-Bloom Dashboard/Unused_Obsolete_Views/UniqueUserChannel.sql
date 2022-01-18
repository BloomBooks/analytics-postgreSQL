-- View: bloomreadertest.uniqueuserchannel
-- REVOKE SELECT ON bloomreadertest.uniqueuserchannel FROM readbloomtester;
-- DROP VIEW bloomreadertest.uniqueuserchannel;

CREATE OR REPLACE VIEW bloomreadertest.uniqueuserchannel AS
 SELECT DISTINCT ON (a.user_id) a.user_id, a.channel,
    '03 mo'::text AS reference
   FROM bloomapp.create_book a
  WHERE a.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '3 months')
    AND a.timestamp < date_trunc('month', current_date);

ALTER TABLE bloomreadertest.uniqueuserchannel
    OWNER TO silpgadmin;

GRANT ALL ON TABLE bloomreadertest.uniqueuserchannel TO silpgadmin;
GRANT SELECT ON TABLE bloomreadertest.uniqueuserchannel TO readbloomtester;