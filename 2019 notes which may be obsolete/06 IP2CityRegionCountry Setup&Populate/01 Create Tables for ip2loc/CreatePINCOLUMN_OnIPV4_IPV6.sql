-- Column: public.ipv42location.Country_Region_City_id

-- ALTER TABLE public.ipv42location DROP COLUMN Country_Region_City_id;

ALTER TABLE public.ipv42location
    ADD COLUMN Country_Region_City_id bigint;


-- Column: public.ipv62location.Country_Region_City_id

-- ALTER TABLE public.ipv62location DROP COLUMN Country_Region_City_id;

ALTER TABLE public.ipv62location
    ADD COLUMN Country_Region_City_id bigint;