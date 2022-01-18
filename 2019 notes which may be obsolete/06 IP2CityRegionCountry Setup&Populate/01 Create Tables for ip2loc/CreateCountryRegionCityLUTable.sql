-- Table: public.CountryRegionCityLU

-- DROP TABLE public.CountryRegionCityLU;

CREATE TABLE public.CountryRegionCityLU
(
    loc_uid bigint NOT NULL,
    country_code character(2) COLLATE pg_catalog."default" NOT NULL,
    country_name character varying(64) COLLATE pg_catalog."default" NOT NULL,
    region character varying(100) COLLATE pg_catalog."default" NOT NULL,
    city character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT CountryRegionCityLU_db1_pkey PRIMARY KEY (loc_uid)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.CountryRegionCityLU
    OWNER to segment;

GRANT ALL ON TABLE public.CountryRegionCityLU TO bloomappuser;

GRANT ALL ON TABLE public.CountryRegionCityLU TO readbloom;

GRANT ALL ON TABLE public.CountryRegionCityLU TO readbloomtester;

GRANT ALL ON TABLE public.CountryRegionCityLU TO segment;

GRANT ALL ON TABLE public.CountryRegionCityLU TO silpgadmin;

-- Index: CRC_idx1

-- DROP INDEX public.CRC_idx1;

CREATE INDEX CRC_idx1
    ON public.CountryRegionCityLU USING btree
    (country_name COLLATE pg_catalog."default", region COLLATE pg_catalog."default", city COLLATE pg_catalog."default")
    TABLESPACE pg_default;	


select * from public.CountryRegionCityLU ORDER BY ipv4_from ASC LIMIT 100;