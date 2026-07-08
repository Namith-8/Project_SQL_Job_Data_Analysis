-- What aer we solving?
-- Q: What skills are required for the top=paying data analyst jobs?
-- - Here, we use the top 10 highest paying DA jobs from querry 1 
-- - We then also add the specific skills that are required for this role 


-- select 
--         jf.job_id,
--         c.name as company_name,
--         sd.skills,
--         jf.company_id,
--         job_title as Title,
--         job_schedule_type,
--         search_location as City,
--         job_posted_date,
--         salary_year_avg as Avg_Salary
--     from job_postings_fact jf
--     left join company_dim c on c.company_id = jf.company_id
--     inner join skills_job_dim sjd on jf.job_id = sjd.job_id
--     inner join skills_dim sd on sjd.skill_id = sd.skill_id 

--     where job_title_short = 'Data Analyst'
--       and job_location = 'Anywhere'
--       and salary_year_avg is not null
--       order by salary_year_avg desc

-- limit 10

-- with top_jobs as (
--     select
--         job_id,
--         company_id,
--         job_title,
--         job_schedule_type,
--         search_location,
--         job_posted_date,
--         salary_year_avg
--     from job_postings_fact
--     where job_title_short = 'Data Analyst'
--       and job_location = 'Anywhere'
--       and salary_year_avg is not null
--     order by salary_year_avg desc
--     limit 10
-- )
-- select
--     tj.job_id,
--     c.name as company_name,
--     tj.company_id,
--     tj.job_title as Title,
--     tj.job_schedule_type,
--     tj.search_location as City,
--     sd.skills,
--     tj.job_posted_date,
--     tj.salary_year_avg as Avg_Salary
-- from top_jobs tj
-- inner join company_dim c on c.company_id = tj.company_id
-- inner join skills_job_dim sjd on sjd.job_id = tj.job_id
-- inner join skills_dim sd on sd.skill_id = sjd.skill_id
-- -- group by
-- --     tj.job_id,
-- --     c.name,
-- --     sd.skills,
-- --     tj.company_id,
-- --     tj.job_title,
-- --     tj.job_schedule_type,
-- --     tj.search_location,
-- --     tj.job_posted_date,
-- --     tj.salary_year_avg
-- order by tj.salary_year_avg desc
-- Limit 10;


WITH top_jobs as (
    select
        job_id, company_id, job_title, job_schedule_type, 
        search_location, job_posted_date, salary_year_avg
    from job_postings_fact
    where job_title_short = 'Data Analyst'
      and job_location = 'Anywhere'
      and salary_year_avg is not null
    order by salary_year_avg desc
    limit 10
)
select
    tj.job_id,
    c.name as company_name,
    tj.job_title as Title,
    tj.salary_year_avg as Avg_Salary,
    -- This groups all skills for the job into a single comma-separated string
    STRING_AGG(sd.skills, ', ') as skills_required
from top_jobs tj
left join company_dim c on c.company_id = tj.company_id
left join skills_job_dim sjd on sjd.job_id = tj.job_id
left join skills_dim sd on sd.skill_id = sjd.skill_id
group by tj.job_id, c.name, tj.job_title, tj.salary_year_avg
order by tj.salary_year_avg desc;

-- Exporting it for insights to a CSV file
COPY (
    -- Your entire query goes here
    WITH top_jobs as (
        select job_id, company_id, job_title, salary_year_avg
        from job_postings_fact
        where job_title_short = 'Data Analyst'
          and job_location = 'Anywhere'
          and salary_year_avg is not null
        order by salary_year_avg desc
        limit 10
    )
    select tj.job_id, c.name, tj.job_title, tj.salary_year_avg
    from top_jobs tj
    left join company_dim c on c.company_id = tj.company_id
) TO 'C:\Users\dell\Desktop\Grind\Project_SQL_Job_Data_Analysis\project_sql\top_paying_job_skills.csv' WITH (FORMAT CSV, HEADER);

/*

 **Job Market Insights**

Based on the 10 roles listed, here is the breakdown of the data:

Average Salary : The average annual salary for these top-tier positions is $264,506.

Salary Range : The salaries range significantly from $184,000 to $650,000, indicating a wide variance based on seniority, company, and specific responsibilities.

Top Paying Roles :
    Mantys  leads the list with a Data Analyst role paying $650,000.
    Meta  follows with a Director of Analytics role at $336,500.
    AT&T  offers an Associate Director position at $255,829.50.

 Key Observations
Seniority Premiums: High-paying roles often carry senior titles such as "Director," "Associate Director," or "Principal Data Analyst," confirming that leadership and specialized experience are major salary drivers.

Company Impact: Large organizations like Meta and AT&T feature prominently, which is consistent with the trend of major tech and telecommunications firms offering competitive compensation for data-centric leadership.

Data Consistency: The data provided is clean and represents a specific subset of the job market ("Anywhere" locations). In a broader analysis, one would typically join this data with a "skills_job_dim" table to map these specific job_id entries to their required technical skills (such as Python, SQL, or Tableau).

*/
--  JSON OUTPUT of the querry 
-- [
--   {
--     "job_id": 226942,
--     "name": "Mantys",
--     "job_title": "Data Analyst",
--     "salary_year_avg": 650000.0
--   },
--   {
--     "job_id": 547382,
--     "name": "Meta",
--     "job_title": "Director of Analytics",
--     "salary_year_avg": 336500.0
--   },
--   {
--     "job_id": 552322,
--     "name": "AT&T",
--     "job_title": "Associate Director- Data Insights",
--     "salary_year_avg": 255829.5
--   },
--   {
--     "job_id": 99305,
--     "name": "Pinterest Job Advertisements",
--     "job_title": "Data Analyst, Marketing",
--     "salary_year_avg": 232423.0
--   },
--   {
--     "job_id": 1021647,
--     "name": "Uclahealthcareers",
--     "job_title": "Data Analyst (Hybrid/Remote)",
--     "salary_year_avg": 217000.0
--   },
--   {
--     "job_id": 168310,
--     "name": "SmartAsset",
--     "job_title": "Principal Data Analyst (Remote)",
--     "salary_year_avg": 205000.0
--   },
--   {
--     "job_id": 731368,
--     "name": "Inclusively",
--     "job_title": "Director, Data Analyst - HYBRID",
--     "salary_year_avg": 189309.0
--   },
--   {
--     "job_id": 310660,
--     "name": "Motional",
--     "job_title": "Principal Data Analyst, AV Performance Analysis",
--     "salary_year_avg": 189000.0
--   },
--   {
--     "job_id": 1749593,
--     "name": "SmartAsset",
--     "job_title": "Principal Data Analyst",
--     "salary_year_avg": 186000.0
--   },
--   {
--     "job_id": 387860,
--     "name": "Get It Recruit - Information Technology",
--     "job_title": "ERM Data Analyst",
--     "salary_year_avg": 184000.0
--   }
-- ]
