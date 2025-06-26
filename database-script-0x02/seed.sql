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

INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
-- Hosts
('550e8400-e29b-41d4-a716-446655440001', 'Sarah', 'Johnson', 'sarah.johnson@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewFBJfUK5KwjxBDm', '+1-555-0101', 'host', '2023-01-15 10:30:00'),
('550e8400-e29b-41d4-a716-446655440002', 'Michael', 'Chen', 'michael.chen@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewFBJfUK5KwjxBDm', '+1-555-0102', 'host', '2023-02-20 14:15:00'),
('550e8400-e29b-41d4-a716-446655440003', 'Emily', 'Rodriguez', 'emily.rodriguez@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewFBJfUK5KwjxBDm', '+1-555-0103', 'host', '2023-03-10 09:45:00'),
('550e8400-e29b-41d4-a716-446655440004', 'David', 'Thompson', 'david.thompson@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewFBJfUK5KwjxBDm', '+1-555-0104', 'host', '2023-04-05 11:20:00'),
('550e8400-e29b-41d4-a716-446655440005', 'Maria', 'Garcia', 'maria.garcia@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewFBJfUK5KwjxBDm', '+1-555-0105', 'host', '2023-05-12 16:00:00'),

-- Guests
('550e8400-e29b-41d4-a716-446655440006', 'James', 'Wilson', 'james.wilson@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewFBJfUK5KwjxBDm', '+1-555-0106', 'guest', '2023-01-25 08:30:00'),
('550e8400-e29b-41d4-a716-446655440007', 'Lisa', 'Anderson', 'lisa.anderson@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewFBJfUK5KwjxBDm', '+1-555-0107', 'guest', '2023-02-14 12:45:00'),
('550e8400-e29b-41d4-a716-446655440008', 'Robert', 'Lee', 'robert.lee@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewFBJfUK5KwjxBDm', '+1-555-0108', 'guest', '2023-03-18 15:20:00'),
('550e8400-e29b-41d4-a716-446655440009', 'Jennifer', 'Taylor', 'jennifer.taylor@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewFBJfUK5KwjxBDm', '+1-555-0109', 'guest', '2023-04-22 10:15:00'),
('550e8400-e29b-41d4-a716-446655440010', 'Christopher', 'Brown', 'christopher.brown@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewFBJfUK5KwjxBDm', '+1-555-0110', 'guest', '2023-05-30 13:50:00'),
('550e8400-e29b-41d4-a716-446655440011', 'Amanda', 'Davis', 'amanda.davis@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewFBJfUK5KwjxBDm', '+1-555-0111', 'guest', '2023-06-15 17:30:00'),
('550e8400-e29b-41d4-a716-446655440012', 'Kevin', 'Miller', 'kevin.miller@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewFBJfUK5KwjxBDm', '+1-555-0112', 'guest', '2023-07-08 11:45:00'),

-- Mixed role users (can be both guest and host)
('550e8400-e29b-41d4-a716-446655440013', 'Rachel', 'Martinez', 'rachel.martinez@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewFBJfUK5KwjxBDm', '+1-555-0113', 'host', '2023-08-12 14:20:00'),
('550e8400-e29b-41d4-a716-446655440014', 'Daniel', 'White', 'daniel.white@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewFBJfUK5KwjxBDm', '+1-555-0114', 'guest', '2023-09-05 09:30:00'),

-- Admin users
('550e8400-e29b-41d4-a716-446655440015', 'Admin', 'Super', 'admin@airbnb.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewFBJfUK5KwjxBDm', '+1-555-9999', 'admin', '2023-01-01 00:00:00'),
('550e8400-e29b-41d4-a716-446655440016', 'Support', 'Team', 'support@airbnb.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/lewFBJfUK5KwjxBDm', '+1-555-9998', 'admin', '2023-01-01 00:00:00');

-- =====================================================
-- 2. SEED PROPERTY DATA
-- =====================================================
-- Insert diverse properties with varying types, locations, and prices

INSERT INTO Property (property_id, host_id, name, description, location, price_per_night, created_at, updated_at) VALUES
-- Sarah Johnson's properties
('550e8400-e29b-41d4-a716-446655440101', '550e8400-e29b-41d4-a716-446655440001', 'Cozy Downtown Studio', 'A charming studio apartment in the heart of downtown Manhattan. Perfect for business travelers and couples. Features modern amenities, high-speed WiFi, and walking distance to major attractions.', 'New York, NY, USA', 185.00, '2023-01-20 11:00:00', '2024-01-15 14:30:00'),
('550e8400-e29b-41d4-a716-446655440102', '550e8400-e29b-41d4-a716-446655440001', 'Brooklyn Loft Experience', 'Spacious industrial loft in trendy Brooklyn neighborhood. Exposed brick walls, high ceilings, and unique character. Great for groups and creative professionals.', 'Brooklyn, NY, USA', 220.00, '2023-02-10 13:45:00', '2024-02-20 16:15:00'),

