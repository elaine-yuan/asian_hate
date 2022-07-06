----------------------------------------------------- 1st dataset: hate_crimes from FBI, a national view

--WHAT ARE THE MOST COMMON HATE CRIMES?
SELECT BIAS_DESC, COUNT(INCIDENT_ID), ROUND(COUNT(INCIDENT_ID) * 1.0/(SELECT COUNT(INCIDENT_ID) 
																		FROM hate_crime_csv hc),2) AS Pct_of_Total
FROM hate_crime_csv hc
GROUP BY 1
ORDER BY 2 DESC
--unfortunately and unsurprisingly, anti-black hate crimes are the greatest

--what is anti-white crime though?
--SELECT STATE_NAME, OFFENSE_NAME, COUNT(INCIDENT_ID)
--FROM hate_crime_csv hc
--WHERE BIAS_DESC ='Anti-White'
--GROUP BY 1,2
--ORDER BY 3 DESC
--
--SELECT OFFENSE_NAME, OFFENDER_RACE, COUNT(INCIDENT_ID)
--FROM hate_crime_csv hc
--WHERE BIAS_DESC ='Anti-White'
--GROUP BY 1,2
--ORDER BY 3 DESC

--WHAT ARE THE MOST COMMON HATE CRIMES IN 2020?
SELECT BIAS_DESC, COUNT(INCIDENT_ID), ROUND(COUNT(INCIDENT_ID) * 1.0/(SELECT COUNT(INCIDENT_ID) 
																		FROM hate_crime_csv hc 
																		WHERE DATA_YEAR = 2020 ),2) AS Pct_of_Total
FROM hate_crime_csv hc
WHERE DATA_YEAR = 2020
GROUP BY 1
ORDER BY 2 DESC
--similar ranking as first table

--WHAT ARE THE MOST COMMON HATE CRIMES IN 2020 IN NYC?
SELECT BIAS_DESC, COUNT(INCIDENT_ID) as INCIDENTS, ROUND(COUNT(INCIDENT_ID) * 1.0/(SELECT COUNT(INCIDENT_ID) 
																					FROM hate_crime_csv hc 
																					WHERE DATA_YEAR = 2020 
																					AND PUB_AGENCY_NAME = 'New York'),2) AS Pct_of_Total
FROM hate_crime_csv hc
WHERE DATA_YEAR = 2020 
AND PUB_AGENCY_NAME = 'New York'
GROUP BY 1
ORDER BY 2 DESC
--almost 1/2 hate crimes are anti-jewish
--anti-asian hate crimes #3

--WHICH STATE HAS THE GREATEST NUMBER OF HATE CRIMES?
SELECT STATE_NAME , COUNT(INCIDENT_ID)
FROM hate_crime_csv hc
GROUP BY 1
ORDER BY 2 DESC
--NY is the 3rd most hateful state

--WHICH STATE HAS THE GREATEST NUMBER OF ANTI-ASIAN HATE CRIMES?
SELECT STATE_NAME , COUNT(INCIDENT_ID)
FROM hate_crime_csv hc
WHERE BIAS_DESC = 'Anti-Asian'
GROUP BY 1
ORDER BY 2 DESC
--NY is 8th

--WHICH STATE HAS THE GREATEST NUMBER OF ANTI-ASIAN HATE CRIMES IN 2020?
SELECT STATE_NAME , COUNT(INCIDENT_ID)
FROM hate_crime_csv hc
WHERE BIAS_DESC = 'Anti-Asian' AND DATA_YEAR = 2020
GROUP BY 1
ORDER BY 2 DESC
--NY is #3 after CA and NJ

--WHAT YEAR HAS THE GREATEST NUMBER OF ANTI-ASIAN HATE CRIMES?
SELECT DATA_YEAR, COUNT(INCIDENT_ID)
FROM hate_crime_csv hc
WHERE BIAS_DESC = 'Anti-Asian'
GROUP BY 1
ORDER BY 2 DESC
-- more asian hate crimes in 1995-1997 than in 2020 - why is that?
-- where are these happening?
SELECT DATA_YEAR, STATE_NAME, COUNT(INCIDENT_ID)
FROM hate_crime_csv hc
WHERE BIAS_DESC = 'Anti-Asian' AND DATA_YEAR BETWEEN 1995 AND 1997
GROUP BY 1, 2 
ORDER BY 3 DESC
-- most of them are in CA!
-- increase of Asian immigrants in CA
-- asians seen as interlopers and targets for harassment
-- xenophobia increased with the passing of anti-immigrant proposition 187, which prohibits undocumented immigrants from using social services

