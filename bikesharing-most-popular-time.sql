-- Hypothesis: The bikes are most used during commute hours,
-- 8-9am, during lunch 12-1am, and after work 5-6pm. They will 
-- be used very little at night.

select * 
from (
	      select '21:00-06:00' as `time`, SUM(count) as total_count from london_merged where hour(`timestamp`) > 21 or hour(`timestamp`) < 6 -- nighttime
    union select '06:00-09:00', SUM(count) as total_count from london_merged where hour(`timestamp`) >= 6 and hour(`timestamp`) < 9 -- morning
    union select '09:00-12:00', SUM(count) as total_count from london_merged where hour(`timestamp`) >= 9 and hour(`timestamp`) < 12 -- work 1
    union select '12:00-14:00', SUM(count) as total_count from london_merged where hour(`timestamp`) >= 12 and hour(`timestamp`) < 14 -- lunch
    union select '14:00-17:00', SUM(count) as total_count from london_merged where hour(`timestamp`) >= 14 and hour(`timestamp`) < 17 -- work 2
	union select '17:00-21:00', SUM(count) as total_count from london_merged where hour(`timestamp`) >= 17 and hour(`timestamp`) < 21 -- evening
) x
order by total_count desc;

-- Result:
-- The most popular times are after work (17:00 - 21:00) followed by afternoon (14:00 - 17:00) 
-- and before work (06:00 - 09:00). Nighttime is of course least popular and lunchtime is 
-- second least popular. 