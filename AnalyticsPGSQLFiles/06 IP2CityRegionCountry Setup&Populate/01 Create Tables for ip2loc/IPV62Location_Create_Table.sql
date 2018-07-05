-- Table: public.ipv62location

-- DROP TABLE public.ipv62location;

CREATE TABLE public.ipv62location
(
    ipv6_from decimal (39,0) NOT NULL,
    ipv6_to decimal (39,0) NOT NULL,
    country_code character(2) COLLATE pg_catalog."default" NOT NULL,
    country_name character varying(64) COLLATE pg_catalog."default" NOT NULL,
	region character varying(100) COLLATE pg_catalog."default" NOT NULL,
	city character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT ipv62location_db1_pkey PRIMARY KEY (ipv6_from, ipv6_to)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.ipv62location
    OWNER to segment;

GRANT ALL ON TABLE public.ipv62location TO bloomappuser;

GRANT ALL ON TABLE public.ipv62location TO readbloom;

GRANT ALL ON TABLE public.ipv62location TO readbloomtester;

GRANT ALL ON TABLE public.ipv62location TO segment;

GRANT ALL ON TABLE public.ipv62location TO silpgadmin;

-- Index: country_idx1

-- DROP INDEX public.country_idx1;

CREATE INDEX country_idx2
    ON public.ipv62location USING btree
    (country_name COLLATE pg_catalog."default")
    TABLESPACE pg_default;

-- Index: ipv62location_range_gist

-- DROP INDEX public.ipv62location_range_gist;

CREATE INDEX ipv62location_range_gist
    ON public.ipv62location USING gist
    (box(point(ipv6_from::double precision, ipv6_from::double precision), point(ipv6_to::double precision, ipv6_to::double precision)))
    TABLESPACE pg_default;

-- Index: ipv6from_idx1

-- DROP INDEX public.ipv6from_idx1;

CREATE INDEX ipv6from_idx1
    ON public.ipv62location USING btree
    (ipv6_from)
    TABLESPACE pg_default;

-- Index: ipv6to_idx1

-- DROP INDEX public.ipv6to_idx1;

CREATE INDEX ipv6to_idx1
    ON public.ipv62location USING btree
    (ipv6_to)
    TABLESPACE pg_default;
	
	
	
	select * from public.ipv62loc ORDER BY ipv6_from ASC LIMIT 100;