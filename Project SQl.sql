CREATE DATABASE PROJECTDB1;

USE PROJECTDB1;
CREATE TABLE CONSUMERS(
CONSUMER_ID varchar(10) PRIMARY KEY,
CITY VARCHAR(50),
STATE VARCHAR(50),
COUNTRY VARCHAR(50),
LATITUDE varchar(20),
LONNGITUDE varchar(20),
SMOKER CHAR(10),
DRINK_LEVEL VARCHAR(50),
TRANSPORT VARCHAR(50),
MARITAL_STATUS CHAR(10),
CHILDREN CHAR(20),
AGE INT,
OCCUPATION VARCHAR(50),
BUDGET VARCHAR(20)
);

select * from consumers;

CREATE TABLE CONSUMERSPREFERS(
CONSUMER_ID VARCHAR(10),
PREFERD_CUISINE VARCHAR(20),
FOREIGN KEY(CONSUMER_ID) REFERENCES CONSUMERS(CONSUMER_ID));

DESC CONSUMERSPREFERS;

CREATE TABLE RESTARUNT(
RESTARUNT_ID VARCHAR(20) PRIMARY KEY,
RES_NAME VARCHAR(50),
CITY VARCHAR(50),
STATE CHAR(50),
COUNTRY CHAR(50),
ZIP_CODE VARCHAR(50),
LATITUDE varchar(20),
LONGITUDE varchar(20),
ALCOHOL_SERVICE CHAR(30),
SMOKING_ALLOWED CHAR(30),
PRICE VARCHAR(20),
AREA VARCHAR(20),
FRANCHISE VARCHAR(20),
PARKING CHAR(20)
);
DESC RESTARUNT;

SELECT * FROM RESTARUNT;
SELECT COUNT(CITY) FROM RESTARUNT;
CREATE TABLE RESTARUNT_CUISINE(
RESTARUNT_ID VARCHAR(20) PRIMARY KEY,
CUISINE_TYPE VARCHAR(40),
FOREIGN KEY (RESTARUNT_ID) REFERENCES RESTARUNT(RESTARUNT_ID));

CREATE TABLE RATINGS(
CONSUMER_ID varchar(10),
RESTARUNT_ID VARCHAR(20),
OVERALL_RATINGS INT,
FOOD_RATINGS INT,
SERVICE_RATINGS INT,
PRIMARY KEY(CONSUMER_ID,RESTARUNT_ID),
FOREIGN KEY (CONSUMER_ID) REFERENCES CONSUMERS(CONSUMER_ID),
FOREIGN KEY (RESTARUNT_ID) REFERENCES RESTARUNT(RESTARUNT_ID)
);

DESC RATINGS;
SELECT * FROM RATINGS;
select * from restarunt_cuisine;

-- USING WHERE CLAUSE TO FIND SPECIFIC DATA BASED ON SPECIFIC CRITERIA
-- List all details of consumers who live in the city of 'Cuernavaca'.


SELECT * FROM CONSUMERS 
WHERE CITY = 'Cuernavaca';


DESC CONSUMERS;
-- Find the Consumer_ID, Age, and Occupation of all consumers who are 'Students' AND are 'Smokers'


SELECT CONSUMER_ID,AGE,OCCUPATION FROM CONSUMERS
WHERE SMOKER = 'YES' AND OCCUPATION = 'STUDENT';


DESC RESTARUNT;DESC RESTARUNT;
-- List the Name, City, Alcohol_Service, and Price of all restaurants that serve 'Wine & Beer' and have a 'Medium' price level. 

SELECT RES_NAME,CITY,ALCOHOL_SERVICE,PRICE FROM RESTARUNT
WHERE ALCOHOL_SERVICE ='WINE & BEER' AND PRICE = 'MEDIUM';


ALTER TABLE RESTARUNT
RENAME COLUMN ALC0HOL_SERVICE TO ALCOHOL_SERVICE;

