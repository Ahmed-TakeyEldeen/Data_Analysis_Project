CREATE TABLE nashville_housing_data
(
    UniqueID NUMERIC PRIMARY KEY,
    ParcelID VARCHAR(255),
    LandUse TEXT,
    PropertyAddress TEXT,
    SaleDate DATE,
    SalePrice VARCHAR(255),
    LegalReference VARCHAR(255),
    SoldAsVacant BOOLEAN,
    OwnerName TEXT,
    OwnerAddress TEXT,
    Acreage NUMERIC,
    TaxDistrict TEXT,
    LandValue NUMERIC,
    BuildingValue VARCHAR(255),
    TotalValue NUMERIC,
    YearBuilt NUMERIC,
    Bedrooms NUMERIC,
    FullBath NUMERIC,
    HalfBath NUMERIC
);



COPY nashville_housing_data
FROM 'D:\P\CSV_Excel\Nashville Housing Data for Data Cleaning.csv'
DELIMITER ',' CSV HEADER;

SELECT *
FROM nashville_housing_data 
LIMIT 10;