# Introduction
📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

SQL Querries? Check them out here: [project_sql](/project_sql/)

### The questions that I will be answering through my SQL querries are:
1. What are the top paying data analyst jobs?
2. What skills are required for these top paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. Wjat are te most optimal skills to learn?

# Tools I used 
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

1. SQL: The backbone of my analysis, allowing me to query the database and unearth critical insights.
2. PostgreSQL: The chosen database management system, ideal for handling the job posting data.
3. Visual Studio Code: My go-tg for database management and executing SQL queries.
4. Git & Github: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis 

### 1. Top paying DA jobs

 Top 10 Highest-Paying Remote Data Analyst Jobs

This query identifies the top 10 most lucrative remote Data Analyst opportunities.

 View Creation: It creates a reusable virtual table (top_10_DA) that joins job posting data with company names, providing a clear context for each role.

 Data Filtering: It isolates 'Data Analyst' positions that are located 'Anywhere' (remote) and ensures only roles with confirmed salary data are included.

 Analysis: Finally, it selects the data from the view, sorting the roles by salary_year_avg in descending order to surface the highest-paying opportunities.

 ``` sql
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
```

# What I learnt 

# Data Analyst Job Market Analysis

## 📊 Project Overview
This project explores the remote Data Analyst job market by analyzing job postings, salary trends, and in-demand skills. Using SQL and PostgreSQL, I queried a database of job listings to uncover insights about compensation, required technical skills, and the value of specific certifications.

## 🛠️ Tools & Technologies
- **SQL**: Core language for data extraction, aggregation, and analysis.
- **PostgreSQL**: Database management system for handling large datasets and custom functions.
- **Visual Studio Code**: Used for writing, executing, and debugging SQL queries.
- **Git & GitHub**: Version control and project collaboration.

---

## 🔍 Key Insights & Analysis

### 1. Top-Paying Remote Data Analyst Roles
**Query Goal:** Identify the highest-paying remote Data Analyst jobs.
- **Method:** Joined `job_postings_fact` with `company_dim` to retrieve company names, filtered for "Anywhere" locations, and sorted by `salary_year_avg`.
- **Finding:** The top role found was at **Mantys** with a reported salary of **$650,000**, followed by **Meta** ($336,500) and **AT&T** ($255,829).
- **Insight:** High-paying remote roles often require senior-level titles (e.g., "Director of Analytics") or specialized industry experience. Data anomalies (like the $650K outlier) highlight the importance of data validation in real-world datasets.

### 2. Skills Correlation with High Salaries
**Query Goal:** Determine which skills are associated with the top 10 highest-paying jobs.
- **Method:** Created a CTE (`top_jobs`) to isolate top earners, then used `STRING_AGG` to concatenate required skills into a single readable string.
- **Finding:** While some top entries had missing skill data, roles at companies like **AT&T** required a robust stack: `sql`, `python`, `r`, `azure`, and `databricks`.
- **Insight:** The highest-paying roles are not just about SQL; they demand **full-stack analytics capabilities** including cloud platforms (Azure) and advanced programming (Python/R).

### 3. Most In-Demand Skills by Job Count
**Query Goal:** Create a dynamic function to find the top 5 most requested skills for any role.
- **Method:** Developed a PostgreSQL function `skills_based_on_role(role_title)` to count occurrences of each skill in job postings.
- **Finding for Data Analysts:**
  1. **SQL**: ~92,628 job postings
  2. **Excel**: ~67,031 job postings
  3. **Python**: ~57,326 job postings
- **Insight:** **SQL remains the undisputed king** of data analyst skills. While Python is growing rapidly, Excel still holds a strong second place, suggesting that business reporting remains a core requirement.

### 4. Salary Premium by Skill
**Query Goal:** Calculate the average salary associated with specific skills.
- **Method:** Built a function `avg_salary_based_on_skill(skill_name)` to compute average compensation.
- **Finding:** Jobs requiring **Python** have an average salary of **$101,397**.
- **Insight:** Adding Python to a SQL skill set can significantly boost earning potential. This quantifiable data helps justify the time investment in learning programming languages for career advancement.

