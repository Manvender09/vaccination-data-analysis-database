/*Task D.1 Here the query is finding the running total by simply adding the number of vaccinations which have taken place 
on the day and the days before it */
SELECT V.Country_Name AS Country_Name,
       V.Date AS Vaccination_On_Particular_Day_Number,
       (
           SELECT SUM(V1.Daily_Vaccinations) 
             FROM Vaccination V1
            WHERE V1.Country_Name = V.Country_Name AND 
                  V1.Date <= V.Date
       )
       AS Total_Injected_People
  FROM Vaccination V
 ORDER BY V.Country_Name,
          V.Date;


/* Task D.2 This Query will give the sum of Queries which were administered by the Each Country */
SELECT Country_Name AS Country,
       MAX(Total_Vaccinations) AS [Cumulative Doses]
  FROM Vaccination
 GROUP BY Country_Name
 ORDER BY "Cumulative Doses" DESC;


/* Task D.3 This query gives the list of all the vaccine name which are used by different Country */

SELECT Vaccine_Name AS Vaccine_Type,
                Country_Name AS Country
  FROM Location
 ORDER BY Vaccine_Name,
          Country_Name;

/* Task D.4*/


SELECT L.Source_Website AS [Source Name (URL)],
       max(V.Total_Vaccinations) AS [Largest total Administered Vaccines]
  FROM Location L
       JOIN
       Vaccination V ON L.Country_Name = V.Country_Name
 GROUP BY L.Source_Website
 ORDER BY V.Total_Vaccinations DESC;


/* Task D.5 */

SELECT strftime('%Y-%m', Vac.Date) AS Date_,
       MAX(CASE WHEN Vac.Country_Name = 'Australia' THEN Vac.People_Fully_Vaccinated END) AS Australia,
       MAX(CASE WHEN Vac.Country_Name = 'England' THEN Vac.People_Fully_Vaccinated END) AS England,
       MAX(CASE WHEN Vac.Country_Name = 'New Zealand' THEN Vac.People_Fully_Vaccinated END) AS New_Zealand,
       MAX(CASE WHEN Vac.Country_Name = 'United States' THEN Vac.People_Fully_Vaccinated END) AS United_States
FROM Vaccination Vac
JOIN Vaccine Vcc ON Vac.Country_Name = Vcc.Country_Name AND Vac.Date = Vcc.Date
WHERE strftime('%Y', Vac.Date) = '2022'
GROUP BY Date_
ORDER BY Date_;