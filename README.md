# alx-airbnb-database

AirBnB Database Project - ALX Program

This repository contains the database schema and scripts for the AirBnB project at ALX.


## 📦 Entities Modeled

The database schema is designed to support the following entities:

- 👤 **Users** – Guests, hosts, and admins  
- 🏡 **Properties** – Listings created by hosts  
- 📅 **Bookings** – Reservations made by users  
- 💳 **Payments** – Financial transactions for bookings  
- ⭐ **Reviews** – User ratings and feedback on properties  
- 💬 **Messages** – Internal communication between users  

The schema follows **Third Normal Form (3NF)** to ensure data integrity and minimize data redundancy.

## Schema

The database schema is defined in the `schema.sql` file.

## Seeding

The `seed.sql` file contains sample data for testing and development purposes.

## ERD

The Entity-Relationship Diagram (ERD) for the database is available in the `ERD` folder.

## Normalization

The normalization report is available in the `normalization.md` file.

## Requirements

The database is designed to be compatible with PostgreSQL 12+.

## ⚙️ Requirements

- **PostgreSQL 12+**  
- Optional: Enable UUID extension

```sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

## Installation

To install the database, run the following command:
```
psql -U your_user -d your_database -f schema.sql
psql -U your_user -d your_database -f seed.sql


## 📌 Notes

- The schema enforces `CHECK`, `UNIQUE`, and `FOREIGN KEY` constraints  
- `ON DELETE CASCADE` is used to maintain referential integrity  
- Indexes are pre-defined for performance optimization  
- Supports role-based user access: `guest`, `host`, `admin`  

---

## 🧪 Testing

Run basic queries to explore the database:

```sql
SELECT * FROM Property WHERE price_per_night < 100;
SELECT * FROM Booking WHERE status = 'confirmed';
SELECT * FROM Review WHERE rating > 4;
SELECT * FROM Message WHERE sender_id = 'user_id';
```

## 📜 License

This project is licensed under the **MIT License**.

## 🎉 Enjoy your AirBnB database!