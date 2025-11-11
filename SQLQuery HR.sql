Select * from [dbo].[Human Resources]

EXEC sp_rename '[dbo].[Human Resources].id', 'Emp_ID', 'Column' 

EXEC sp_help '[dbo].[Human Resources]'

SELECT race, COUNT(*) AS race_count
FROM [dbo].[Human Resources]
WHERE termdate IS NULL
GROUP BY race;

/* To get age given that we know the birthdate of the employeee and create a new variable Age*/



ALTER TABLE [dbo].[Human Resources]
ADD [Age] INT;


UPDATE [dbo].[Human Resources]
SET [Age] = DATEDIFF(YEAR, [birthdate], GETDATE()) 
            - CASE 
                WHEN DATEADD(YEAR, DATEDIFF(YEAR, [birthdate], GETDATE()), [birthdate]) > GETDATE() 
                THEN 1 ELSE 0 
              END;
select [Age]
from [dbo].[Human Resources]

/* Grouping the Age into cathegories and creating a new variable Age_Group*/

ALTER TABLE [dbo].[Human Resources]
ADD Age_Group Varchar(100);

UPDATE [dbo].[Human Resources]
SET  [Age_Group]=
    CASE
        WHEN [Age]>= 18 AND [Age] <= 24 THEN '18-24'
        WHEN [Age] >= 25 AND [Age] <= 34 THEN '25-34'
        WHEN [Age]>= 35 AND [Age] <= 44 THEN '35-44'
        WHEN [Age]>= 45 AND [Age]<= 54 THEN '45-54'
        WHEN [Age]>= 55 AND [Age] <= 64 THEN '55-64'
        ELSE '65+'
    END;


-- some querries

Select  [Age_Group]
From [dbo].[Human Resources]
group by [Age_Group] 


SELECT 
    MIN([Age]) AS Min_Age,
    MAX([Age]) AS Max_Age
FROM [dbo].[Human Resources];

select count(*)
from [dbo].[Human Resources]
Where [Age]<18

SELECT 
    [Age_Group],
    COUNT(*) AS Age_Group_Count
FROM [dbo].[Human Resources]
GROUP BY [Age_Group]
ORDER BY [Age_Group];

SELECT 
    [Age_Group],
    COUNT(*) AS Age_Group_Count
FROM [dbo].[Human Resources]
WHERE termdate IS NULL
GROUP BY [Age_Group]
ORDER BY [Age_Group];


SELECT 
    [Age_Group],
    COUNT(*) AS Age_Group_Count,
    RTRIM(CAST(CAST(100.0 * COUNT(*) / SUM(COUNT(*)) OVER() AS DECIMAL(5,2)) AS VARCHAR(10))) + '%' AS percentage
FROM [dbo].[Human Resources]
WHERE termdate IS NULL
GROUP BY [Age_Group]
ORDER BY [Age_Group]


SELECT 
    [Age_Group],
    COUNT(*) AS Age_Group_Count,
    RTRIM(CAST(CAST(100.0 * COUNT(*) / SUM(COUNT(*)) OVER() AS DECIMAL(5,2)) AS VARCHAR(10))) AS percentage
FROM [dbo].[Human Resources]
WHERE termdate IS NULL
GROUP BY [Age_Group]
ORDER BY [Age_Group]



select [termdate]
From [dbo].[Human Resources]

SELECT termdate, termdate_new
FROM [dbo].[Human Resources]
WHERE termdate_new IS NULL;

select [birthdate]
from [dbo].[Human Resources]

UPDATE [dbo].[Human Resources]
SET termdate = LEFT(termdate, 10);

select [termdate]
From [dbo].[Human Resources]



ALTER TABLE [dbo].[Human Resources]
ALTER COLUMN termdate DATE NULL;

SELECT termdate, COUNT(*) 
FROM [dbo].[Human Resources]
GROUP BY termdate
ORDER BY termdate;

--What is the gender breakdown of employees in the company

Select [gender], Count (*) As Gender_Count
From [dbo].[Human Resources]
where termdate IS NUll
Group by gender

--what is the race breakdown of employees in the company