-- Michael Chen's properties
('550e8400-e29b-41d4-a716-446655440103', '550e8400-e29b-41d4-a716-446655440002', 'Beachfront Paradise', 'Stunning oceanfront condo with panoramic views of the Pacific. Private balcony, beach access, and resort-style amenities. Wake up to the sound of waves!', 'San Diego, CA, USA', 350.00, '2023-02-25 15:20:00', '2024-03-10 10:45:00'),
('550e8400-e29b-41d4-a716-446655440104', '550e8400-e29b-41d4-a716-446655440002', 'Modern Tech Hub Apartment', 'Contemporary apartment in the heart of Silicon Valley. Perfect for tech professionals with ergonomic workspace, high-speed internet, and proximity to major tech companies.', 'Palo Alto, CA, USA', 280.00, '2023-03-15 12:30:00', '2024-04-05 09:20:00'),

-- Emily Rodriguez's properties
('550e8400-e29b-41d4-a716-446655440105', '550e8400-e29b-41d4-a716-446655440003', 'Historic Charm Cottage', 'Beautifully restored Victorian cottage with original hardwood floors and period details. Garden patio and cozy fireplace create the perfect romantic getaway.', 'Charleston, SC, USA', 195.00, '2023-03-20 14:15:00', '2024-02-28 11:30:00'),
('550e8400-e29b-41d4-a716-446655440106', '550e8400-e29b-41d4-a716-446655440003', 'Luxury Penthouse Suite', 'Elegant penthouse with city skyline views, private rooftop terrace, and premium finishes throughout. Perfect for special occasions and luxury travelers.', 'Miami, FL, USA', 450.00, '2023-04-10 16:45:00', '2024-03-15 13:20:00'),

-- David Thompson's properties
('550e8400-e29b-41d4-a716-446655440107', '550e8400-e29b-41d4-a716-446655440004', 'Mountain Cabin Retreat', 'Rustic log cabin nestled in the Rocky Mountains. Fireplace, hot tub, and hiking trails nearby. Perfect for nature lovers and outdoor enthusiasts seeking tranquility.', 'Aspen, CO, USA', 275.00, '2023-04-15 10:30:00', '2024-01-20 12:45:00'),
('550e8400-e29b-41d4-a716-446655440108', '550e8400-e29b-41d4-a716-446655440004', 'Urban Minimalist Loft', 'Sleek, modern loft with minimalist design and industrial touches. Located in trendy arts district with galleries, restaurants, and nightlife within walking distance.', 'Denver, CO, USA', 165.00, '2023-05-05 13:20:00', '2024-02-10 15:15:00'),

-- Maria Garcia's properties
('550e8400-e29b-41d4-a716-446655440109', '550e8400-e29b-41d4-a716-446655440005', 'Texas Ranch House', 'Authentic ranch-style home on sprawling property with horse stables and scenic views. Experience true Texas hospitality and wide-open spaces.', 'Austin, TX, USA', 240.00, '2023-05-20 11:45:00', '2024-03-05 14:30:00'),
('550e8400-e29b-41d4-a716-446655440110', '550e8400-e29b-41d4-a716-446655440005', 'Music City Bungalow', 'Classic Nashville bungalow just minutes from Broadway and the famous honky-tonks. Perfect for music lovers and nightlife enthusiasts.', 'Nashville, TN, USA', 210.00, '2023-06-10 14:30:00', '2024-01-25 16:00:00'),

-- Rachel Martinez's properties
('550e8400-e29b-41d4-a716-446655440111', '550e8400-e29b-41d4-a716-446655440013', 'Desert Oasis Villa', 'Luxurious desert villa with pool, spa, and mountain views. Modern architecture meets desert landscape for a unique Southwestern experience.', 'Phoenix, AZ, USA', 320.00, '2023-08-20 16:15:00', '2024-02-15 11:45:00'),
('550e8400-e29b-41d4-a716-446655440112', '550e8400-e29b-41d4-a716-446655440013', 'Pacific Northwest Escape', 'Cozy cabin surrounded by towering evergreens and pristine lakes. Perfect for hiking, fishing, and experiencing the natural beauty of the Pacific Northwest.', 'Seattle, WA, USA', 190.00, '2023-09-15 12:00:00', '2024-03-20 10:30:00');

