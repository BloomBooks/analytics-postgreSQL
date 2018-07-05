-- Table: public.used_languages
-- DROP TABLE public.used_languages;

CREATE TABLE public.used_languages
(
    language_id character(20) COLLATE pg_catalog."default" NOT NULL,
    language_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT used_languages_pkey PRIMARY KEY (language_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.used_languages
    OWNER to segment;

-- Index: language_idx1
-- DROP INDEX public.language_idx1;

CREATE INDEX language_idx1
    ON public.used_languages USING btree
    (language_id COLLATE pg_catalog."default")
    TABLESPACE pg_default;
