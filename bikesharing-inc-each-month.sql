-- Hypothesis: Bike use over time increases month on month.
drop function if exists increases ;
delimiter ;;
create function increases() returns bool -- This function is buggy and returns wrong output. 
reads sql data
begin
	declare len int; declare i int; 
    declare prev int; declare curr int;
	SELECT COUNT(count) FROM london_merged INTO len;
    -- GROUP BY MONTH(`timestamp`), YEAR(`timestamp`);
    
    set @i = 1; set @prev = 0; set @curr = 0; 
    while @i <= @len do
		set @prev = @curr; 
		select `count`
        into curr
        from (
			SELECT row_number() over (order by `timestamp`) row_num, CONCAT(year(`timestamp`), "-", MONTH(`timestamp`)) `date`, SUM(count) as count
			FROM london_merged
			GROUP BY MONTH(`timestamp`), YEAR(`timestamp`)
		) x
        where row_num = @i;

        if (@prev > @curr) then return false; end if;
		set @i = @i + 1;
	end while;
    return true; 
end;
;;

-- Select statement: gets counts of each month.
-- use this as function does not work
SELECT	row_number() over (order by `timestamp`) `rn`, CONCAT(YEAR(timestamp), "-", MONTH(timestamp)) `date`,
		SUM(count) as `count`
FROM london_merged
GROUP BY MONTH(timestamp), YEAR(timestamp)
ORDER BY count asc

-- Bike use does not increase month on month, but 
-- changes depending on the month in question. 