-- =====================================================
-- 3. SEED BOOKING DATA
-- =====================================================
-- Insert realistic bookings with various statuses and date ranges

INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
-- Confirmed bookings (past and current)
('550e8400-e29b-41d4-a716-446655440201', '550e8400-e29b-41d4-a716-446655440101', '550e8400-e29b-41d4-a716-446655440006', '2024-01-15', '2024-01-18', 555.00, 'confirmed', '2024-01-10 14:30:00'),
('550e8400-e29b-41d4-a716-446655440202', '550e8400-e29b-41d4-a716-446655440103', '550e8400-e29b-41d4-a716-446655440007', '2024-02-10', '2024-02-15', 1750.00, 'confirmed', '2024-02-05 16:45:00'),
('550e8400-e29b-41d4-a716-446655440203', '550e8400-e29b-41d4-a716-446655440105', '550e8400-e29b-41d4-a716-446655440008', '2024-03-05', '2024-03-09', 780.00, 'confirmed', '2024-02-28 11:20:00'),
('550e8400-e29b-41d4-a716-446655440204', '550e8400-e29b-41d4-a716-446655440107', '550e8400-e29b-41d4-a716-446655440009', '2024-04-01', '2024-04-05', 1100.00, 'confirmed', '2024-03-25 13:15:00'),
('550e8400-e29b-41d4-a716-446655440205', '550e8400-e29b-41d4-a716-446655440109', '550e8400-e29b-41d4-a716-446655440010', '2024-04-20', '2024-04-25', 1200.00, 'confirmed', '2024-04-15 09:30:00'),

-- Future confirmed bookings
('550e8400-e29b-41d4-a716-446655440206', '550e8400-e29b-41d4-a716-446655440102', '550e8400-e29b-41d4-a716-446655440011', '2024-07-01', '2024-07-05', 880.00, 'confirmed', '2024-06-20 15:45:00'),
('550e8400-e29b-41d4-a716-446655440207', '550e8400-e29b-41d4-a716-446655440104', '550e8400-e29b-41d4-a716-446655440012', '2024-08-15', '2024-08-20', 1400.00, 'confirmed', '2024-07-30 12:20:00'),
('550e8400-e29b-41d4-a716-446655440208', '550e8400-e29b-41d4-a716-446655440106', '550e8400-e29b-41d4-a716-446655440014', '2024-09-10', '2024-09-14', 1800.00, 'confirmed', '2024-08-25 14:10:00'),

-- Pending bookings
('550e8400-e29b-41d4-a716-446655440209', '550e8400-e29b-41d4-a716-446655440108', '550e8400-e29b-41d4-a716-446655440006', '2024-10-05', '2024-10-08', 495.00, 'pending', '2024-09-30 16:30:00'),
('550e8400-e29b-41d4-a716-446655440210', '550e8400-e29b-41d4-a716-446655440110', '550e8400-e29b-41d4-a716-446655440007', '2024-11-15', '2024-11-18', 630.00, 'pending', '2024-10-15 10:45:00'),

-- Canceled bookings
('550e8400-e29b-41d4-a716-446655440211', '550e8400-e29b-41d4-a716-446655440111', '550e8400-e29b-41d4-a716-446655440008', '2024-06-01', '2024-06-05', 1280.00, 'canceled', '2024-05-20 13:20:00'),
('550e8400-e29b-41d4-a716-446655440212', '550e8400-e29b-41d4-a716-446655440112', '550e8400-e29b-41d4-a716-446655440009', '2024-07-20', '2024-07-24', 760.00, 'canceled', '2024-06-15 11:15:00'),

-- Multiple bookings by same users (repeat customers)
('550e8400-e29b-41d4-a716-446655440213', '550e8400-e29b-41d4-a716-446655440103', '550e8400-e29b-41d4-a716-446655440006', '2024-12-20', '2024-12-25', 1750.00, 'confirmed', '2024-11-15 14:45:00'),
('550e8400-e29b-41d4-a716-446655440214', '550e8400-e29b-41d4-a716-446655440105', '550e8400-e29b-41d4-a716-446655440007', '2025-01-10', '2025-01-15', 975.00, 'confirmed', '2024-12-01 16:20:00'),

-- Extended stays
('550e8400-e29b-41d4-a716-446655440215', '550e8400-e29b-41d4-a716-446655440104', '550e8400-e29b-41d4-a716-446655440010', '2025-02-01', '2025-02-28', 7840.00, 'pending', '2025-01-15 12:30:00');