### 5. Optimal Skills: Demand vs. Salary Trade-off
**Query Goal:** Identify skills that offer the best balance of high job demand and high salary.
- **Method:** Used CTEs to calculate `demand_count` and `avg_salary` for each skill, then joined them to find the "sweet spot."
- **Top Findings:**
  | Skill | Job Demand | Avg Salary |
  | :--- | :--- | :--- |
  | **svn** | 1,202 | $400,000 |
  | **solidity** | 440 | $179,000 |
  | **couchbase** | 641 | $160,515 |
  | **datarobot** | 806 | $155,486 |
- **Insight:** Niche skills like **Solidity** (blockchain) and **Couchbase** (NoSQL) offer high salaries with decent demand. While `svn` shows a high average, it likely reflects legacy systems or small sample sizes. Emerging tools like **DataRobot** (AI/ML automation) indicate a shift toward automated analytics roles.

---

## 💡 Key Takeaways
1. **SQL is Non-Negotiable:** It is the most requested skill by a wide margin.
2. **The "Python Effect":** Knowing Python adds value, with average salaries jumping to ~$101K.
3. **Cloud & Automation Matter:** Skills in Azure, Databricks, and DataRobot are becoming differentiators for senior roles.
4. **Data Quality is Key:** Real-world data contains outliers and missing values (NULLs), requiring careful cleaning and interpretation.

## 🚀 Future Improvements
- Expand analysis to include geographic salary variations.
- Visualize skill trends over time to identify emerging technologies.
- Integrate Python (Pandas/Matplotlib) for advanced data visualization directly from the SQL results.
  

# 🏁 Conclusion

### Key Takeaways
This project successfully demonstrated how SQL can be leveraged to extract actionable insights from complex job market data. By analyzing over 100,000+ Data Analyst job postings, I uncovered three critical trends:

1.  **The "SQL First" Reality:** Despite the rise of AI and Python, **SQL** remains the absolute foundation of the Data Analyst role, appearing in nearly **92,000+ job postings**—significantly outpacing Excel and Python.
2.  **The Salary Multiplier Effect:** While foundational skills get you hired, **specialized technical skills** drive compensation. Proficiency in Python, cloud platforms (Azure, Databricks), or niche tools like **Solidity** and **Couchbase** can increase average salaries by **40–80%**.
3.  **Remote Work is Real:** The "Anywhere" job market is robust, with top-tier companies (Meta, AT&T) offering competitive six-figure salaries for remote talent, provided they possess a full-stack skill set.

### Technical Highlights
-   **Advanced SQL Techniques:** Utilized **CTEs**, **Window Functions**, and **User-Defined Functions (UDFs)** to create dynamic, reusable analysis tools.
-   **Data Cleaning & Validation:** Identified and handled data anomalies (e.g., salary outliers) and missing values (NULLs) to ensure accurate reporting.
-   **Scalable Analysis:** Designed a modular database schema (`fact` and `dimension` tables) that allows for easy expansion into new roles or geographic regions.

### Future Improvements
To further enhance this project, I plan to:
-   **Time-Series Analysis:** Track how skill demand and salaries have evolved over the last 3 years to predict future trends.
-   **Geographic Heatmaps:** Visualize salary variations by location (e.g., US vs. India vs. Europe) to identify global arbitrage opportunities.
-   **Interactive Dashboard:** Connect the PostgreSQL database to **Tableau** or **Power BI** to create a live, interactive dashboard for stakeholders.
-   **Sentiment Analysis:** Incorporate NLP techniques to analyze job description text for "soft skill" keywords (e.g., "leadership," "communication") and correlate them with salary bands.

### Final Thought
This analysis proves that while the core of data analysis remains rooted in SQL, the ceiling for career growth and salary is defined by **adaptability** and **specialization**. For aspiring data professionals, the path forward is clear: master the fundamentals, then strategically layer on high-value, emerging technologies.

---
*Built with ❤️ *
