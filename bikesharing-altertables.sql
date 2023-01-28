-- Add new columns for Boolean for is_holiday, is_weekend, and for 
-- season to be enum.
ALTER TABLE london_merged
RENAME COLUMN weather_code	TO int_weather_code;
RENAME COLUMN hum			TO humidity;
RENAME COLUMN	t2			TO felt_temp;
RENAME COLUMN	t1			TO real_temp; 
RENAME COLUMN   cnt 		TO count;
RENAME COLUMN   season		TO int_season; 
RENAME COLUMN	is_holiday	TO int_is_holiday; 
RENAME COLUMN 	is_weekend	TO int_is_weekend;
RENAME COLUMN   cnt 		TO count;

ALTER TABLE london_merged
ADD COLUMN weather enum('mostly_clear', 'scattered_clouds', 'broken_clouds', 'cloudy', 
						'rain', 'rain_and_thunderstorm', 'snowfall', 'freezing_fog');
ADD COLUMN  is_weekend bool;
ADD COLUMN	season enum('spring', 'summer', 'fall', 'winter'),
ADD COLUMN  is_holiday bool;

SET SQL_SAFE_UPDATES=0;
UPDATE london_merged
SET is_weekend = CASE int_is_weekend
					WHEN 0 THEN false
                    ELSE true 
				 END,
	is_holiday = CASE int_is_holiday 
					WHEN 0 THEN false 
                    ELSE true
				 END, 
	season = CASE int_season
					WHEN 0 THEN 'spring'
                    WHEN 1 THEN 'summer'
                    WHEN 2 THEN 'fall'
                    WHEN 3 THEN 'winter'
			END, 
	weather = CASE int_weather_code 
					WHEN 1 THEN 'mostly_clear'
                    WHEN 2 THEN 'scattered_clouds'
                    WHEN 3 THEN 'broken_clouds'
                    WHEN 4 THEN 'cloudy'
                    WHEN 7 THEN 'rain'
                    WHEN 10 THEN 'rain_and_thunderstorm'
                    WHEN 26 THEN 'snowfall'
                    WHEN 94 THEN 'freezing_fog'
				END;
                
-- Remove original columns
ALTER TABLE london_merged
DROP COLUMN int_weather_code, 
DROP COLUMN int_is_holiday,
DROP COLUMN int_is_weekend, 
DROP COLUMN int_season; 