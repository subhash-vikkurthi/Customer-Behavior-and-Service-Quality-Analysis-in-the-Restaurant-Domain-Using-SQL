# Data Analysis Project using SQL
Here's your README in plain text/Markdown format — just copy and paste it into your `README.md` file:

---

```markdown
# 🍽️ Restaurant Data Analysis — SQL Project

> A comprehensive SQL analysis of restaurant consumer behaviour, ratings, and cuisine preferences across 5 relational datasets.

![SQL](https://img.shields.io/badge/SQL-Analysis-blue?style=flat-square)
![Datasets](https://img.shields.io/badge/Datasets-5%20CSVs-green?style=flat-square)
![Techniques](https://img.shields.io/badge/Techniques-JOINs%20%7C%20CTEs%20%7C%20Views%20%7C%20Stored%20Procedures-purple?style=flat-square)

---

## 📁 Project Structure

```
restaurant-sql-analysis/
├── data/
│   ├── consumers.csv
│   ├── restaurants.csv
│   ├── cuisines.csv
│   ├── ratings.csv
│   └── consumer_preferences.csv
├── joins_and_subqueries.sql
├── views.sql
├── stored_procedures.sql
├── ctes_and_window_functions.sql
└── README.md
```

---

## 📊 Datasets

| File | Description |
|------|-------------|
| `consumers.csv` | Consumer demographics & profile data |
| `restaurants.csv` | Restaurant details & attributes |
| `cuisines.csv` | Cuisine types offered per restaurant |
| `ratings.csv` | Consumer ratings per restaurant |
| `consumer_preferences.csv` | Preferred cuisine per consumer |

---

## 🛠️ SQL Techniques Used

| Technique | Purpose |
|-----------|---------|
| **JOINs** | INNER, LEFT, and multi-table joins across all 5 datasets |
| **Subqueries** | Nested queries for filtering, ranking, and dynamic thresholds |
| **Views** | Reusable virtual tables to simplify complex query logic |
| **Stored Procedures** | Parameterized routines for repeatable, dynamic analysis |
| **CTEs** | Common Table Expressions to break complex logic into steps |
| **Window Functions** | RANK(), DENSE_RANK(), and partition-based aggregations |
| **WHERE & Aggregations** | GROUP BY, HAVING, COUNT, AVG for segment-level insights |

---

## 💡 Sample Query

```sql
-- Top restaurants by average rating using CTE + Window Function
WITH RatingsSummary AS (
  SELECT
    r.restaurant_id,
    r.name,
    AVG(rt.overall_rating) AS avg_rating,
    COUNT(rt.consumer_id) AS total_reviews
  FROM restaurants r
  JOIN ratings rt ON r.restaurant_id = rt.restaurant_id
  GROUP BY r.restaurant_id, r.name
)
SELECT *,
  RANK() OVER (ORDER BY avg_rating DESC) AS rank
FROM RatingsSummary
WHERE total_reviews > 5;
```

---

## 📌 Key Insights

- ✅ Identified key **consumer segments** based on demographics, cuisine preferences, and dining behaviour.
- ✅ Evaluated **restaurant performance** by correlating ratings, cuisine type, and consumer satisfaction.
- ✅ Uncovered **patterns in preferences and satisfaction** — which cuisines attract the best-rated restaurants and which consumer profiles drive repeat visits.

---

## 🏁 Conclusion

The SQL queries collectively demonstrate how relational data across **consumers, restaurants, cuisines, and ratings** can be used to derive meaningful business insights. By applying `WHERE` clauses, JOINs, subqueries, aggregations, CTEs, window functions, views, and stored procedures, the analysis successfully identifies key consumer segments, evaluates restaurant performance, and uncovers patterns in preferences and satisfaction.

Overall, these queries show that **structured SQL analysis is an effective foundation for data-driven decision-making**, enabling businesses to optimize customer targeting, improve restaurant quality, and enhance overall platform performance.

---

## 🚀 How to Run

1. Import the CSV files into your SQL environment (MySQL / PostgreSQL).
2. Run the SQL files in the following order:

```sql
SOURCE joins_and_subqueries.sql;
SOURCE views.sql;
SOURCE stored_procedures.sql;
SOURCE ctes_and_window_functions.sql;
```

---

*Made with ❤️ using SQL · Data Analysis Project*
```

---

Just update the CSV filenames and SQL filenames to match your actual files if they're named differently, and you're good to go!
