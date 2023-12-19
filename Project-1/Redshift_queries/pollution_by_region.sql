select country_region, sum(pollution_2023) as pollution 
from spectrum_schema.polluted_countries_ext
group by country_region ;
