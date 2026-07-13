-- What are we solving?
-- Q: What are the top paying data analyst jobs?
-- - Here, we are identifying the top 10 highest paying DA roles that are available remotely 
-- - Focusing on the job postings with specified salaries 


-- with top_10_DA as (
--     select 
--         job_id,
--         c.name as company_name,
--         jf.company_id,
--         job_title,
--         job_schedule_type,
--         search_location,
--         job_posted_date,
--         salary_year_avg
--     from job_postings_fact jf
--     left join company_dim c on c.company_id = jf.company_id
--     where job_title_short = 'Data Analyst'
--       and job_location = 'Anywhere'
--       and salary_year_avg is not null
-- )

-- select * from top_10_DA
-- order by salary_year_avg desc
--     limit 10;

    create view top_10_DA as (
        select 
            job_id,
            c.name as company_name,
            jf.company_id,
            job_title,
            job_schedule_type,
            search_location,
            job_posted_date,
            salary_year_avg
        from job_postings_fact jf
        left join company_dim c on c.company_id = jf.company_id
        where job_title_short = 'Data Analyst'
        and job_location = 'Anywhere'
        and salary_year_avg is not null
    )

    select * from top_10_DA
    order by salary_year_avg desc
        limit 10;