--WHERE ARE ANTI-ASIAN HATE CRIMES MOST LIKELY TO OCCUR?
SELECT LOCATION_NAME, COUNT(INCIDENT_ID)
FROM hate_crime_csv hc
WHERE BIAS_DESC = 'Anti-Asian'
GROUP BY 1
ORDER BY 2 DESC
--everywhere, even at home

--WHERE ARE ANTI-ASIAN HATE CRIMES MOST LIKELY TO OCCUR IN 2020?
SELECT LOCATION_NAME, COUNT(INCIDENT_ID)
FROM hate_crime_csv hc
WHERE BIAS_DESC = 'Anti-Asian' AND DATA_YEAR = 2020
GROUP BY 1
ORDER BY 2 DESC
--everywhere, almost as likely to happen at home as on the street

--WHERE ARE ANTI-ASIAN HATE CRIMES MOST LIKELY TO OCCUR IN NYC?
SELECT LOCATION_NAME, COUNT(INCIDENT_ID)
FROM hate_crime_csv hc
WHERE BIAS_DESC = 'Anti-Asian' AND PUB_AGENCY_NAME ='New York'
GROUP BY 1
ORDER BY 2 DESC
--other/unknown? not helpful...

--WHAT WERE THE ANTI-ASIAN HATE CRIMES?
SELECT OFFENSE_NAME, COUNT(INCIDENT_ID), ROUND(COUNT(INCIDENT_ID) * 1.0/(SELECT COUNT(INCIDENT_ID) 
																			FROM hate_crime_csv hc 
																			WHERE BIAS_DESC = 'Anti-Asian'),2) Pct_of_Total
FROM hate_crime_csv hc
WHERE BIAS_DESC = 'Anti-Asian' 
GROUP BY 1
ORDER BY 2 DESC
--almost a third of incidents are intimidation - which is undoubtedly scary, but not physically harmful 

--WHAT WERE THE ANTI-ASIAN HATE CRIMES IN 2020?
SELECT OFFENSE_NAME, COUNT(INCIDENT_ID), ROUND(COUNT(INCIDENT_ID) * 1.0/(SELECT COUNT(INCIDENT_ID) 
																			FROM hate_crime_csv hc WHERE BIAS_DESC = 'Anti-Asian' 
																			AND DATA_YEAR = 2020),2) AS Pct_of_Total
FROM hate_crime_csv hc
WHERE BIAS_DESC = 'Anti-Asian' AND DATA_YEAR = 2020
GROUP BY 1
ORDER BY 2 DESC
--more than a third of incidents are intimidation 
--almost a third of incidents are simple assault

----------------------------------------------------- 2nd dataset: NYPD_Hate_Crimes - closer look at NYC
 
--WHAT KIND OF HATE CRIMES ARE THERE IN NYC?
SELECT "Offense Category", COUNT(DISTINCT("Full Complaint ID")) AS Incidents, ROUND(COUNT(DISTINCT("Full Complaint ID")) * 1.0/(SELECT COUNT(DISTINCT("Full Complaint ID"))
																																FROM NYPD_Hate_Crimes_csv ny),2) AS Pct_of_Total
FROM NYPD_Hate_Crimes_csv ny
GROUP BY 1
ORDER BY 2 DESC
--religion-based hate crimes are almost twice as frequent as race-based hate crimes 
--if we remember from earlier, the majority of hate crimes are anti-jewish

--WHAT MADE UP THOSE RACE-BASED HATE CRIMES?
SELECT "Bias Motive Description" AS Bias, COUNT(DISTINCT("Full Complaint ID")) AS Incidents, ROUND(COUNT(DISTINCT("Full Complaint ID")) * 1.0/(SELECT COUNT(DISTINCT("Full Complaint ID"))
																																			FROM NYPD_Hate_Crimes_csv ny
																																			WHERE "Offense Category" = 'Race/Color'),2) AS Pct_of_Total
FROM NYPD_Hate_Crimes_csv ny
WHERE "Offense Category" = 'Race/Color'
GROUP BY 1
ORDER BY 2 DESC
--almost 50% of race-based hate crimes in ny were anti-asian in 2019-2022

