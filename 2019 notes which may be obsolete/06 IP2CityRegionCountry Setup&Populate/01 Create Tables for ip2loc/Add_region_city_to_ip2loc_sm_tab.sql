-- Column: public.ip2loc_sm_tab.region

-- ALTER TABLE public.ip2loc_sm_tab DROP COLUMN region;

ALTER TABLE public.ip2loc_sm_tab
    ADD COLUMN region character varying(100) COLLATE pg_catalog."default";

-- Column: public.ip2loc_sm_tab.city

-- ALTER TABLE public.ip2loc_sm_tab DROP COLUMN city;

ALTER TABLE public.ip2loc_sm_tab
    ADD COLUMN city character varying(100) COLLATE pg_catalog."default";
	
	
-- ALTER TABLE public.ipv42location DROP COLUMN country_region_city_id;