-- View: bloomapp.uniqueuserchannel
-- REVOKE SELECT ON bloomapp.uniqueuserchannel FROM bloomappuser;
-- DROP VIEW bloomapp.uniqueuserchannel;

CREATE OR REPLACE VIEW bloomapp.uniqueuserchannel AS
 SELECT DISTINCT ON (a.user_id) a.user_id, a.channel,
    '03 mo'::text AS reference
   FROM bloomapp.create_book a
  WHERE a.timestamp > ((date_trunc('month', current_date) - interval '1 day') - INTERVAL '3 months')
    AND a.timestamp < date_trunc('month', current_date);

ALTER TABLE bloomapp.uniqueuserchannel
    OWNER TO silpgadmin;

GRANT ALL ON TABLE bloomapp.uniqueuserchannel TO silpgadmin;
GRANT SELECT ON TABLE bloomapp.uniqueuserchannel TO bloomappuser;