-- Find the names and cities of all restaurants that are part of a 'Franchise'.

SELECT RES_NAME,CITY FROM RESTARUNT
WHERE FRANCHISE='OPEN';

-- Show the Consumer_ID, Restaurant_ID, and Overall_Rating for all ratings where the Overall_Rating was 'Highly Satisfactory' (which corresponds to a value of 2, according to the data dictionary)


SELECT DISTINCT CONSUMER_ID,RESTARUNT_ID,OVERALL_RATINGS
FROM RATINGS
WHERE OVERALL_RATINGS = 2;

-- Questions JOINs with Subqueries
-- List the names and cities of all restaurants that have an Overall_Rating of 2 (Highly Satisfactory) from at least one consumer


SELECT DISTINCT R.RES_NAME,R.CITY,O.OVERALL_RATINGS
FROM RESTARUNT R 
LEFT JOIN RATINGS O ON R.RESTARUNT_ID = O.RESTARUNT_ID
WHERE O.OVERALL_RATINGS >= 2;

-- Find the Consumer_ID and Age of consumers who have rated restaurants located in 'San Luis Potosi'. 

SELECT DISTINCT C.CONSUMER_ID,C.AGE 
FROM CONSUMERS C 
LEFT JOIN RATINGS R ON C.CONSUMER_ID = R.CONSUMER_ID
WHERE C.CITY = 'San Luis Potosi';

-- List the names of restaurants that serve 'Mexican' cuisine and have been rated by consumer 'U1001'.

SELECT R.RES_NAME FROM RESTARUNT R 
LEFT JOIN RATINGS O ON R.RESTARUNT_ID = O.RESTARUNT_ID
JOIN RESTARUNT_CUISINE C ON C.RESTARUNT_ID = R.RESTARUNT_ID
WHERE CUISINE_TYPE = 'MEXICAN' AND CONSUMER_ID = 'U1001';

-- All details of consumers who prefer American cuisine AND have a Medium budget


SELECT DISTINCT C.*
FROM CONSUMERS C
JOIN CONSUMERSPREFERS P
  ON C.CONSUMER_ID = P.CONSUMER_ID
WHERE P.PREFERD_CUISINE = 'AMERICAN'
  AND C.BUDGET = 'MEDIUM';

-- Restaurants with Food_Rating lower than the global average Food_Rating

SELECT DISTINCT R.RES_NAME, R.CITY
FROM RESTARUNT R
JOIN RATINGS T
  ON R.RESTARUNT_ID = T.RESTARUNT_ID
WHERE T.FOOD_RATINGS < (
    SELECT AVG(FOOD_RATINGS)
    FROM RATINGS);

-- Consumers who rated at least one restaurant but NONE that serves Italian

SELECT distinct c.CONSUMER_ID, C.AGE, C.OCCUPATION
FROM CONSUMERS C
WHERE EXISTS (
    SELECT 1
    FROM RATINGS T
    WHERE T.CONSUMER_ID = C.CONSUMER_ID
)
AND NOT EXISTS (
    SELECT 1
    FROM RATINGS T2
    JOIN RESTARUNT_CUISINE R
      ON T2.RESTARUNT_ID = R.RESTARUNT_ID
    WHERE T2.CONSUMER_ID = C.CONSUMER_ID
      AND R.CUISINE_TYPE = 'ITALIAN'
);
-- Restaurants that have received ratings from consumers older than 30

SELECT DISTINCT R.RES_NAME
FROM RESTARUNT R
JOIN RATINGS T
  ON R.RESTARUNT_ID = T.RESTARUNT_ID
JOIN CONSUMERS C
  ON C.CONSUMER_ID = T.CONSUMER_ID
WHERE C.AGE > 30;

-- Consumers with preferred Mexican cuisine who gave Overall_Rating = 0 at least once

SELECT DISTINCT C.CONSUMER_ID, C.OCCUPATION
FROM CONSUMERS C
JOIN  CONSUMERSPREFERS P
  ON C.CONSUMER_ID = P.CONSUMER_ID
