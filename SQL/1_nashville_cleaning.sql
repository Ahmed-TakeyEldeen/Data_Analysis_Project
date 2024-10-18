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


-- Breaking out the address into indivdual columns


SELECT 
    propertyaddress,
    SUBSTRING(propertyaddress FROM 1 FOR POSITION(',' IN propertyaddress) - 1) AS address_before_comma,
    SUBSTRING(propertyaddress FROM POSITION(',' IN propertyaddress) + 1) AS address_after_comma
FROM 
    nashville_housing_data;

ALTER TABLE 
    nashville_housing_data
ADD
    porpertysplitaddress VARCHAR(255);

UPDATE 
    nashville_housing_data
SET
    porpertysplitaddress = SUBSTRING(propertyaddress FROM 1 FOR POSITION(',' IN propertyaddress) - 1);


ALTER TABLE
    nashville_housing_data
ADD 
    porpertysplitcity VARCHAR(255);

UPDATE
    nashville_housing_data
SET
    porpertysplitcity = SUBSTRING(propertyaddress FROM POSITION(',' IN propertyaddress) + 1);

SELECT 
    propertyaddress,
    porpertysplitaddress,
    porpertysplitcity
FROM 
    nashville_housing_data;


-- Breaking out the owener address



SELECT 
    owneraddress,
    SPLIT_PART(owneraddress,',',1) AS address_before_comma,
    SPLIT_PART(owneraddress,',',2) address_after_comma,
    SPLIT_PART(owneraddress,',',3) AS address_after_after_comma
FROM 
    nashville_housing_data;

ALTER TABLE 
    nashville_housing_data
ADD 
    ownersplitaddress VARCHAR(255);

ALTER TABLE
    nashville_housing_data
ADD
    ownersplitcity VARCHAR(255);

ALTER TABLE
    nashville_housing_data
ADD
    ownersplitstate VARCHAR(255);

UPDATE 
    nashville_housing_data
SET 
    ownersplitaddress = SPLIT_PART(owneraddress , ',',1);

UPDATE
    nashville_housing_data
SET
    ownersplitcity = SPLIT_PART(owneraddress , ',', 2);

UPDATE 
    nashville_housing_data
SET
    ownersplitstate = SPLIT_PART(owneraddress ,',',3);