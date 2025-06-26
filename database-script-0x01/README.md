# AirBnB Database Schema

## Overview
This directory contains the complete database schema definition for the ALX AirBnB project. The schema is designed to support a full-featured rental platform with users, properties, bookings, payments, reviews, and messaging functionality.

## Files Structure
```
database-script-0x01/
├── schema.sql          # Complete database schema with tables, constraints, and indexes
└── README.md          # This documentation file
```

## Database Design

### Schema Architecture
The database follows a normalized design pattern (3NF compliant) with six core entities:

1. **User** - Manages all platform users (guests, hosts, admins)
2. **Property** - Stores rental property information
3. **Booking** - Handles reservation transactions
4. **Payment** - Manages financial transactions
5. **Review** - Stores user feedback and ratings
6. **Message** - Facilitates user communication

### Entity Relationships
```
User (1) ----< Property (hosts multiple properties)
User (1) ----< Booking (makes multiple bookings)
User (1) ----< Review (writes multiple reviews)
User (1) ----< Message (sends/receives multiple messages)

Property (1) ----< Booking (receives multiple bookings)
Property (1) ----< Review (receives multiple reviews)

Booking (1) ---- Payment (1) (one-to-one relationship)
```

## Table Specifications

### User Table
- **Primary Key**: `user_id` (CHAR(36) - UUID)
- **Unique Constraints**: `email`
- **Enums**: `role` (guest, host, admin)
- **Indexes**: email, role, created_at

### Property Table
- **Primary Key**: `property_id` (CHAR(36) - UUID)
- **Foreign Keys**: `host_id` → User.user_id
- **Indexes**: host_id, location, price_per_night, created_at

### Booking Table
- **Primary Key**: `booking_id` (CHAR(36) - UUID)
- **Foreign Keys**: 
  - `property_id` → Property.property_id
  - `user_id` → User.user_id
- **Enums**: `status` (pending, confirmed, canceled)
- **Indexes**: property_id, user_id, dates, status, created_at

### Payment Table
- **Primary Key**: `payment_id` (CHAR(36) - UUID)
- **Foreign Keys**: `booking_id` → Booking.booking_id
- **Enums**: `payment_method` (credit_card, paypal, stripe)
- **Indexes**: booking_id, payment_method, payment_date

### Review Table
- **Primary Key**: `review_id` (CHAR(36) - UUID)
- **Foreign Keys**: 
  - `property_id` → Property.property_id
  - `user_id` → User.user_id
- **Unique Constraints**: `(user_id, property_id)` - one review per user per property
- **Check Constraints**: `rating` (1-5 range)
- **Indexes**: property_id, user_id, rating, created_at

### Message Table
- **Primary Key**: `message_id` (CHAR(36) - UUID)
- **Foreign Keys**: 
  - `sender_id` → User.user_id
  - `recipient_id` → User.user_id
- **Indexes**: sender_id, recipient_id, sent_at

## Key Features

### Data Integrity
- **Primary Keys**: UUID format for all entities
- **Foreign Key Constraints**: Proper referential integrity with CASCADE options
- **Check Constraints**: Data validation at database level
- **Unique Constraints**: Prevent duplicate entries where required

### Performance Optimization
- **Strategic Indexing**: 20+ indexes for optimal query performance
- **Composite Indexes**: Multi-column indexes for common query patterns
- **Proper Data Types**: Optimized storage with appropriate data types

### Business Logic
- **Triggers**: Automated business rule enforcement
  - Payment amount validation
  - Booking conflict prevention
  - Property timestamp updates
- **Constraints**: Business rule validation
  - Date range validation
  - Price validation
  - User role restrictions

## Installation Instructions

### Prerequisites
- MySQL 8.0+ or PostgreSQL 12+
- Database user with CREATE, ALTER, INSERT privileges

### Setup Steps

1. **Create Database**
   ```sql
   CREATE DATABASE airbnb_db;
   USE airbnb_db;
   ```

2. **Execute Schema**
   ```bash
   mysql -u username -p airbnb_db < schema.sql
   ```
   
   Or for PostgreSQL:
   ```bash
   psql -U username -d airbnb_db -f schema.sql
   ```

3. **Verify Installation**
   ```sql
   -- Check tables
   SHOW TABLES;
   
   -- Check constraints
   SELECT * FROM information_schema.table_constraints 
   WHERE table_schema = 'airbnb_db';
   
   -- Check indexes
   SHOW INDEX FROM User;
   ```

## Database Compatibility

### MySQL Specific Features
- ENUM data types for constrained values
- AUTO_INCREMENT alternatives using UUIDs
- MySQL-specific index syntax
- Trigger syntax compatible with MySQL 8.0+

### PostgreSQL Adaptations
- Enable UUID extension: `CREATE EXTENSION IF NOT EXISTS "uuid-ossp"`
- Replace ENUM with CHECK constraints if needed
- Adjust trigger syntax for PostgreSQL

⚠️ Note: PostgreSQL does not support native ENUM the same way as MySQL. You may need to:

Define custom ENUM types with CREATE TYPE

Or use VARCHAR with CHECK constraints for portability

## Performance Considerations

### Indexing Strategy
- **Single Column Indexes**: High-selectivity columns (email, dates)
- **Composite Indexes**: Common query patterns (user_id + status)
- **Covering Indexes**: Include frequently accessed columns

### Query Optimization
- Use prepared statements for repeated queries
- Leverage indexes for WHERE, ORDER BY, and JOIN clauses
- Consider query execution plans for complex operations

## Security Features

### Data Protection
- Password hashing (stored as hash, never plain text)
- Email format validation
- Phone number format validation
- SQL injection prevention through constraints

### Access Control
- Role-based user management
- Foreign key constraints prevent orphaned records
- Cascade options for data consistency

## Sample Data

The schema includes sample data for testing:
- 3 sample users (host, guest, admin)
- 2 sample properties
- 1 sample booking with payment
- 1 sample review
- 1 sample message

## Maintenance

### Regular Tasks
- Monitor index usage and performance
- Update statistics for query optimization
- Archive old data based on retention policy
- Backup database regularly

### Schema Evolution
- Use migration scripts for schema changes
- Test changes in development environment first
- Document all schema modifications

## Testing

### Validation Queries
The schema includes validation queries to verify:
- All tables created successfully
- All indexes applied correctly
- Foreign key relationships established
- Constraints working as expected

### Test Scenarios
- Insert valid data across all tables
- Test constraint violations
- Verify trigger functionality
- Test cascade operations

## Support

For issues or questions regarding the database schema:
1. Check the constraint definitions in schema.sql
2. Review the trigger implementations
3. Verify index usage for performance issues
4. Consult the entity relationship documentation

## Version History

- **v1.0**: Initial schema implementation
  - All core entities defined
  - Complete constraint implementation
  - Performance indexes added
  - Business logic triggers implemented

---

**Note**: This schema is designed for educational purposes as part of the ALX AirBnB project. For production use, additional considerations such as data encryption, audit trails, and advanced security measures should be implemented.