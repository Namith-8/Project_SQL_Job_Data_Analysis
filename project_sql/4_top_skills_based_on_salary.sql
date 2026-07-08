-- What are we solving?
-- Q: What are the top 20 skills based on salary?
-- - Here, we are looking at what is the average salary associated with a skill for DA position

create or replace function avg_salary_based_on_skill(skill_name text)
returns TABLE (skill text, avg_salary numeric) as 
$$ 
    --     sd.skills,
    --     avg(jf.salary_year_avg) as avg_salary
    -- from job_postings_fact jf
    -- inner join skills_job_dim sjd on jf.job_id = sjd.job_id
    -- inner join skills_dim sd on sjd.skill_id = sd.skill_id
    -- where sd.skills = skill_name
    -- group by sd.skills;

    select sd.skills, round(avg(jf.salary_year_avg), 2) as avg_salary
    from job_postings_fact jf 
    inner join skills_job_dim sjd on jf.job_id = sjd.job_id
    inner join skills_dim sd on sjd.skill_id = sd.skill_id
    where sd.skills = skill_name  and jf.job_title_short = 'Data Analyst' and jf.job_location = 'Anywhere'  and jf.salary_year_avg is not null
    group by sd.skills;
$$ language sql;

select * from avg_salary_based_on_skill('python');

-- This is the avg_sal for all the skills 
select sd.skills, round(avg(jf.salary_year_avg), 2) as avg_salary
    from job_postings_fact jf 
    inner join skills_job_dim sjd on jf.job_id = sjd.job_id
    inner join skills_dim sd on sjd.skill_id = sd.skill_id
    where jf.job_title_short = 'Data Analyst' and jf.job_location = 'Anywhere'  and jf.salary_year_avg is not null
    group by sd.skills
    order by avg_salary desc
    limit 20;