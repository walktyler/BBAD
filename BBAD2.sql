--Raw data imported from the csv file
SELECT * FROM Bus_Breakdown_and_Delays_20250331;

--Data isn't normalized and lacks consistancy 
SELECT TOP 100 BUSBREAKDOWN_ID, SCHOOLS_SERVICED, How_Long_Delayed FROM Bus_Breakdown_and_Delays_20250331
WHERE LEN(SCHOOLS_SERVICED) > 5;

SELECT TOP 100 RANK() OVER(ORDER BY BUSBREAKDOWN_ID) RN,BUSBREAKDOWN_ID, SCHOOLS_SERVICED,How_Long_Delayed FROM Bus_Breakdown_and_Delays_20250331
WHERE LEN(SCHOOLS_SERVICED) > 5;

select a.how_long_delayed, b.how_long_delayed from Bus_Breakdown_and_Delays_20250331 a, Bus_Breakdown_and_Delays_20250331 b
where a.Busbreakdown_ID = b.Busbreakdown_ID

select how_long_delayed as hld from Bus_Breakdown_and_Delays_20250331
WHERE how_long_delayed LIKE '[0-9]'
OR how_long_delayed LIKE '[0-9][0-9]'
OR how_long_delayed LIKE '[0-9][0-9][0-9]';


-- Retrieves all rows which have more than 3 digits. These are the rows that dont conform to the data standards 
select Busbreakdown_ID, How_Long_Delayed,
CASE
 WHEN How_Long_Delayed LIKE '%-%' THEN SUBSTRING(HOW_LONG_DELAYED,CHARINDEX('-',HOW_LONG_DELAYED)+1,LEN(HOW_LONG_DELAYED))
 ELSE How_Long_Delayed
 END AS HLD
from Bus_Breakdown_and_Delays_20250331
WHERE HOW_LONG_DELAYED NOT IN (
select how_long_delayed as hld from Bus_Breakdown_and_Delays_20250331
WHERE how_long_delayed LIKE '[0-9]'
OR how_long_delayed LIKE '[0-9][0-9]'
OR how_long_delayed LIKE '[0-9][0-9][0-9]')
OR How_Long_Delayed LIKE '%-%';