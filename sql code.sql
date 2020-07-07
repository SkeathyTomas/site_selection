-- build a table of features with id,lat,lng

-- join Starbucks with different feartures,need to change the second fearture
SELECT * From Starbucks,Mrt

--caculate distance in R
--check R script in R Studio

--caculate num of features of Starbucks
SELECT StarbucksId,
       count(CASE WHEN distance <= 0.1 THEN 1 ELSE NULL END) AS NumOfMrt100,
       count(CASE WHEN distance <= 0.2 THEN 1 ELSE NULL END) AS NumOfMrt200,
       count(CASE WHEN distance <= 0.3 THEN 1 ELSE NULL END) AS NumOfMrt300,
       count(CASE WHEN distance <= 0.4 THEN 1 ELSE NULL END) AS NumOfMrt400,
       count(CASE WHEN distance <= 0.5 THEN 1 ELSE NULL END) AS NumOfMrt500
  FROM DistanceFromMrt
 GROUP BY StarbucksId

--selct the nearest distance of fearture
SELECT StarbucksId,
       MrtId,
       min(distance) AS MinMrtDis
  FROM DistanceFromMrt
 GROUP BY StarbucksId
