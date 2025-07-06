# 🧠 Complex SQL Joins - Airbnb Database

This submodule contains advanced SQL queries demonstrating the use of different join operations on the ALX Airbnb database schema.

## 📌 Task Objective

**Goal**: Master SQL joins by writing complex queries using different types of joins.

### ✅ Queries Included

1. **INNER JOIN**  
   Retrieves all bookings along with the user who made each booking. Excludes bookings without an associated user.

2. **LEFT JOIN**  
   Retrieves all properties along with any reviews they have. Includes properties even if no reviews exist.

3. **FULL OUTER JOIN**  
   Retrieves all users and all bookings, even if the user has no booking or a booking isn't linked to a user.

## 📂 Files

- `joins_queries.sql`: Contains all three SQL queries using INNER JOIN, LEFT JOIN, and FULL OUTER JOIN.
- `README.md`: This file.

## 🔧 Prerequisites

- PostgreSQL 12+
- Properly set up Airbnb schema with the following tables:
  - `Users`
  - `Booking`
  - `Property`
  - `Review`

## ▶️ Run Queries

To run the queries:

```bash
psql -U your_user -d your_database -f joins_queries.sql


## ✅ Output Expectations

You should see result sets showing:

- **User and booking pairs** (INNER JOIN)
- **All properties with or without reviews** (LEFT JOIN)
- **A combined view of all users and all bookings** (FULL OUTER JOIN)

---

## 🎓 Learn More

This task is part of the **"Unleashing Advanced Querying Power"** module of the **ALX Airbnb Database Project**.

## 🌟 Enjoy your AirBnB database!