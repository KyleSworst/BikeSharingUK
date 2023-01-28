-- Hypothesis: 
-- More people cycle at a lower humidity than a higher humidity. 
select * 
from (
		  select '0 to 20%' as humidity, AVG(count) avg_count from london_merged where humidity > 0 and humidity <= 20
	union select '20 to 40%', AVG(count) from london_merged where humidity > 20 and humidity <= 40
    union select '40 to 60%', AVG(count) from london_merged where humidity > 40 and humidity <= 60
    union select '60 to 80%', AVG(count) from london_merged where humidity > 60 and humidity <= 80
    union select '80 to 100%', AVG(count) from london_merged where humidity > 80 and humidity <= 100
) x
order by avg_count desc;
-- Though no results for lowest humidity levels (0-20%) data confirms that lower humidities are 
-- preferred.