--HOW DID COUNT OF ANTI-ASIAN HATE CRIMES CHANGE BETWEEN EACH YEAR (2019-2021)? 
WITH cte AS(
SELECT "Complaint Year Number" AS Year, COUNT(DISTINCT("Full Complaint ID")) AS complaint_count, 
LAG(COUNT(DISTINCT("Full Complaint ID")), 1, 0) OVER() AS prev_count
FROM NYPD_Hate_Crimes_csv ny
WHERE "Bias Motive Description" = 'ANTI-ASIAN'
GROUP BY 1
)
SELECT *, complaint_count-prev_count AS diff, ((complaint_count-prev_count)/prev_count)*100 AS pct_from_prev
FROM cte
--2700% increase in asian hate crimes from 2019 to 2020
--300% increase from 2020 to 2021

--HOW DID COUNT OF ANTI-ASIAN HATE CRIMES CHANGE FROM 2019 TO 2021? 
WITH cte AS(
SELECT "Complaint Year Number" AS Year, COUNT(DISTINCT("Full Complaint ID")) AS complaint_count, 
LAG(COUNT(DISTINCT("Full Complaint ID")), 1, 0) OVER() AS prev_count
FROM NYPD_Hate_Crimes_csv ny
WHERE "Bias Motive Description" = 'ANTI-ASIAN' AND "Complaint Year Number" IN (2019, 2021)
GROUP BY 1
)
SELECT *, complaint_count-prev_count as diff, ((complaint_count-prev_count)/prev_count)*100 AS pct_from_prev
FROM cte
--13000% increase in asian hate crimes from 2019 to 2021 - in 2 years!

--DID OTHER HATE CRIMES UNDERGO A SIMILAR INCREASE? -- is there a way to partition this by bias motive description?
WITH cte AS(
SELECT "Bias Motive Description" AS Bias, "Complaint Year Number" AS Year, COUNT(DISTINCT("Full Complaint ID")) AS complaint_count, 
LAG(COUNT(DISTINCT("Full Complaint ID")), 1, 0) OVER() AS prev_count
FROM NYPD_Hate_Crimes_csv ny
WHERE "Complaint Year Number" IN (2019, 2021)
GROUP BY 1, 2
), 
cte2 AS 
(
SELECT *, complaint_count-prev_count as diff, ((complaint_count-prev_count)/prev_count)*100 AS pct_from_prev
FROM cte
GROUP BY 1, 2
)
SELECT Bias, Year, complaint_count, prev_count, diff, SUM(pct_from_prev) AS pct_increase
FROM cte2
GROUP BY 1

--WHAT KIND OF HATE CRIMES WERE THEY?
SELECT "Offense Description", COUNT(DISTINCT("Full Complaint ID")) AS Incidents, ROUND(COUNT(DISTINCT("Full Complaint ID")) * 1.0/(SELECT COUNT(DISTINCT("Full Complaint ID")) 
																																FROM NYPD_Hate_Crimes_csv ny
																																WHERE "Bias Motive Description" = 'ANTI-ASIAN'),2) AS Pct_of_Total
FROM NYPD_Hate_Crimes_csv ny
WHERE "Bias Motive Description" = 'ANTI-ASIAN'
GROUP BY 1
ORDER BY 2 DESC
-- a third of hate crimes are 3rd degree assaults, or intentional physical injury
-- a little more than a fifth of them are harassment
-- a fifth of them are felony assaults, or serious physical injuries

--WHAT MONTH HAS THE MOST HATE CRIMES?
SELECT "Month Number", COUNT(DISTINCT("Full Complaint ID")) AS Incidents
FROM NYPD_Hate_Crimes_csv ny
GROUP BY 1
ORDER BY 2 DESC
--May and March have the most hate crimes. 
--does season matter? january and february have the least because people stay home to stay warm in the winter? 

--WHAT SEASON HAS THE MOST HATE CRIMES?
SELECT 
CASE 
	WHEN "Month Number"=3 OR "Month Number"=4 OR "Month Number"=5 THEN 'Spring'
	WHEN "Month Number"=6 OR "Month Number"=7 OR "Month Number"=8 THEN 'Summer'
	WHEN "Month Number"=9 OR "Month Number"=10 OR "Month Number"=11 THEN 'Fall'
	ELSE 'Winter'
END AS Season, COUNT(DISTINCT("Full Complaint ID")) AS Incidents, ROUND(COUNT(DISTINCT("Full Complaint ID")) * 1.0/(SELECT COUNT(DISTINCT("Full Complaint ID")) 
																													FROM NYPD_Hate_Crimes_csv ny),2) AS Pct_of_Total