-- =====================================================
-- 4. SEED PAYMENT DATA
-- =====================================================
-- Insert payment records for confirmed bookings

INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
-- Payments for confirmed bookings
('550e8400-e29b-41d4-a716-446655440301', '550e8400-e29b-41d4-a716-446655440201', 555.00, '2024-01-10 14:35:00', 'credit_card'),
('550e8400-e29b-41d4-a716-446655440302', '550e8400-e29b-41d4-a716-446655440202', 1750.00, '2024-02-05 16:50:00', 'stripe'),
('550e8400-e29b-41d4-a716-446655440303', '550e8400-e29b-41d4-a716-446655440203', 780.00, '2024-02-28 11:25:00', 'paypal'),
('550e8400-e29b-41d4-a716-446655440304', '550e8400-e29b-41d4-a716-446655440204', 1100.00, '2024-03-25 13:20:00', 'credit_card'),
('550e8400-e29b-41d4-a716-446655440305', '550e8400-e29b-41d4-a716-446655440205', 1200.00, '2024-04-15 09:35:00', 'stripe'),
('550e8400-e29b-41d4-a716-446655440306', '550e8400-e29b-41d4-a716-446655440206', 880.00, '2024-06-20 15:50:00', 'credit_card'),
('550e8400-e29b-41d4-a716-446655440307', '550e8400-e29b-41d4-a716-446655440207', 1400.00, '2024-07-30 12:25:00', 'paypal'),
('550e8400-e29b-41d4-a716-446655440308', '550e8400-e29b-41d4-a716-446655440208', 1800.00, '2024-08-25 14:15:00', 'stripe'),
('550e8400-e29b-41d4-a716-446655440309', '550e8400-e29b-41d4-a716-446655440213', 1750.00, '2024-11-15 14:50:00', 'credit_card'),
('550e8400-e29b-41d4-a716-446655440310', '550e8400-e29b-41d4-a716-446655440214', 975.00, '2024-12-01 16:25:00', 'paypal');

-- =====================================================
-- 5. SEED REVIEW DATA
-- =====================================================
-- Insert realistic reviews with varying ratings and detailed comments

INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
-- Reviews for completed stays
('550e8400-e29b-41d4-a716-446655440401', '550e8400-e29b-41d4-a716-446655440101', '550e8400-e29b-41d4-a716-446655440006', 5, 'Absolutely fantastic stay! The studio was immaculate and perfectly located. Sarah was an incredibly responsive host who provided excellent local recommendations. The apartment had everything we needed and more. Walking distance to Times Square and Central Park made our NYC trip unforgettable. Highly recommend!', '2024-01-20 10:15:00'),

('550e8400-e29b-41d4-a716-446655440402', '550e8400-e29b-41d4-a716-446655440103', '550e8400-e29b-41d4-a716-446655440007', 5, 'This beachfront condo exceeded all expectations! Waking up to ocean views every morning was magical. The property was exactly as described with luxurious amenities and pristine cleanliness. Michael was a wonderful host who went above and beyond to ensure our comfort. The private beach access was the perfect touch for our romantic getaway.', '2024-02-17 14:30:00'),

('550e8400-e29b-41d4-a716-446655440403', '550e8400-e29b-41d4-a716-446655440105', '550e8400-e29b-41d4-a716-446655440008', 4, 'Charming Victorian cottage with incredible historic character! Emily has done an amazing job preserving the original details while adding modern comforts. The garden patio was perfect for morning coffee. Only minor issue was the vintage plumbing occasionally being temperamental, but the charm more than made up for it.', '2024-03-12 16:45:00'),

('550e8400-e29b-41d4-a716-446655440404', '550e8400-e29b-41d4-a716-446655440107', '550e8400-e29b-41d4-a716-446655440009', 5, 'Mountain cabin retreat was exactly what we needed to disconnect and recharge! The hot tub under the stars was heavenly after long hikes. David provided detailed trail maps and local insights that made our adventure unforgettable. The cabin was cozy, clean, and had stunning views from every window. Will definitely return!', '2024-04-08 11:20:00'),

('550e8400-e29b-41d4-a716-446655440405', '550e8400-e29b-41d4-a716-446655440109', '550e8400-e29b-41d4-a716-446655440010', 4, 'Authentic Texas ranch experience! Maria was a gracious host who shared fascinating stories about the property history. The horses were gentle and beautiful, and the sunset views across the ranch were breathtaking. House was comfortable with a fully equipped kitchen. Only wish we could have stayed longer to fully experience ranch life.', '2024-04-28 13:35:00'),

