-- Table: public.ip2loc_sm_tab
-- DROP TABLE public.ip2loc_sm_tab;

CREATE TABLE public.ip2loc_sm_tab
(
    context_ip bigint NOT NULL,
    country_code character(3) COLLATE pg_catalog."default" NOT NULL,
    country_name character varying(64) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT ip2loc_sm_tab_db1_pkey PRIMARY KEY (context_ip)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.ip2loc_sm_tab
    OWNER to segment;

-- Index: country_idx4
-- DROP INDEX public.country_idx4;

CREATE INDEX country_idx4
    ON public.ip2loc_sm_tab USING btree
    (country_name COLLATE pg_catalog."default")
    TABLESPACE pg_default;

-- Index: ip_idx1
-- DROP INDEX public.ip_idx1;

CREATE INDEX ip_idx1
    ON public.ip2loc_sm_tab USING btree
    (context_ip)
    TABLESPACE pg_default;