-- Replacing Y to Yes AND N to No

SELECT 
    soldasvacant,
    CASE WHEN 
        soldasvacant = 'Y' THEN 'Yes'
    when 
        soldasvacant = 'N' THEN 'No'
    ELSE
        soldasvacant
    END
FROM
    nashville_housing_data;


UPDATE 
    nashville_housing_data
SET 
    soldasvacant = CASE WHEN 
        soldasvacant = 'Y' THEN 'Yes'
    when 
        soldasvacant = 'N' THEN 'No'
    ELSE
        soldasvacant
    END

-- Remove Duplicates

WITH row_cte as(
SELECT 
    *,
    ROW_NUMBER()
    OVER(
        PARTITION BY 
                parcelid,
                propertyaddress,
                saleprice,
                saledate,
                legalreference
                ORDER BY
                    uniqueid
    ) row_num
FROM 
    nashville_housing_data
)
DELETE FROM 
    nashville_housing_data
WHERE uniqueid IN (
    SELECT uniqueid
    FROM row_cte
    WHERE row_num >1
)

-- Deleting Unused Columns

ALTER TABLE 
    nashville_housing_data
DROP COLUMN
    owneraddress;

ALTER TABLE 
    nashville_housing_data
DROP COLUMN
    propertyaddress;

SELECT 
    *
FROM nashville_housing_data;