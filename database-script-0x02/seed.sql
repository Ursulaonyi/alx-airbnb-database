-- =====================================================
-- AirBnB Database Sample Data Seeding Script
-- =====================================================
-- Project: ALX AirBnB Database
-- File: seed.sql
-- Description: Comprehensive sample data for testing and development
-- Version: 1.0
-- =====================================================

-- Clear existing data (if any) - Uncomment if needed for fresh seeding
-- SET FOREIGN_KEY_CHECKS = 0;
-- TRUNCATE TABLE Message;
-- TRUNCATE TABLE Review;
-- TRUNCATE TABLE Payment;
-- TRUNCATE TABLE Booking;
-- TRUNCATE TABLE Property;
-- TRUNCATE TABLE User;
-- SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================
-- 1. SEED USER DATA
-- =====================================================
-- Insert diverse users with different roles and realistic information

-- ============================================
-- Simplified AirBnB Clone Seed Data (3 Rows Each)
-- ============================================

-- ========== USERS ==========
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
('u1', 'Sarah', 'Johnson', 'sarah@email.com', 'hashed_pw', '1234567890', 'host', NOW()),
('u2', 'James', 'Wilson', 'james@email.com', 'hashed_pw', '0987654321', 'guest', NOW()),
('u3', 'Rachel', 'Martinez', 'rachel@email.com', 'hashed_pw', '1122334455', 'host', NOW());

-- ========== PROPERTIES ==========
INSERT INTO Property (property_id, host_id, name, description, location, price_per_night, created_at, updated_at) VALUES
('p1', 'u1', 'Cozy Studio', 'Nice place in NYC', 'New York, USA', 120.00, NOW(), NOW()),
('p2', 'u3', 'Desert Villa', 'Modern villa in the desert', 'Phoenix, USA', 200.00, NOW(), NOW()),
('p3', 'u1', 'Mountain Cabin', 'Peaceful retreat in the mountains', 'Denver, USA', 150.00, NOW(), NOW());

-- ========== BOOKINGS ==========
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
('b1', 'p1', 'u2', '2024-07-01', '2024-07-03', 240.00, 'confirmed', NOW()),
('b2', 'p2', 'u2', '2024-08-10', '2024-08-13', 600.00, 'pending', NOW()),
('b3', 'p3', 'u2', '2024-09-05', '2024-09-08', 450.00, 'canceled', NOW());

-- ========== PAYMENTS ==========
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
('pay1', 'b1', 240.00, NOW(), 'credit_card'),
('pay2', 'b2', 600.00, NOW(), 'paypal'),
('pay3', 'b3', 450.00, NOW(), 'stripe');

-- ========== REVIEWS ==========
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
('r1', 'p1', 'u2', 5, 'Great place, very clean!', NOW()),
('r2', 'p2', 'u2', 4, 'Nice stay but a bit hot during the day.', NOW()),
('r3', 'p3', 'u2', 3, 'Cozy but a bit far from town.', NOW());

-- ========== MESSAGES ==========
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
('m1', 'u2', 'u1', 'Hi Sarah, is your studio available for July?', NOW()),
('m2', 'u2', 'u3', 'Hey Rachel, does the villa have a pool?', NOW()),
('m3', 'u1', 'u2', 'Yes, my studio is open. Let me know your dates.', NOW());

-- ✅ Done seeding all tables!

-- Run the following command to view the data:
-- SELECT * FROM messages;