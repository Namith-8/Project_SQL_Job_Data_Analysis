-- What are we solving?
-- Q: what are the most optimal skills to learn 
-- - Here, we identify the skills which are in high demand and high average salaires associated with DA roles ADD
-- - Why? We are targeting skills that offer job security ( high demand) and financial benefits (high salary) for Data Analyst roles.
-- - This will help individuals prioritize their learning and development efforts to maximize career growth and earning potential.


WITH skill_demand AS ( SELECT 
        sjd.skill_id,
        COUNT(sjd.job_id) AS demand_count
    FROM skills_job_dim AS sjd
    GROUP BY sjd.skill_id ),
average_salary AS (
    SELECT 
        sjd.skill_id,
        ROUND(AVG(jpf.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
    WHERE 
        jpf.job_title_short = 'Data Analyst' 
        AND jpf.salary_year_avg IS NOT NULL
    GROUP BY sjd.skill_id )
SELECT 
    sd.skills,
    demand.demand_count,
    salary.avg_salary
FROM skills_dim AS sd
INNER JOIN skill_demand AS demand ON sd.skill_id = demand.skill_id
INNER JOIN average_salary AS salary ON sd.skill_id = salary.skill_id
WHERE 
    demand.demand_count > 10
ORDER BY 
    salary.avg_salary DESC, 
    demand.demand_count DESC;