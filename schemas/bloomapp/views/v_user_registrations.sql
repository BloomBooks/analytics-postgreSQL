-- View: bloomapp.v_user_registrations
 -- DROP VIEW bloomapp.v_user_registrations;

CREATE OR REPLACE VIEW bloomapp.v_user_registrations AS
SELECT to_char(date(u.received_at)::timestamp with time zone, 'YYYY-MM-DD'::text) AS date,
       u.email,
       u.first_name,
       u.last_name,
       u.organization,
       u.how_using,

    (SELECT d.country_name
     FROM ip2loc_sm_tab d
     WHERE ip2ipv4(u.context_ip::character varying) = d.context_ip) AS country
FROM bloomapp.users u
WHERE u.last_name IS NOT NULL;


ALTER TABLE bloomapp.v_user_registrations OWNER TO silpgadmin;