JOIN RATINGS T
  ON C.CONSUMER_ID = T.CONSUMER_ID
WHERE P.PREFERD_CUISINE = 'MEXICAN'
  AND T.OVERALL_RATINGS = 0;

-- Restaurants serving Pizzeria cuisine in a city where at least one Student lives

SELECT DISTINCT R.RES_NAME, R.CITY
FROM RESTARUNT R
JOIN RESTARUNT_CUISINE RC
  ON R.RESTARUNT_ID = RC.RESTARUNT_ID
WHERE RC.CUISINE_TYPE = 'PIZZERIA'
  AND EXISTS (
    SELECT 1
    FROM CONSUMERS C
    WHERE C.CITY = R.CITY
      AND C.OCCUPATION = 'STUDENT'
  );
  
  -- Social Drinkers who rated a restaurant with No parking
  
  SELECT C.CONSUMER_ID, C.AGE
FROM CONSUMERS C
JOIN RATINGS T
  ON C.CONSUMER_ID = T.CONSUMER_ID
JOIN RESTARUNT R
  ON R.RESTARUNT_ID = T.RESTARUNT_ID
WHERE C.DRINK_LEVEL = 'SOCIAL DRINKER'
  AND R.PARKING = 'NONE';
  
  
  SELECT * FROM RATINGS;
  -- Questions Emphasizing WHERE Clause and Order of Execution
-- List Consumer_IDs and the count of restaurants they've rated, but only for consumers who are 'Students'. Show only students who have rated more than 2 restaurants.
 
 
 SELECT c.Consumer_ID,COUNT(r.RESTARUNT_ID) AS rated_count
FROM consumers c
JOIN ratings r
    ON c.Consumer_ID = r.Consumer_ID
WHERE c.Occupation = 'Student'
GROUP BY c.Consumer_ID
HAVING COUNT(r.RESTARUNT_ID) > 2;

-- We want to categorize consumers by an 'Engagement_Score' which is their Age divided by 10 (integer division).
-- List the Consumer_ID, Age, and this calculated Engagement_Score, but only for consumers whose Engagement_Score would be exactly 2 and who use 'Public' transportation.

SELECT Consumer_ID,Age,(Age / 10) AS Engagement_Score
FROM consumers
WHERE (Age / 10) = 2 AND Transport = 'Public';

-- For each restaurant, calculate its average Overall_Rating. Then, list the restaurant Name, City, and its calculated average Overall_Rating, but only for restaurants located in 'Cuernavaca' AND whose calculated average Overall_Rating is greater than 1.0

SELECT r.res_Name,r.City,AVG(rt.OVERALL_RATINGS) AS Avg_Overall_Rating
FROM restarunt r
JOIN ratings rt
ON r.RESTARUNT_ID = rt.RESTARUNT_ID
WHERE r.City = 'Cuernavaca'
GROUP BY r.RESTARUNT_ID, r.res_Name, r.City
HAVING AVG(rt.OVERALL_RATINGS) > 1.0;

-- Find consumers (Consumer_ID, Age) who are 'Married' and whose Food_Rating for any restaurant is equal to their Service_Rating for that same restaurant, but only consider ratings where the Overall_Rating was 2.

SELECT DISTINCT
    c.Consumer_ID,
    c.Age
FROM consumers c
JOIN ratings r
    ON c.Consumer_ID = r.Consumer_ID
WHERE c.MARITAL_STATUS = 'Married'
  AND r.OVERALL_RATINGS = 2
  AND r.Food_Ratings = r.Service_Ratings;
  
-- List Consumer_ID, Age, and the Name of any restaurant they rated, but only for consumers who are 'Employed' and have given a Food_Rating of 0 to at least one restaurant located in 'Ciudad Victoria'. 

