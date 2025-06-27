# 🏗️ AirBnB Database Schema

This file (`schema.sql`) defines the database structure for the AirBnB Clone project. It follows best practices for normalization, data integrity, and query performance.

---

## 📋 Tables Defined

- **User** – Stores guests, hosts, and admin accounts  
- **Property** – Listings created by hosts  
- **Booking** – Reservations made by users  
- **Payment** – Payments linked to bookings  
- **Review** – Ratings and comments left by guests  
- **Message** – User-to-user communication  
- **Location** *(optional)* – Normalized location data for future use  

---

## 🔐 Features & Constraints

- UUIDs (`CHAR(36)`) used as primary keys  
- Timestamp columns: `created_at`, `updated_at`  
- `CHECK` constraints for:
  - Email format
  - Role types (`guest`, `host`, `admin`)
  - Positive prices and amounts
  - Rating range (1–5)
  - Message length and uniqueness
- `UNIQUE` constraints (e.g., email, user-property reviews)  
- `FOREIGN KEY` constraints with `ON DELETE CASCADE`  
- Composite indexes for optimized performance  
- Optional trigger to auto-update `Property.updated_at`  

---

## ⚙️ Requirements

- **PostgreSQL 12+**  
  *(or MySQL 8.0+ with minor syntax adjustments)*  

### Enable UUID Extension (PostgreSQL only):
```sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

---

## 🛠️ Setup Instructions

### Initialize the database:
```bash
psql -U your_user -d your_database -f schema.sql

### **Verify table creation**:
```bash
\dt

### **Verify index creation**:
```bash
\di

### (Optional)
Uncomment and run the `Location` table if you're applying address normalization.

---

## 📌 Notes

- The schema is designed to support **role-based access** (`guest`, `host`, `admin`).
- Pre-defined **indexes** support faster lookups on commonly queried fields like `email`, `location`, `price`, and `status`.
- **Referential integrity** and **data validation** are enforced at the schema level.
