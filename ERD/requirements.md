# Entity-Relationship Diagram (ERD) Requirements

## Project Overview
This document outlines the requirements for creating a comprehensive Entity-Relationship Diagram (ERD) for the ALX AirBnB Database project. The ERD serves as a visual blueprint for the database structure, illustrating entities, attributes, and relationships.

## Entities Identified

### 1. User
**Purpose**: Represents all users in the system (guests, hosts, and admins)
**Attributes**:
- user_id (Primary Key, UUID, Indexed)
- first_name (VARCHAR, NOT NULL)
- last_name (VARCHAR, NOT NULL)
- email (VARCHAR, UNIQUE, NOT NULL)
- password_hash (VARCHAR, NOT NULL)
- phone_number (VARCHAR, NULL)
- role (ENUM: guest, host, admin, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### 2. Property
**Purpose**: Represents rental properties listed on the platform
**Attributes**:
- property_id (Primary Key, UUID, Indexed)
- host_id (Foreign Key → User.user_id)
- name (VARCHAR, NOT NULL)
- description (TEXT, NOT NULL)
- location (VARCHAR, NOT NULL)
- price_per_night (DECIMAL, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- updated_at (TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP)

### 3. Booking
**Purpose**: Represents reservation transactions between guests and properties
**Attributes**:
- booking_id (Primary Key, UUID, Indexed)
- property_id (Foreign Key → Property.property_id)
- user_id (Foreign Key → User.user_id)
- start_date (DATE, NOT NULL)
- end_date (DATE, NOT NULL)
- total_price (DECIMAL, NOT NULL)
- status (ENUM: pending, confirmed, canceled, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### 4. Payment
**Purpose**: Represents financial transactions for bookings
**Attributes**:
- payment_id (Primary Key, UUID, Indexed)
- booking_id (Foreign Key → Booking.booking_id)
- amount (DECIMAL, NOT NULL)
- payment_date (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- payment_method (ENUM: credit_card, paypal, stripe, NOT NULL)

### 5. Review
**Purpose**: Represents user feedback and ratings for properties
**Attributes**:
- review_id (Primary Key, UUID, Indexed)
- property_id (Foreign Key → Property.property_id)
- user_id (Foreign Key → User.user_id)
- rating (INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL)
- comment (TEXT, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### 6. Message
**Purpose**: Represents communication between users
**Attributes**:
- message_id (Primary Key, UUID, Indexed)
- sender_id (Foreign Key → User.user_id)
- recipient_id (Foreign Key → User.user_id)
- message_body (TEXT, NOT NULL)
- sent_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

## Relationships Defined

### 1. User ↔ Property (One-to-Many)
- **Relationship**: "hosts" / "hosted by"
- **Description**: One user (host) can own multiple properties, but each property belongs to one host
- **Cardinality**: 1:N
- **Foreign Key**: Property.host_id → User.user_id

### 2. User ↔ Booking (One-to-Many)
- **Relationship**: "makes" / "made by"
- **Description**: One user (guest) can make multiple bookings, but each booking belongs to one user
- **Cardinality**: 1:N
- **Foreign Key**: Booking.user_id → User.user_id

### 3. Property ↔ Booking (One-to-Many)
- **Relationship**: "receives" / "for"
- **Description**: One property can have multiple bookings, but each booking is for one property
- **Cardinality**: 1:N
- **Foreign Key**: Booking.property_id → Property.property_id

### 4. Booking ↔ Payment (One-to-One)
- **Relationship**: "has" / "belongs to"
- **Description**: Each booking has one payment, and each payment belongs to one booking
- **Cardinality**: 1:1
- **Foreign Key**: Payment.booking_id → Booking.booking_id

### 5. User ↔ Review (One-to-Many)
- **Relationship**: "writes" / "written by"
- **Description**: One user can write multiple reviews, but each review is written by one user
- **Cardinality**: 1:N
- **Foreign Key**: Review.user_id → User.user_id

### 6. Property ↔ Review (One-to-Many)
- **Relationship**: "receives" / "for"
- **Description**: One property can receive multiple reviews, but each review is for one property
- **Cardinality**: 1:N
- **Foreign Key**: Review.property_id → Property.property_id

### 7. User ↔ Message (Sender) (One-to-Many)
- **Relationship**: "sends" / "sent by"
- **Description**: One user can send multiple messages, but each message has one sender
- **Cardinality**: 1:N
- **Foreign Key**: Message.sender_id → User.user_id

### 8. User ↔ Message (Recipient) (One-to-Many)
- **Relationship**: "receives" / "received by"
- **Description**: One user can receive multiple messages, but each message has one recipient
- **Cardinality**: 1:N
- **Foreign Key**: Message.recipient_id → User.user_id

## ERD Design Requirements

### Visual Elements
1. **Entities**: Represented as rectangles with entity names
2. **Attributes**: Listed within or connected to entity rectangles
3. **Primary Keys**: Underlined or specially marked
4. **Foreign Keys**: Clearly indicated with appropriate notation
5. **Relationships**: Represented as diamonds or lines with relationship labels
6. **Cardinality**: Shown using crow's foot notation or similar standard

## 🖼️ ER Diagram

The full Entity-Relationship Diagram is available in this folder as:

- `airbnb_erd.png`

It visually represents all entities, attributes, and relationships (with cardinality).


### Key Constraints to Highlight
1. **Primary Keys**: All entities have UUID primary keys
2. **Foreign Key Relationships**: All referential integrity constraints
3. **Unique Constraints**: User.email uniqueness
4. **Check Constraints**: Review.rating range (1-5)
5. **Enum Constraints**: User.role, Booking.status, Payment.payment_method
6. **Null Constraints**: Required vs optional fields

### Normalization Level
The ERD should reflect **Third Normal Form (3NF)**:
- **1NF**: All attributes contain atomic values
- **2NF**: No partial dependencies on composite keys
- **3NF**: No transitive dependencies

## Tools and Standards
- **Recommended Tool**: Draw.io (or equivalent professional diagramming tool)
- **Notation**: Use standard ER diagram notation (Chen or Crow's Foot)
- **Layout**: Clear, organized layout with minimal crossing lines
- **Labeling**: All entities, attributes, and relationships clearly labeled
- **Legend**: Include legend explaining symbols and notation used

## Deliverables
1. **ERD Image**: High-resolution diagram in PNG/JPEG format
2. **Source File**: Editable source file (.drawio or equivalent)
3. **Documentation**: This requirements document explaining design decisions

## Validation Checklist
- [ ] All 6 entities represented with complete attributes
- [ ] All 8 relationships properly defined with correct cardinality
- [ ] Primary keys clearly identified
- [ ] Foreign keys properly connected
- [ ] Constraints and data types documented
- [ ] ERD follows standard notation conventions
- [ ] Diagram is clear, readable, and professionally formatted
- [ ] All business rules from specification are reflected in the design