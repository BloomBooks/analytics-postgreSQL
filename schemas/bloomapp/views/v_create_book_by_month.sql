-- View: bloomapp.v_create_book_count_by_month

-- DROP VIEW bloomapp.v_create_book_count_by_month;

CREATE OR REPLACE VIEW bloomapp.v_create_book_count_by_month AS
    SELECT count(*),
        date_trunc('month'::text, c."timestamp")
    FROM bloomapp.create_book c
    WHERE c."timestamp" < date_trunc('month'::text, 'now'::text::date::timestamp with time zone)
    GROUP BY date_trunc('month'::text, c."timestamp");


ALTER TABLE bloomapp.v_create_book_count_by_month
    OWNER TO silpgadmin;

GRANT ALL ON TABLE bloomapp.v_create_book_count_by_month TO silpgadmin;
GRANT SELECT ON TABLE bloomapp.v_create_book_count_by_month TO bloomappuser;
GRANT SELECT ON TABLE bloomapp.v_create_book_count_by_month TO readbloom;