--After Cleaning the table data here are some questions to analyze


-- 1. What is the gender breakdown of employees in the company?
select gender, count(gender) as count
from HRTable
group by gender
order by gender



-- 2. What is the race/ethnicity breakdown of employees in the company?
select race, count(race) as count
from HRTable
group by race


-- 3. What is the age distribution of employees in the company?
with age_specific as(

select 'Between 18 to 24' as Category, count(age) as count
from HRTable
where age >= 18 and age < 25
union
select 'Between 25 to 29', count(age)
from HRTable
where age >= 25 and age < 30
union
select 'Between 30 to 34', count(age)
from HRTable
where age >= 30 and age < 35
union
select 'Between 35 to 39', count(age)
from HRTable
where age >= 35 and age < 40
union
select 'Between 40 to 44', count(age)
from HRTable
where age >= 40 and age < 45
union
select 'Between 45 to 49', count(age)
from HRTable
where age >= 45 and age < 50
union
select 'Between 50 to 54', count(age)
from HRTable
where age >= 50 and age < 55
union
select 'Between 55 to 59', count(age)
from HRTable
where age >= 55 and age < 60

)
select *
from age_specific



-- 4. How many employees work at headquarters versus remote locations?
select location, count(location) as count
from HRTable
group by location


-- 5. What is the average length of employment for employees who have been terminated?
select avg(datediff(month, hire_date, termdate )) / 12 as count
from HRTable
where termdate is not null and getdate() > termdate


-- 6. How does the gender distribution vary across departments and job titles?
select jobtitle, department, gender, count(gender) as count
from HRTable
group by jobtitle, department, gender
order by department, gender


-- 7. What is the distribution of job titles across the company?
select jobtitle,count(gender) as count
from HRTable
group by jobtitle
order by jobtitle



-- 8. What is the distribution of employees across locations by city and state?
select location_city, location_state, count(gender) as count
from HRTable
group by location_city, location_state 
order by count desc


-- 9. What is the tenure distribution for each department?
select department, round(avg(DATEDIFF(day, hire_date, termdate) / 365),0) as average_tenure
from HRTable
where termdate <= getdate()
group by department