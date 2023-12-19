DROP TABLE IF EXISTS spectrum_schema.polluted_countries_ext ;
create external table spectrum_schema.polluted_countries_ext (
  pollution_2023 BIGINT, 
  pollution_growth_rate DOUBLE PRECISION, 
  country_name VARCHAR(255), 
  ccn3 BIGINT, 
  country_region VARCHAR(255), 
  country_land_area_in_km DOUBLE PRECISION, 
  pollution_density_in_km DOUBLE PRECISION, 
  pollution_density_per_mile DOUBLE PRECISION, 
  pollution_rank BIGINT, 
  mostpollutedcountries_particlepollution DOUBLE PRECISION)
stored as parquet
location 's3://sbhujbal123/curated/';