FROM NYPD_Hate_Crimes_csv ny
GROUP BY 1
ORDER BY 2 DESC
--there are the greatest number of hate crimes in the spring. 

--IS IT THE SAME ACROSS ALL HATE CRIMES?
SELECT "Bias Motive Description", 
CASE 
	WHEN "Month Number"=3 OR "Month Number"=4 OR "Month Number"=5 THEN 'Spring'
	WHEN "Month Number"=6 OR "Month Number"=7 OR "Month Number"=8 THEN 'Summer'
	WHEN "Month Number"=9 OR "Month Number"=10 OR "Month Number"=11 THEN 'Fall'
	ELSE 'Winter'
END AS Season, COUNT(DISTINCT("Full Complaint ID")) AS Incidents
FROM NYPD_Hate_Crimes_csv ny
GROUP BY 1, 2
ORDER BY 1, 3 DESC
--not necessarily...

--WHAT MONTH HAD THE MOST ANTI-ASIAN HATE CRIMES?
SELECT "Month Number", COUNT(DISTINCT("Full Complaint ID")) AS Incidents, ROUND(COUNT(DISTINCT("Full Complaint ID")) * 1.0/(SELECT COUNT(DISTINCT("Full Complaint ID")) 
																															FROM NYPD_Hate_Crimes_csv ny
																															WHERE "Bias Motive Description" = 'ANTI-ASIAN'),2) AS Pct_of_Total
FROM NYPD_Hate_Crimes_csv ny
WHERE "Bias Motive Description" = 'ANTI-ASIAN'
GROUP BY 1
ORDER BY 2 DESC
--March has the most number of anti-asian hate crimes - almost a third of them happen in March. 
--could it be due to the anniversary of the nyc shutdown (March 15, 2019)?

SELECT "Month Number" ||'/'|| "Complaint Year Number" as Month, COUNT(DISTINCT("Full Complaint ID")) AS Incidents
FROM NYPD_Hate_Crimes_csv ny
WHERE "Bias Motive Description" = 'ANTI-ASIAN'
GROUP BY 1
ORDER BY 2 DESC
-- most anti-asian hate crimes occur in spring and summer months? let's confirm.

--WHAT SEASON HAS THE MOST ANTI-ASIAN HATE CRIMES?
SELECT 
CASE 
	WHEN "Month Number"=3 OR "Month Number"=4 OR "Month Number"=5 THEN 'Spring'
	WHEN "Month Number"=6 OR "Month Number"=7 OR "Month Number"=8 THEN 'Summer'
	WHEN "Month Number"=9 OR "Month Number"=10 OR "Month Number"=11 THEN 'Fall'
	ELSE 'Winter'
END AS Season, COUNT(DISTINCT("Full Complaint ID")) AS Incidents, ROUND(COUNT(DISTINCT("Full Complaint ID")) * 1.0/(SELECT COUNT(DISTINCT("Full Complaint ID")) 
																													FROM NYPD_Hate_Crimes_csv ny
																													WHERE "Bias Motive Description" = 'ANTI-ASIAN'),2) AS Pct_of_Total
FROM NYPD_Hate_Crimes_csv ny
WHERE "Bias Motive Description" = 'ANTI-ASIAN'
GROUP BY 1
ORDER BY 2 DESC
-- 59%! of them are in the spring time
-- is this the case every year?

SELECT "Complaint Year Number" AS Year,
CASE 
	WHEN "Month Number"=3 OR "Month Number"=4 OR "Month Number"=5 THEN 'Spring'
	WHEN "Month Number"=6 OR "Month Number"=7 OR "Month Number"=8 THEN 'Summer'
	WHEN "Month Number"=9 OR "Month Number"=10 OR "Month Number"=11 THEN 'Fall'
	ELSE 'Winter'
END AS Season, COUNT(DISTINCT("Full Complaint ID")) AS Incidents, ROUND(COUNT(DISTINCT("Full Complaint ID")) * 1.0/(SELECT COUNT(DISTINCT("Full Complaint ID"))
																													FROM NYPD_Hate_Crimes_csv ny
																													WHERE "Bias Motive Description" = 'ANTI-ASIAN'),2) AS Pct_of_Total
