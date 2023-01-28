-- Hypothesis: 
-- The optimum condition to cycle in is not on a holiday, 
-- but on a weekend and during spring. 


-- The most popular season is: 
-- TODO: this gets all four seasons, but I want to just get 
-- summer | 6424609. How do? 
SELECT season, val
FROM (
		SELECT season, SUM(count) as val 
			FROM london_merged WHERE season='spring'
union	SELECT season, SUM(count) as val
			FROM london_merged WHERE season='summer'
union	SELECT season, SUM(count) as val
			FROM london_merged WHERE season='fall'
union 	SELECT season, SUM(count) as val
			FROM london_merged WHERE season='winter'
) x
GROUP BY season
ORDER BY val DESC;

-- To work out which days are best to cycle on, we can split to
-- the unions of (season, is_weekend, is_holiday), e.g. find 
-- (spring, is_weekend, is_holiday), (summer, is_weekend, 
-- is_holiday), etc. Then find counts for each of them, and grab
-- the max of these. 
-- As holidays never fall on a weekend we do not need to check for 
-- this.
SELECT season, is_weekend, is_holiday, val
FROM (
-- Spring 
		SELECT season, is_weekend, is_holiday, SUM(count) as val 
			FROM london_merged
            WHERE season='spring' AND is_weekend=false AND is_holiday=true
union	SELECT season, is_weekend, is_holiday, SUM(count) as val 
			FROM london_merged
            WHERE season='spring' AND is_weekend=true AND is_holiday=false
union	SELECT season, is_weekend, is_holiday, SUM(count) as val 
			FROM london_merged
            WHERE season='spring' AND is_weekend=false AND is_holiday=false

-- Summer 
union	SELECT season, is_weekend, is_holiday, SUM(count) as val 
			FROM london_merged
            WHERE season='summer' AND is_weekend=false AND is_holiday=true
union	SELECT season, is_weekend, is_holiday, SUM(count) as val 
			FROM london_merged
            WHERE season='summer' AND is_weekend=true AND is_holiday=false
union	SELECT season, is_weekend, is_holiday, SUM(count) as val 
			FROM london_merged
            WHERE season='summer' AND is_weekend=false AND is_holiday=false
            
-- Autumn  
union	SELECT season, is_weekend, is_holiday, SUM(count) as val 
			FROM london_merged
            WHERE season='fall' AND is_weekend=false AND is_holiday=true
union	SELECT season, is_weekend, is_holiday, SUM(count) as val 
			FROM london_merged
            WHERE season='fall' AND is_weekend=true AND is_holiday=false
union	SELECT season, is_weekend, is_holiday, SUM(count) as val 
			FROM london_merged
            WHERE season='fall' AND is_weekend=false AND is_holiday=false

-- Winter 
union	SELECT season, is_weekend, is_holiday, SUM(count) as val 
			FROM london_merged
            WHERE season='winter' AND is_weekend=false AND is_holiday=true
union	SELECT season, is_weekend, is_holiday, SUM(count) as val 
			FROM london_merged
            WHERE season='winter' AND is_weekend=true AND is_holiday=false
union	SELECT season, is_weekend, is_holiday, SUM(count) as val 
			FROM london_merged
            WHERE season='winter' AND is_weekend=false AND is_holiday=false
) x
GROUP BY season, is_weekend, is_holiday
ORDER BY val DESC;

-- What do we get from this? 
-- The most popular times are when it is neither a holiday nor a weekend, presumably as it 
-- is commuters to work. 
-- Then, the most popular time is summer, followed by spring, fall, winter, on a weekend.
-- Then spring, winter, summer on a holiday are least popular. 