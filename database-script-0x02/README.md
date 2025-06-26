# 🏡 Airbnb Database Sample Data Seeding Script

## 📖 Overview

This repository contains a comprehensive SQL seeding script for an **Airbnb-style database**. The script populates the database with **realistic sample data** ideal for testing, development, and demonstration purposes.

---

## 📁 Project Information

- **Project**: ALX Airbnb Database  
- **File**: `seed.sql`  
- **Version**: 1.0  
- **Database**: PostgreSQL (v12+ recommended)

---

## 🧱 Database Schema

The seed script populates the following tables:

1. **User** – User accounts (hosts, guests, admins)  
2. **Property** – Property listings with details  
3. **Booking** – Reservation records  
4. **Payment** – Payment transaction records  
5. **Review** – User reviews and ratings  
6. **Message** – Communication between users

---

## 📊 Data Summary

### 👥 Users (16 total)

- **5 Hosts**: Property owners who list accommodations  
- **7 Guests**: Users who book accommodations  
- **2 Mixed-Role Users**: Act as both host and guest  
- **2 Admins**: Platform administrators  

---

### 🏠 Properties (12 total)

Diverse listings across major U.S. cities:

- Studios & apartments – NYC, Brooklyn  
- Beachfront condos – San Diego  
- Historic cottages – Charleston  
- Mountain cabins – Aspen, Denver  
- Ranch houses – Austin  
- Desert villas – Phoenix  
- Urban lofts and more  

**💵 Price Range**: $165 – $450 per night

---

### 📅 Bookings (15 total)

- **8 Confirmed** (past and future)  
- **2 Pending**  
- **2 Canceled**  
- **3 Repeat or extended stays**

**💰 Total Revenue**: $18,915 (confirmed only)

---

### 💳 Payments (10 records)

Includes:

- Credit Card  
- Stripe  
- PayPal

---

### 🌟 Reviews (10 records)

- **Rating Range**: 3–5 stars  
- **Avg. Rating**: 4.3/5  
- Mix of detailed praise and constructive feedback

---

### 💬 Messages (10 records)

Authentic exchanges between users:

- Booking inquiries  
- Property info requests  
- Amenity confirmations  
- Local tips

---

## ⚙️ Installation & Usage

### 🧰 Prerequisites

- PostgreSQL v12+  
- Database schema already created  
- `psql` CLI client installed  
- Insert permissions on target DB

---

### ▶️ Run the Seed Script

1. **Connect to DB**:
   ```bash
   psql -U username -d database_name
   ```

2. **Run from psql**:
   ```sql
   \i /path/to/seed.sql
   ```

3. **Or from CLI**:
   ```bash
   psql -U username -d database_name -f seed.sql
   ```

4. **With connection string**:
   ```bash
   psql postgresql://username:password@localhost:5432/database_name -f seed.sql
   ```

---

### 🔄 Reseeding a Fresh Database

Uncomment the following lines to truncate data before reseeding:

```sql
TRUNCATE TABLE Message CASCADE;
TRUNCATE TABLE Review CASCADE;
TRUNCATE TABLE Payment CASCADE;
TRUNCATE TABLE Booking CASCADE;
TRUNCATE TABLE Property CASCADE;
TRUNCATE TABLE "User" CASCADE;
```

⚠️ **Warning**: This will permanently delete existing data.

---

## 🔍 Sample Queries

### Confirmed Bookings with Details

```sql
SELECT 
    b.booking_id,
    u.first_name, u.last_name,
    p.name AS property_name,
    p.location,
    b.start_date, b.end_date,
    b.total_price
FROM Booking b
JOIN "User" u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
WHERE b.status = 'confirmed'
ORDER BY b.start_date;
```

### Properties and Their Average Ratings

```sql
SELECT 
    p.name,
    p.location,
    p.price_per_night,
    ROUND(AVG(r.rating), 2) AS avg_rating,
    COUNT(r.review_id) AS review_count
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id, p.name, p.location, p.price_per_night
ORDER BY avg_rating DESC NULLS LAST;
```

### Host Revenue Summary

```sql
SELECT 
    u.first_name, u.last_name,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.total_price) AS total_revenue
FROM "User" u
JOIN Property p ON u.user_id = p.host_id
JOIN Booking b ON p.property_id = b.property_id
WHERE b.status = 'confirmed'
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_revenue DESC;
```

---

## ✨ Key Features

### ✅ Realistic Data

- **UUIDs** for all primary keys  
- **BCrypt-hashed passwords**  
- **Geographically diverse properties**  
- **Plausible pricing and reviews**  
- **Human-like conversations**

### 🔗 Data Integrity

- Enforced foreign key relationships  
- Proper sequencing of records  
- Logical booking and payment flows

### 🧪 Edge Cases Included

- Canceled & pending bookings  
- Mixed and moderate reviews  
- Repeat guest scenarios  
- Extended bookings

---

## 🛠 Development Notes

### 🔐 Password Hash

All users share a test password:

```
$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewFBJfUK5KwjxBDm
```

This represents `"password123"`

---

### 📆 Date Timeline

- **Users**: Jan 2023 – Sept 2023  
- **Properties**: Jan 2023 – Sept 2023  
- **Bookings**: Jan 2024 – Feb 2025  
- **Reviews**: Jan 2024 – Dec 2024

---

## 🧩 Customization

To extend or modify the dataset:

- Add users with valid UUIDs  
- Ensure properties reference valid host IDs  
- Bookings must reference valid users/properties  
- Payments only for `confirmed` bookings  
- Reviews only for completed stays  
- Messages must follow sender-recipient logic

---

## 🧯 Troubleshooting

### Foreign Key Errors

- Insert parent rows first  
- Use consistent UUID formats  
- Use `TRUNCATE ... CASCADE` to clean before reseeding

### Duplicate Keys

- All UUIDs must be unique  
- Re-seed only after truncating

### Timestamps

- Use `YYYY-MM-DD HH:MM:SS`  
- Check timezone with `SHOW timezone;`

### Case Sensitivity

- PostgreSQL lowercases unquoted identifiers  
- Keep table names quoted if mixed-case (`"User"`)

### UUID Issues

- Use `uuid` data type  
- Enable UUID generation via `pgcrypto`:

```sql
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
```

---

## 🎬 Demo Scenario Ideas

Try using the seeded data to:

- Simulate host revenue dashboards  
- Trigger notifications for new bookings  
- Analyze top-rated cities  
- Test user authentication flows

---

## 🤝 Contributing

When expanding the seed script:

1. Match the style and format  
2. Use unique UUIDs  
3. Test all foreign key relationships  
4. Comment your inserts  
5. Keep data realistic and diverse

---

## 📄 License

This script is part of the **ALX Airbnb Database Project** and is intended solely for **educational and development** use.

> ⚠️ Do not use in production without data sanitization and appropriate security measures.