FROM NYPD_Hate_Crimes_csv ny
WHERE "Bias Motive Description" = 'ANTI-ASIAN'
GROUP BY 1, 2
ORDER BY 3 DESC
--almost half of anti-asian hate crimes happened in spring 2021

--WHAT BOROUGH ARE HATE CRIMES HAPPENING IN?
SELECT County, COUNT(DISTINCT("Full Complaint ID")) AS Incidents, ROUND(COUNT(DISTINCT("Full Complaint ID")) * 1.0/(SELECT COUNT(DISTINCT("Full Complaint ID")) 
																													FROM NYPD_Hate_Crimes_csv ny),2) AS Pct_of_Total
FROM NYPD_Hate_Crimes_csv ny
GROUP BY 1
ORDER BY 2 DESC
-- a little more than a third of hate crimes are in Manhattan
-- another third are in Brooklyn
-- Staten Island is safest

--WHAT BOROUGH ARE ANTI-ASIAN HATE CRIMES HAPPENING IN?
SELECT County, COUNT(DISTINCT("Full Complaint ID")) AS Incidents, ROUND(COUNT(DISTINCT("Full Complaint ID")) * 1.0/(SELECT COUNT(DISTINCT("Full Complaint ID"))
																													FROM NYPD_Hate_Crimes_csv ny
																													WHERE "Bias Motive Description" = 'ANTI-ASIAN'),2) AS Pct_of_Total
FROM NYPD_Hate_Crimes_csv ny
WHERE "Bias Motive Description" = 'ANTI-ASIAN'
GROUP BY 1
ORDER BY 2 DESC
-- more than half of the anti-asian hate crimes occured in the borough of Manhattan
-- as an asian woman, i would be safer in other boroughs, but what is the population of asians in each borough? 
-- if there are few asians in the BX or SI, it makes sense that they have the fewest asian hate crimes

WITH cte AS (
SELECT County, COUNT(DISTINCT("Full Complaint ID")) as Incidents, ROUND(COUNT(DISTINCT("Full Complaint ID")) * 1.0/(SELECT COUNT(DISTINCT("Full Complaint ID"))
																													FROM NYPD_Hate_Crimes_csv ny
																													WHERE "Bias Motive Description" = 'ANTI-ASIAN'),2) as Pct_of_Inc_Total
FROM NYPD_Hate_Crimes_csv ny
WHERE "Bias Motive Description" = 'ANTI-ASIAN'
GROUP BY 1
ORDER BY 2 DESC
)
SELECT cte.County, Incidents, Pct_of_Inc_Total, Population, ROUND(SUM(Population) * 1.0/(SELECT SUM(Population)  
																						FROM nyc_asian_population_csv ap 
																						WHERE Race = 'Asian' AND County != 'None'),2) as Pct_of_Pop_Total,
		(incidents*100000)/Population as ratio_per_hundredthousand
FROM cte JOIN nyc_asian_population_csv ap ON cte.County=ap.County
WHERE ap.Race = 'Asian'
GROUP BY 1
ORDER BY 6 DESC
-- based on ratio per hundred thousand, the safest borough is not SI or the BX, where there are few incidents and few asians. it is queens!
-- almost half of NYC's asian population is in queens
-- the likelihood of anti-asian hate crimes in queens is low, perhaps because there is safety in numbers? 
-- queens has triple the asian population of manhattan, but manhattan has triple the anti-asian hate crimes of queens 

--WHAT PRECINCT/NEIGHBORHOOD ARE THESE ANTI-ASIAN HATE CRIMES HAPPENING IN?
SELECT "Complaint Precinct Code", COUNT(DISTINCT("Full Complaint ID")) AS Incidents
FROM NYPD_Hate_Crimes_csv ny
WHERE "Bias Motive Description" = 'ANTI-ASIAN'
GROUP BY 1
ORDER BY 2 DESC
-- precinct 14, located in Midtown, has the most reports of anti-asian hate crimes

-- WHAT IS HAPPENING IN MY NEIGHBORHOOD? chinatown precinct 5
SELECT COUNT(DISTINCT("Full Complaint ID")) AS Incidents
FROM NYPD_Hate_Crimes_csv ny
WHERE "Bias Motive Description" = 'ANTI-ASIAN' AND "Complaint Precinct Code"=5

SELECT *
FROM NYPD_Hate_Crimes_csv ny
WHERE "Bias Motive Description" = 'ANTI-ASIAN' AND "Complaint Precinct Code"=5
--8 incidents in chinatown versus 21 in midtown