SELECT *
FROM nashville_housing_data;



-- Populate null Values in propertyaddress

SELECT 
    nash_1.parcelid,
    nash_1.propertyaddress,
    nash_2.parcelid,
    nash_2.propertyaddress,
    COALESCE(nash_1.propertyaddress,nash_2.propertyaddress)
FROM 
    nashville_housing_data nash_1
JOIN
    nashville_housing_data nash_2
on
    nash_1.parcelid = nash_2.parcelid
AND
    nash_1.uniqueid <> nash_2.uniqueid
WHERE
    nash_1.propertyaddress is NULL


UPDATE 
    nashville_housing_data
SET 
    propertyaddress = COALESCE(nash_1.propertyaddress,nash_2.propertyaddress)
FROM 
    nashville_housing_data nash_1
JOIN
    nashville_housing_data nash_2
on
    nash_1.parcelid = nash_2.parcelid
AND
    nash_1.uniqueid <> nash_2.uniqueid
WHERE
    nash_1.propertyaddress is NULL

SELECT
    propertyaddress
FROM 
    nashville_housing_data
where 
    propertyaddress IS NULL;