-- What we are solving?
-- Q: what are the most in-demand skills for my role?
-- - Here, we identify the top 5 most in-demand skills for a role. We can dynamically update therole to find the skills for any role.

select 
sd.skills,
count(jpf.job_id) as job_count
    
from job_postings_fact jpf
inner join skills_job_dim sjd on jpf.job_id = sjd.job_id
inner join skills_dim sd on sjd.skill_id = sd.skill_id
group by sd.skills
order by job_count desc
limit 5;


-- Writing a function where I can fynamically change the skill to analyse better insights
Create or replace function skills_based_on_role(role_title text)
returns TABLE (skills text, job_count int) as
$$
    select 
        sd.skills,
        count(jpf.job_id) as job_count
    from job_postings_fact jpf
    inner join skills_job_dim sjd on jpf.job_id = sjd.job_id
    inner join skills_dim sd on sjd.skill_id = sd.skill_id
    where jpf.job_title_short = role_title
    group by sd.skills
    order by job_count desc
    limit 5;
$$ language sql;

select skills_based_on_role('Data Analyst')