-- question #3
-- answer: 104,838; 199,013; 109,645; 27,688; 35,202
SELECT
    CASE
        WHEN trip_distance <= 1 THEN  'up_to_1_mile'
        WHEN trip_distance <= 3 THEN  '1_to_3_miles'
        WHEN trip_distance <= 7 THEN  '3_to_7_miles'
        WHEN trip_distance <= 10 THEN  '7_to_10_miles'
        ELSE 'over_10_miles'
    END as trip_distance_category,
    COUNT(1)
FROM trips
GROUP BY 1
ORDER BY 1
;

-- question #4
-- answer: 2019-10-31
WITH trips_with_duration AS (
    SELECT
        lpep_pickup_datetime::date AS lpep_pickup_date,
        CASE
        	WHEN lpep_dropoff_datetime::date > lpep_pickup_datetime::date
        		THEN (lpep_pickup_datetime::date::timestamp + interval '1' day
        				- lpep_pickup_datetime)
        	ELSE (lpep_dropoff_datetime - lpep_pickup_datetime)
        END  AS trip_duration
    FROM trips
),
longest_trips AS (
    SELECT
        lpep_pickup_date,
        MAX(trip_duration) AS trip_duration
    FROM trips_with_duration
    GROUP BY 1
)
SELECT
	lpep_pickup_date
FROM longest_trips
WHERE trip_duration IN (
        SELECT MAX(trip_duration) FROM longest_trips)
;


-- question #5
-- answer: East Harlem North, East Harlem South, Morningside Heights
WITH zones_with_amount AS (
    SELECT
        z."Zone" AS zone_name,
        SUM(total_amount) AS total_amount
    FROM trips as t
    INNER JOIN zones AS z
        ON t."PULocationID" = z."LocationID"
    WHERE 1=1
        AND t.lpep_pickup_datetime::date = '2019-10-18'
    GROUP BY 1
)
SELECT zone_name
FROM zones_with_amount
WHERE total_amount > 13000
ORDER BY zone_name
;


-- question #6
-- answer: East Harlem North
WITH do_zones_with_tip_amount AS (
    SELECT
        doz."Zone" AS do_zone_name,
        t.tip_amount as tip_amount
    FROM trips as t
    INNER JOIN zones AS puz
        ON t."PULocationID" = puz."LocationID"
        AND puz."Zone" = 'East Harlem North'
    INNER JOIN zones AS doz
        ON t."PULocationID" = doz."LocationID"
)
SELECT
    do_zone_name
FROM do_zones_with_tip_amount
WHERE tip_amount = (
    SELECT MAX(tip_amount)
    FROM do_zones_with_tip_amount)
;

