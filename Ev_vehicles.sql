Select * from Ev_vehicles_dataset

-- 1. Which vehicle types are most preferred among CAFE-eligible models?
select Ev_Type, Count(*) as Total
from Ev_vehicles_dataset
where CAFV_Eligibility = 'cafv eligible'
group by Ev_Type
order by Total desc;

-- 2. What % of vehicles are CAFE-eligible?
SELECT 
  ROUND(
    (CAST(COUNT(CASE WHEN CAFV_Eligibility = 'CAFV Eligible' THEN 1 END) AS FLOAT) * 100.0) / COUNT(*),
    2
  ) AS Eligible_Percentage
FROM Ev_vehicles_dataset;

-- 3. Which cities have a high adoption of Plug-in Hybrid Electric Vehicles (PHEVs), Battery Electric Vehicles (BEVs)
-- with more than 1000 registered vehicles?
SELECT 
  City,
  SUM(CASE WHEN EV_Type = 'BEV' THEN 1 ELSE 0 END) AS BEV_Count,
  SUM(CASE WHEN EV_Type = 'PHEV' THEN 1 ELSE 0 END) AS PHEV_Count
FROM Ev_vehicles_dataset
GROUP BY City
HAVING 
  SUM(CASE WHEN EV_Type = 'BEV' THEN 1 ELSE 0 END) > 1000
  OR
  SUM(CASE WHEN EV_Type = 'PHEV' THEN 1 ELSE 0 END) > 1000
ORDER BY BEV_Count DESC, PHEV_Count DESC;


-- 4. Which EV type—BEV or PHEV—is more dominant in vehicle models manufactured from 2020 onwards?
SELECT 
  Model_Year,
  SUM(CASE WHEN EV_Type = 'BEV' THEN 1 ELSE 0 END) AS BEV_Count,
  SUM(CASE WHEN EV_Type = 'PHEV' THEN 1 ELSE 0 END) AS PHEV_Count,
  CASE 
    WHEN SUM(CASE WHEN EV_Type = 'BEV' THEN 1 ELSE 0 END) > 
         SUM(CASE WHEN EV_Type = 'PHEV' THEN 1 ELSE 0 END) THEN 'BEV'
    WHEN SUM(CASE WHEN EV_Type = 'PHEV' THEN 1 ELSE 0 END) >
         SUM(CASE WHEN EV_Type = 'BEV' THEN 1 ELSE 0 END) THEN 'PHEV'
    ELSE 'Equal'
  END AS Dominant_Type
FROM Ev_vehicles_dataset
WHERE Model_Year >= 2020
GROUP BY Model_Year
ORDER BY Model_Year;

-- 5. Which postal codes show a switch in vehicle model or brand, and what is the change in range?
SELECT Postal_Code, Model_Year, Make as current_make, Model as current_model, Electric_Range,
LAG(make) over(partition by postal_code order by model_year) as Previous_Make,
Lag(Model) over(partition by postal_code order by model_year) as previous_model,
LAG(Electric_Range) over(partition by postal_code order by model_year) as Previous_range,
(Electric_Range - LAG(Electric_Range) OVER (PARTITION BY Postal_Code ORDER BY Model_Year)) AS Range_Change
from Ev_vehicles_dataset
WHERE Postal_Code IS NOT NULL
ORDER BY Postal_Code, Model_Year;

-- 6. Which city/county/district has highest EV registration? 
SELECT City, COUNT(*) AS Total_Registrations
FROM Ev_vehicles_dataset
GROUP BY City
ORDER BY Total_Registrations DESC;

-- 7. Avg price for CAFE-eligible vs non-eligible?
select CAFV_Eligibility ,avg(Base_MSRP)
from Ev_vehicles_dataset
group by CAFV_Eligibility;

-- 8.  Counties with highest BEV concentration ?
SELECT County, COUNT(*) AS BEV_Count
FROM Ev_vehicles_dataset
WHERE EV_Type = 'BEV'
GROUP BY County
ORDER BY BEV_Count DESC;

-- 9. Which vehicle models consistently fail CAFV eligibility, and what is their average electric range? 
-- Do these non-compliant vehicles offer significantly lower performance in terms of electric range?
SELECT Model, AVG(Electric_Range) AS Avg_Range
FROM Ev_vehicles_dataset
WHERE CAFV_Eligibility = 'Not eligible'
GROUP BY Model
ORDER BY Avg_Range;

-- 10. How has the average electric range of EVs evolved across model years?
-- Is there a trend showing that newer vehicles offer longer electric range?
SELECT Model_Year, AVG(Electric_Range) AS Avg_Range
FROM Ev_vehicles_dataset
GROUP BY Model_Year
order by Model_Year;

-- 11. How is electric range distributed across all electric vehicles, 
-- and what are the most common range segments (e.g., short, medium, long range)?
SELECT 
  CASE 
    WHEN Electric_Range < 100 THEN 'Short Range (<100 km)'
    WHEN Electric_Range BETWEEN 100 AND 200 THEN 'Medium Range (100-200 km)'
    ELSE 'Long Range (>200 km)'
  END AS Range_Category,
  COUNT(*) AS Vehicle_Count
FROM Ev_vehicles_dataset
GROUP BY 
  CASE 
    WHEN Electric_Range < 100 THEN 'Short Range (<100 km)'
    WHEN Electric_Range BETWEEN 100 AND 200 THEN 'Medium Range (100-200 km)'
    ELSE 'Long Range (>200 km)'
  END;

-- 12. What are the least registered electric vehicle models, 
-- and how do their electric range, MSRP, and eligibility status potentially explain their low adoption?
select Make, Model, Electric_Range, Base_MSRP, CAFV_Eligibility, COUNT(*) AS Total_Registrations
from Ev_vehicles_dataset
group by Make, Model, Electric_Range, Base_MSRP, CAFV_Eligibility
HAVING COUNT(*) <= 3
order by Total_Registrations, Electric_Range;

-- 13. Which EV models are most registered (over 1000 times) in top-performing cities or districts?
select City, Model, COUNT(*) as Total
from Ev_vehicles_dataset
group by City, Model
having COUNT(*) > 1000
order by Total desc;

-- 14. Which type of EV gives me more range per charge on average?
SELECT EV_Type, AVG(Electric_Range) AS Avg_Range
FROM Ev_vehicles_dataset
GROUP BY EV_Type;

-- 15. Is there a positive correlation between the price of electric vehicles and their electric range?
SELECT Make, Model,Base_MSRP, Electric_Range
FROM Ev_vehicles_dataset
WHERE Base_MSRP IS NOT NULL AND Electric_Range IS NOT NULL;

-- 16. Which EV manufacturers and their models qualify for Clean Alternative Fuel Vehicle (CAFV) eligibility, 
-- and how can this help prioritize environmentally compliant offerings in the market?
SELECT DISTINCT Make, Model
FROM Ev_vehicles_dataset
WHERE CAFV_Eligibility = 'cafv eligible'
order by make asc;

-- 17. Which EV models and manufacturers offer the highest electric range, particularly those exceeding 100 miles? 
SELECT Make, Model, MAX(Electric_Range) AS Max_Range
FROM Ev_vehicles_dataset
GROUP BY Make, Model
having max(Electric_Range) > 100
ORDER BY Max_Range DESC;

-- 18. How has the trend of EV (Electric Vehicle) registrations evolved over the years, 
-- and which years saw peak or decline in EV adoption?
SELECT Model_Year, COUNT(*) AS Count
FROM Ev_vehicles_dataset
GROUP BY Model_Year
ORDER BY Model_Year;