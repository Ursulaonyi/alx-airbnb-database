
---

### 📄 `README_seed.md`

```markdown
# 🌱 AirBnB Database Seed Data

This file (`seed.sql`) inserts realistic sample records into each table created by `schema.sql`. It is ideal for development, testing, and demo purposes.

---

## 📋 What’s Inside

Each table gets **3 sample rows**, including:

- Users (guests and hosts)
- Properties (linked to hosts)
- Bookings (linked to properties and guests)
- Payments (linked to bookings)
- Reviews (linked to users and properties)
- Messages (conversations between users)

---

## 📌 Data Features

- UUIDs are pre-generated for consistency
- Dates are realistic and future-oriented
- Amounts and ratings fall within expected ranges
- Email formats, phone numbers, and constraints are respected

---

## ▶️ Usage

1. **Ensure the schema is loaded**:
   ```bash
   psql -U your_user -d your_database -f schema.sql

2. **Run the seed script**:
   ```bash
psql -U your_user -d your_database -f seed.sql

3. **Query the tables**:
```sql
SELECT * FROM User;
SELECT * FROM Property;