('550e8400-e29b-41d4-a716-446655440406', '550e8400-e29b-41d4-a716-446655440102', '550e8400-e29b-41d4-a716-446655440011', 5, 'Brooklyn loft was absolutely perfect for our girls trip! The industrial design was stunning and the space was incredibly photogenic. Sarah provided excellent recommendations for local restaurants and nightlife. The loft comfortably accommodated our group of 6 with plenty of space to relax. The neighborhood had amazing character and energy.', '2024-07-08 12:15:00'),

('550e8400-e29b-41d4-a716-446655440407', '550e8400-e29b-41d4-a716-446655440104', '550e8400-e29b-41d4-a716-446655440012', 4, 'Great location for our tech conference! The apartment was modern and comfortable with excellent WiFi and a dedicated workspace. Michael clearly understands the needs of business travelers. Walking distance to major tech companies was incredibly convenient. The neighborhood had great dining options. Minor noise from street traffic at night, but overall excellent stay.', '2024-08-23 15:50:00'),

-- Some mixed reviews for authenticity
('550e8400-e29b-41d4-a716-446655440408', '550e8400-e29b-41d4-a716-446655440111', '550e8400-e29b-41d4-a716-446655440008', 3, 'Desert villa had beautiful architecture and the pool area was stunning. However, we encountered several maintenance issues during our stay including inconsistent air conditioning and pool equipment problems. Rachel was responsive to our concerns but it took time to resolve. The views were spectacular and location was peaceful, but expected better maintenance for the price point.', '2024-06-08 09:30:00'),

('550e8400-e29b-41d4-a716-446655440409', '550e8400-e29b-41d4-a716-446655440108', '550e8400-e29b-41d4-a716-446655440014', 4, 'Minimalist loft perfectly captured Denver urban vibe! Clean lines, great lighting, and excellent location in the arts district. David was helpful with local recommendations. The space was exactly as advertised. Only downside was limited storage space for longer stays and street parking could be challenging during events. Overall, a solid choice for exploring Denver.', '2024-09-18 14:20:00'),

-- Repeat customer reviews
('550e8400-e29b-41d4-a716-446655440410', '550e8400-e29b-41d4-a716-446655440103', '550e8400-e29b-41d4-a716-446655440006', 5, 'Second time staying at Michaels beachfront paradise and it was even better than remembered! Consistency in quality and service is remarkable. The property remains in pristine condition and Michael continues to be an exceptional host. This is our go-to place for San Diego visits. Already planning our third trip!', '2024-12-27 16:45:00');

-- =====================================================
-- 6. SEED MESSAGE DATA
-- =====================================================
-- Insert realistic messages between users (guests and hosts)

INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
('550e8400-e29b-41d4-a716-446655440501', '550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440001', 'Hi Sarah, I’m planning a trip to NYC in January. Is your studio available for those dates?', '2023-12-20 08:15:00'),
('550e8400-e29b-41d4-a716-446655440502', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', 'Hi James, yes the studio is available from Jan 15–18. Let me know if you have any questions!', '2023-12-20 09:00:00'),
('550e8400-e29b-41d4-a716-446655440503', '550e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440002', 'Hi Michael, does the beachfront condo have a washer and dryer?', '2024-02-01 14:30:00'),
('550e8400-e29b-41d4-a716-446655440504', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440007', 'Hi Lisa, yes, there is a washer/dryer unit in the condo!', '2024-02-01 15:05:00'),
('550e8400-e29b-41d4-a716-446655440505', '550e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440003', 'Hi Emily, is the cottage pet-friendly? I’d love to bring my dog.', '2024-03-01 10:45:00'),
('550e8400-e29b-41d4-a716-446655440506', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440008', 'Hi Robert! Yes, well-behaved pets are welcome with a small cleaning fee.', '2024-03-01 11:10:00'),
('550e8400-e29b-41d4-a716-446655440507', '550e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440004', 'Hi David, can you recommend any good hiking trails near the cabin?', '2024-03-28 18:00:00'),
('550e8400-e29b-41d4-a716-446655440508', '550e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440009', 'Absolutely! There’s a beautiful trail 2 miles from the cabin. I’ll send you the map.', '2024-03-28 18:30:00'),
('550e8400-e29b-41d4-a716-446655440509', '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440005', 'Hello Maria, is the ranch house kid-friendly? I’m traveling with my two children.', '2024-04-10 12:00:00'),
('550e8400-e29b-41d4-a716-446655440510', '550e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440010', 'Hi Christopher! Yes, families are very welcome. The ranch has space for kids to play safely.', '2024-04-10 12:45:00');

-- ✅ Done seeding all tables!
