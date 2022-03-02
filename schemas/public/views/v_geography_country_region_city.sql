
CREATE OR REPLACE VIEW public.v_geography_country_region_city AS

SELECT  countries.countryname as country,
        regions.name as region,
        cities.closest_city_center as city,
        cities.geoid as city_geoid,
        cities.latitude,
        cities.longitude,
        countries.countrycode as country_code
FROM    geography_city_centers cities
        left outer join countrycodes countries
            on cities.countrycode = countries.countrycode
        left outer join geography_regioncodes regions
            on cities.regioncode = regions.code
;