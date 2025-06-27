-- =====================================================
-- AirBnB Database Schema Definition (PostgreSQL Version)
-- =====================================================
-- Project: ALX AirBnB Database
-- File: schema.sql
-- Description: Normalized schema with constraints, triggers, and indexes
-- Compatible with PostgreSQL 12+
-- =====================================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =====================================================
-- 1. USER TABLE
-- =====================================================
CREATE TABLE "User" (
    user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(20) NOT NULL CHECK (role IN ('guest', 'host', 'admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CHECK (email LIKE '%@%'),
    CHECK (phone_number IS NULL OR phone_number ~ '^[+]?[0-9]{10,15}$'),
    CHECK (CHAR_LENGTH(first_name) >= 1 AND CHAR_LENGTH(last_name) >= 1)
);

-- =====================================================
-- 2. LOCATION TABLE (Optional Normalization)
-- =====================================================
CREATE TABLE Location (
    location_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- 3. PROPERTY TABLE
-- =====================================================
CREATE TABLE Property (
    property_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    host_id UUID NOT NULL,
    location_id UUID,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (host_id) REFERENCES "User"(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (location_id) REFERENCES Location(location_id) ON DELETE SET NULL,

    CHECK (price_per_night > 0),
    CHECK (CHAR_LENGTH(name) >= 3),
    CHECK (CHAR_LENGTH(description) >= 10)
);

-- Trigger for auto-updating updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_property_timestamp
BEFORE UPDATE ON Property
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- =====================================================
-- 4. BOOKING TABLE
-- =====================================================
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('pending', 'confirmed', 'canceled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES "User"(user_id) ON DELETE CASCADE ON UPDATE CASCADE,

    CHECK (end_date > start_date),
    CHECK (total_price > 0),
    CHECK (start_date >= CURRENT_DATE)
);

-- Prevent overlapping bookings for the same property (simplified logic)
-- This logic can also be enforced via triggers or in the app layer.

-- =====================================================
-- 5. PAYMENT TABLE
-- =====================================================
CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('credit_card', 'paypal', 'stripe')),

    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE ON UPDATE CASCADE,

    CHECK (amount > 0)
);

-- =====================================================
-- 6. REVIEW TABLE
-- =====================================================
CREATE TABLE Review (
    review_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES "User"(user_id) ON DELETE CASCADE ON UPDATE CASCADE,

    UNIQUE (user_id, property_id),
    CHECK (CHAR_LENGTH(comment) >= 10)
);

-- =====================================================
-- 7. MESSAGE TABLE
-- =====================================================
CREATE TABLE Message (
    message_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (sender_id) REFERENCES "User"(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES "User"(user_id) ON DELETE CASCADE ON UPDATE CASCADE,

    CHECK (CHAR_LENGTH(message_body) >= 1),
    CHECK (sender_id != recipient_id)
);

-- =====================================================
-- INDEXES FOR PERFORMANCE
-- =====================================================

-- User
CREATE INDEX idx_user_email ON "User"(email);
CREATE INDEX idx_user_role ON "User"(role);
CREATE INDEX idx_user_created_at ON "User"(created_at);

-- Property
CREATE INDEX idx_property_host_id ON Property(host_id);
CREATE INDEX idx_property_location_id ON Property(location_id);
CREATE INDEX idx_property_price ON Property(price_per_night);
CREATE INDEX idx_property_created_at ON Property(created_at);

-- Booking
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_status ON Booking(status);
CREATE INDEX idx_booking_created_at ON Booking(created_at);
CREATE INDEX idx_booking_user_status ON Booking(user_id, status);
CREATE INDEX idx_booking_property_dates ON Booking(property_id, start_date, end_date);

-- Payment
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);
CREATE INDEX idx_payment_method ON Payment(payment_method);
CREATE INDEX idx_payment_date ON Payment(payment_date);

-- Review
CREATE INDEX idx_review_property_id ON Review(property_id);
CREATE INDEX idx_review_user_id ON Review(user_id);
CREATE INDEX idx_review_rating ON Review(rating);
CREATE INDEX idx_review_created_at ON Review(created_at);
CREATE INDEX idx_review_property_rating ON Review(property_id, rating);

-- Message
CREATE INDEX idx_message_sender_id ON Message(sender_id);
CREATE INDEX idx_message_recipient_id ON Message(recipient_id);
CREATE INDEX idx_message_sent_at ON Message(sent_at);
CREATE INDEX idx_message_conversation ON Message(sender_id, recipient_id, sent_at);

-- =====================================================
-- ✅ Schema creation complete. Ready for Task 4: Seeding.
-- =====================================================
