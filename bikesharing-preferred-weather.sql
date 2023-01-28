-- Hypothesis: the most preferred weather to cycle in is 'mostly_clear'.
SELECT	weather, SUM(count) `count`
FROM	london_merged
GROUP BY weather
ORDER BY `count` desc;

-- Result: the most preferred whether is mostly_clear.