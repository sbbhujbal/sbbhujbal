select country_name,pollution_rank
from spectrum_schema.polluted_countries_ext
group by country_name,pollution_rank
order by pollution_rank
limit 10;