Select [race], Count (*) As Race_Count
From [dbo].[Human Resources]
where termdate IS NUll
Group by [race]
order by Count(*) Desc

-- what is the age distribution of employees in the company

SELECT 
    MIN([Age]) AS Min_Age,
    MAX([Age]) AS Max_Age
FROM [dbo].[Human Resources]
where termdate IS NUll

-- By age group

Select [Age_Group], Count (*) As AgeGrp_Count
From [dbo].[Human Resources]
where termdate IS NUll
Group by [Age_Group]
order by [Age_Group]


-- how is gender distributed by AgeGrp

Select [gender],[Age_Group], Count (*) As Count 
From [dbo].[Human Resources]
where termdate IS NUll
Group by [Age_Group],[gender]
order by [Age_Group],[gender]

-- how many employees work at headquaters ver remote locations?

Select [location], Count(*) as Count_Location
From [dbo].[Human Resources]
where termdate IS NUll
Group by [location]

--What is the average lenght of employment for employees who have been terminated?

SELECT 
    AVG(DATEDIFF(DAY, [hire_date], [termdate]))/365 AS AvgLengthEmployment_Days
FROM [dbo].[Human Resources]
WHERE termdate IS NOT NULL;

--how does the gender distribution vary across department and job title

Select [department],[gender], Count(*) As Count
From [dbo].[Human Resources]
where termdate IS NUll
Group by [department],[gender]
order by [department],[gender]

--What is the distribution of Job titles across the company

select [jobtitle], Count(*) AS Jobtitle_count
From [dbo].[Human Resources]
where termdate IS NUll
Group by [jobtitle]
order by [jobtitle] DESC;

--Which department has the highest turnover rate? this does not take off the decimals so use the second

SELECT 
    [department],
    RTRIM(CAST(
        ROUND(COUNT(CASE WHEN termdate IS NOT NULL THEN 1 END) * 1.0 / COUNT(*) * 100, 2)
        AS VARCHAR(50)
    )) AS TurnoverRate_Percent,
    COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN termdate IS NOT NULL THEN 1 END) AS TerminatedEmployees
FROM [dbo].[Human Resources]
GROUP BY [department]
ORDER BY TurnoverRate_Percent DESC;

--use this 

SELECT 
    Department,
    FORMAT(
        COUNT(CASE WHEN termdate IS NOT NULL THEN 1 END) * 1.0 / COUNT(*) * 100, 
        '0.#'
    ) + '%' AS TurnoverRate,
    COUNT(*) AS TotalEmployees,
    COUNT(CASE WHEN termdate IS NOT NULL THEN 1 END) AS TerminatedEmployees
FROM [dbo].[Human Resources]
GROUP BY Department
ORDER BY 
    COUNT(CASE WHEN termdate IS NOT NULL THEN 1 END) * 1.0 / COUNT(*) DESC;

--What is the distribution of employees across locations by city and state?

Select [location_state], Count(*) as Count_Location_State
From [dbo].[Human Resources]
where termdate IS NUll
Group by [location_state]
order by Count_Location_State DESC;


--How has the companys employee count changed over time based on hire and the term dates?


SELECT
    Year,
    Hires,
    Terminations,
    Hires - Terminations AS Net_Change,
    ROUND(
        (CAST(Hires - Terminations AS FLOAT) / NULLIF(Hires, 0)) * 100, 
        2
    ) AS Net_Change_Percent
FROM (
    SELECT 
        YEAR([hire_date]) AS Year,
        COUNT(*) AS Hires,
        SUM(CASE WHEN termdate IS NOT NULL THEN 1 ELSE 0 END) AS Terminations
    FROM [dbo].[Human Resources]
    GROUP BY YEAR([hire_date])
) AS Subquery
ORDER BY Year ASC;


-- what is the tenure distribution for each department?

SELECT 
    department,
    CAST(ROUND(AVG(DATEDIFF(DAY, hire_date, ISNULL(termdate, GETDATE())) / 365.0), 1) AS DECIMAL(10,1)) AS Avg_Tenure_Years
FROM [dbo].[Human Resources]
WHERE termdate IS NOT NULL
GROUP BY department
ORDER BY Avg_Tenure_Years DESC;



  