SELECT DISTINCT c.Consumer_ID,c.Age,rs.res_Name AS restarunt_Name
FROM consumers c
JOIN ratings r
    ON c.Consumer_ID = r.Consumer_ID
JOIN restarunt rs
    ON r.RESTARUNT_ID = rs.RESTARUNT_ID
WHERE c.Occupation = 'Employed'
  AND r.Food_Ratings = 0
  AND rs.City = 'Ciudad Victoria';
  
  
 -- Advanced SQL Concepts: Derived Tables, CTEs, Window Functions, Views, Stored Procedures  
-- For each Occupation, find the average age of consumers. Only consider consumers who have made at least one rating. (Use a derived table to get consumers who have rated). 

SELECT c.Occupation,AVG(c.Age) AS Avg_Age
FROM consumers c
JOIN (
    SELECT DISTINCT Consumer_ID FROM ratings
) r
    ON c.Consumer_ID = r.Consumer_ID
GROUP BY c.Occupation;

-- For each rating, show the Consumer_ID, Restaurant_ID, Overall_Rating, and also display the average Overall_Rating given by that specific consumer across all their ratings. 
SELECT Consumer_ID,RESTARUNT_ID,OVERALL_RATINGS,
AVG(Overall_Ratings) OVER (PARTITION BY Consumer_ID) 
AS Consumer_Avg_Rating
FROM ratings;
-- Consider all ratings made by 'Consumer_ID' = 'U1008'. For each rating, show the Restaurant_ID, Overall_Rating, and the Overall_Rating of the next restaurant they rated (if any), ordered by Restaurant_ID (as a proxy for time if rating time isn't available). Use a derived table to filter for the consumer's ratings first.


SELECT RESTARUNT_ID,Overall_Ratings,
    LEAD(Overall_Ratings) OVER (ORDER BY RESTARUNT_ID) AS Next_Overall_Rating
FROM (
    SELECT *
    FROM ratings
    WHERE Consumer_ID = 'U1008'
) t;

-- Create a VIEW named HighlyRatedMexicanRestaurants that shows the Restaurant_ID, Name, and City of all Mexican restaurants that have an average Overall_Rating greater than 1.5. 

CREATE VIEW HighlyRatedMexicanRestaurants AS
SELECT rs.RESTARUNT_ID,rs.res_Name,rs.City
FROM restarunt rs
JOIN restarunt_cuisine rc
    ON rs.RESTARUNT_ID = rc.RESTARUNT_ID
JOIN ratings r
    ON rs.RESTARUNT_ID = r.RESTARUNT_ID
WHERE rc.Cuisine_type = 'Mexican'
GROUP BY rs.RESTARUNT_ID, rs.res_Name, rs.City
HAVING AVG(r.Overall_Ratings) > 1.5;

select * from HighlyRatedMexicanRestaurants;


-- First, ensure the HighlyRatedMexicanRestaurants view from Q7 exists. Then, using a CTE to find consumers who prefer 'Mexican' cuisine, list those consumers (Consumer_ID) who have not rated any restaurant listed in the HighlyRatedMexicanRestaurants view.
WITH mexican_lovers AS (
    SELECT DISTINCT Consumer_ID
    FROM consumersprefers
    WHERE PREFERD_CUISINE = 'Mexican'
)
SELECT ml.Consumer_ID
FROM mexican_lovers ml
WHERE NOT EXISTS (
    SELECT 1
    FROM ratings r
    JOIN HighlyRatedMexicanRestaurants h
        ON r.RESTARUNT_ID = h.RESTARUNT_ID
    WHERE r.Consumer_ID = ml.Consumer_ID
);

-- First, create a VIEW named ConsumerAverageRatings that lists Consumer_ID and their average Overall_Rating.


CREATE VIEW ConsumerAverageRatings AS
SELECT
    Consumer_ID,
    AVG(Overall_Ratings) AS Avg_Rating
FROM ratings
GROUP BY Consumer_ID;

select * from ConsumerAverageRatings;



select * from restarunt_cuisine;







