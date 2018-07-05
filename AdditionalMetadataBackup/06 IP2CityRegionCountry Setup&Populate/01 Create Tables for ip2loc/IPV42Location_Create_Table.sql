-- Table: public.ipv42loc

-- DROP TABLE public.ipv42loc;

CREATE TABLE public.ipv42loc
(
    ipv4_from character varying(20) NOT NULL,
    ipv4_to character varying(20) NOT NULL,
    country_code character(4) COLLATE pg_catalog."default" NOT NULL,
    country_name character varying(64) COLLATE pg_catalog."default" NOT NULL,
	region character varying(100) COLLATE pg_catalog."default" NOT NULL,
	city character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT ipv42loc_db1_pkey PRIMARY KEY (ipv4_from, ipv4_to)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.ipv42loc
    OWNER to segment;

GRANT ALL ON TABLE public.ipv42loc TO bloomappuser;

GRANT ALL ON TABLE public.ipv42loc TO readbloom;

GRANT ALL ON TABLE public.ipv42loc TO readbloomtester;

GRANT ALL ON TABLE public.ipv42loc TO segment;

GRANT ALL ON TABLE public.ipv42loc TO silpgadmin;

-- Index: country_idx1

-- DROP INDEX public.country_idx1;

CREATE INDEX country_idx1
    ON public.ipv42loc USING btree
    (country_name COLLATE pg_catalog."default")
    TABLESPACE pg_default;

-- Index: ipv42loc_range_gist

-- DROP INDEX public.ipv42loc_range_gist;

CREATE INDEX ipv42loc_range_gist
    ON public.ipv42loc USING gist
    (box(point(ipv4_from::double precision, ipv4_from::double precision), point(ipv4_to::double precision, ipv4_to::double precision)))
    TABLESPACE pg_default;

-- Index: ipv4from_idx1

-- DROP INDEX public.ipv4from_idx1;

CREATE INDEX ipv4from_idx1
    ON public.ipv42loc USING btree
    (ipv4_from)
    TABLESPACE pg_default;

-- Index: ipv4to_idx1

-- DROP INDEX public.ipv4to_idx1;

CREATE INDEX ipv4to_idx1
    ON public.ipv42loc USING btree
    (ipv4_to)
    TABLESPACE pg_default;
	
-- Index: ipv4_CRC_idx1

-- DROP INDEX public.ipv4_CRC_idx1;

CREATE INDEX ipv4_CRC_idx1
    ON public.ipv42location USING btree
    (country_name, region, city)
    TABLESPACE pg_default;	
	
	
	select * from public.ipv42loc ORDER BY ipv4_from ASC LIMIT 100;