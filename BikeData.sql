SELECT * 
INTO bike_table
FROM
--https://docs.microsoft.com/en-us/sql/t-sql/functions/date-and-time-data-types-and-functions-transact-sql?view=sql-server-ver15
(SELECT
	member_casual, rideable_type, started_at, ended_at, start_station_name, end_station_name, 
	DATEDIFF(minute, started_at, ended_at) as ride_length,
	DATENAME(month, started_at) as month,
	DATENAME(day, started_at) as day,
	DATENAME(year, started_at) as year,
	DATENAME(WEEKDAY, started_at) as day_of_week,
	DATENAME(hour, started_at) as start_hour,
	DATENAME(hour, ended_at) as end_hour 
FROM
	Apr_2021
WHERE
	start_station_name IS NOT NULL AND end_station_name IS NOT NULL
UNION ALL

SELECT
	member_casual, rideable_type, started_at, ended_at, start_station_name, end_station_name,
	DATEDIFF(minute, started_at, ended_at) as ride_length,
	DATENAME(month, started_at) as month,
	DATENAME(day, started_at) as day,
	DATENAME(year, started_at) as year,
	DATENAME(WEEKDAY, started_at) as day_of_week,
	DATENAME(hour, started_at) as start_hour,
	DATENAME(hour, ended_at) as end_hour 
FROM
	May_2021
WHERE
	start_station_name IS NOT NULL AND end_station_name IS NOT NULL
UNION ALL

SELECT
	member_casual, rideable_type, started_at, ended_at, start_station_name, end_station_name,
	DATEDIFF(minute, started_at, ended_at) as ride_length,
	DATENAME(month, started_at) as month,
	DATENAME(day, started_at) as day,
	DATENAME(year, started_at) as year,
	DATENAME(WEEKDAY, started_at) as day_of_week,
	DATENAME(hour, started_at) as start_hour,
	DATENAME(hour, ended_at) as end_hour 
FROM
	Jun_2021
WHERE
	start_station_name IS NOT NULL AND end_station_name IS NOT NULL
UNION ALL

SELECT
	member_casual, rideable_type, started_at, ended_at, start_station_name, end_station_name,
	DATEDIFF(minute, started_at, ended_at) as ride_length,
	DATENAME(month, started_at) as month,
	DATENAME(day, started_at) as day,
	DATENAME(year, started_at) as year,
	DATENAME(WEEKDAY, started_at) as day_of_week,
	DATENAME(hour, started_at) as start_hour,
	DATENAME(hour, ended_at) as end_hour 
FROM
	Jul_2021
WHERE
	start_station_name IS NOT NULL AND end_station_name IS NOT NULL
UNION ALL

SELECT
	member_casual, rideable_type, started_at, ended_at, start_station_name, end_station_name,
	DATEDIFF(minute, started_at, ended_at) as ride_length,
	DATENAME(month, started_at) as month,
	DATENAME(day, started_at) as day,
	DATENAME(year, started_at) as year,
	DATENAME(WEEKDAY, started_at) as day_of_week,
	DATENAME(hour, started_at) as start_hour,
	DATENAME(hour, ended_at) as end_hour 
FROM
	Aug_2021
WHERE
	start_station_name IS NOT NULL AND end_station_name IS NOT NULL
UNION ALL

SELECT
	member_casual, rideable_type, started_at, ended_at, start_station_name, end_station_name,
	DATEDIFF(minute, started_at, ended_at) as ride_length,
	DATENAME(month, started_at) as month,
	DATENAME(day, started_at) as day,
	DATENAME(year, started_at) as year,
	DATENAME(WEEKDAY, started_at) as day_of_week,
	DATENAME(hour, started_at) as start_hour,
	DATENAME(hour, ended_at) as end_hour 
FROM
	Sep_2021
WHERE
	start_station_name IS NOT NULL AND end_station_name IS NOT NULL
UNION ALL

SELECT
	member_casual, rideable_type, started_at, ended_at, start_station_name, end_station_name,
	DATEDIFF(minute, started_at, ended_at) as ride_length,
	DATENAME(month, started_at) as month,
	DATENAME(day, started_at) as day,
	DATENAME(year, started_at) as year,
	DATENAME(WEEKDAY, started_at) as day_of_week,
	DATENAME(hour, started_at) as start_hour,
	DATENAME(hour, ended_at) as end_hour 
FROM
	Oct_2021
WHERE
	start_station_name IS NOT NULL AND end_station_name IS NOT NULL
UNION ALL

SELECT
	member_casual, rideable_type, started_at, ended_at, start_station_name, end_station_name,
	DATEDIFF(minute, started_at, ended_at) as ride_length,
	DATENAME(month, started_at) as month,
	DATENAME(day, started_at) as day,
	DATENAME(year, started_at) as year,
	DATENAME(WEEKDAY, started_at) as day_of_week,
	DATENAME(hour, started_at) as start_hour,
	DATENAME(hour, ended_at) as end_hour 
FROM
	Nov_2021
WHERE
	start_station_name IS NOT NULL AND end_station_name IS NOT NULL
UNION ALL

SELECT
	member_casual, rideable_type, started_at, ended_at, start_station_name, end_station_name,
	DATEDIFF(minute, started_at, ended_at) as ride_length,
	DATENAME(month, started_at) as month,
	DATENAME(day, started_at) as day,
	DATENAME(year, started_at) as year,
	DATENAME(WEEKDAY, started_at) as day_of_week,
	DATENAME(hour, started_at) as start_hour,
	DATENAME(hour, ended_at) as end_hour 
FROM
	Dec_2021
WHERE
	start_station_name IS NOT NULL AND end_station_name IS NOT NULL
UNION ALL

SELECT
	member_casual, rideable_type, started_at, ended_at, start_station_name, end_station_name,
	DATEDIFF(minute, started_at, ended_at) as ride_length,
	DATENAME(month, started_at) as month,
	DATENAME(day, started_at) as day,
	DATENAME(year, started_at) as year,
	DATENAME(WEEKDAY, started_at) as day_of_week,
	DATENAME(hour, started_at) as start_hour,
	DATENAME(hour, ended_at) as end_hour 
FROM
	Jan_2022
WHERE
	start_station_name IS NOT NULL AND end_station_name IS NOT NULL
UNION ALL

SELECT
	member_casual, rideable_type, started_at, ended_at, start_station_name, end_station_name,
	DATEDIFF(minute, started_at, ended_at) as ride_length,
	DATENAME(month, started_at) as month,
	DATENAME(day, started_at) as day,
	DATENAME(year, started_at) as year,
	DATENAME(WEEKDAY, started_at) as day_of_week,
	DATENAME(hour, started_at) as start_hour,
	DATENAME(hour, ended_at) as end_hour 
FROM
	Feb_2022
WHERE
	start_station_name IS NOT NULL AND end_station_name IS NOT NULL
UNION ALL

SELECT
	member_casual, rideable_type, started_at, ended_at, start_station_name, end_station_name,
	DATEDIFF(minute, started_at, ended_at) as ride_length,
	DATENAME(month, started_at) as month,
	DATENAME(day, started_at) as day,
	DATENAME(year, started_at) as year,
	DATENAME(WEEKDAY, started_at) as day_of_week,
	DATENAME(hour, started_at) as start_hour,
	DATENAME(hour, ended_at) as end_hour
FROM
	Mar_2022
WHERE
	start_station_name IS NOT NULL AND end_station_name IS NOT NULL) as BikeData --https://stackoverflow.com/questions/20107827/insert-data-into-temp-table-with-query