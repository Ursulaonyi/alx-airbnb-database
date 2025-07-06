-- Task 3: Implement Indexes for Optimization
-- ALX AirBnB Database Advanced Script
-- This file contains CREATE INDEX statements for performance optimization

-- ===============================================
-- ANALYSIS OF HIGH-USAGE COLUMNS
-- ===============================================

-- Based on common query patterns in AirBnB applications:
-- 1. User table: email (login), role (filtering), created_at (sorting)
-- 2. Booking table: user_id (joins), property_id (joins), status (filtering), 
--    start_date/end_date (range queries), created_at (sorting)
-- 3. Property table: host_id (joins), location (filtering), price_per_night (sorting),
--    created_at (sorting)
-- 4. Review table: property_id (joins), user_id (joins), rating (filtering)
-- 5. Payment table: booking_id (joins), payment_date (sorting), amount (calculations)
-- 6. Message table: sender_id/receiver_id (joins), sent_at (sorting)

-- ===============================================
-- USER TABLE INDEXES
-- ===============================================

-- Index on email for login queries (UNIQUE for data integrity)
CREATE UNIQUE INDEX idx_user_email ON User(email);

-- Index on role for filtering users by type (guest, host, admin)
CREATE INDEX idx_user_role ON User(role);

-- Index on created_at for user registration timeline queries
CREATE INDEX idx_user_created_at ON User(created_at);

-- Composite index for user search and filtering
CREATE INDEX idx_user_role_created ON User(role, created_at);

-- ===============================================
-- BOOKING TABLE INDEXES
-- ===============================================

-- Index on user_id for JOIN operations with User table
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- Index on property_id for JOIN operations with Property table
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- Index on status for filtering bookings by status
CREATE INDEX idx_booking_status ON Booking(status);

-- Index on created_at for sorting bookings chronologically
CREATE INDEX idx_booking_created_at ON Booking(created_at);

-- Composite index for date range queries (very common in booking systems)
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);

-- Composite index for user booking history queries
CREATE INDEX idx_booking_user_created ON Booking(user_id, created_at);

-- Composite index for property booking queries
CREATE INDEX idx_booking_property_status ON Booking(property_id, status);

-- Composite index for date-based availability queries
CREATE INDEX idx_booking_property_dates ON Booking(property_id, start_date, end_date);

-- Index on total_price for revenue analysis queries
CREATE INDEX idx_booking_total_price ON Booking(total_price);

-- ===============================================
-- PROPERTY TABLE INDEXES
-- ===============================================

-- Index on host_id for JOIN operations with User table
CREATE INDEX idx_property_host_id ON Property(host_id);

-- Index on location for filtering properties by location
CREATE INDEX idx_property_location ON Property(location);

-- Index on price_per_night for price-based filtering and sorting
CREATE INDEX idx_property_price_per_night ON Property(price_per_night);

-- Index on created_at for property listing timeline
CREATE INDEX idx_property_created_at ON Property(created_at);

-- Composite index for location-based price queries
CREATE INDEX idx_property_location_price ON Property(location, price_per_night);

-- Composite index for host property management
CREATE INDEX idx_property_host_created ON Property(host_id, created_at);

-- ===============================================
-- REVIEW TABLE INDEXES
-- ===============================================

-- Index on property_id for JOIN operations with Property table
CREATE INDEX idx_review_property_id ON Review(property_id);

-- Index on user_id for JOIN operations with User table
CREATE INDEX idx_review_user_id ON Review(user_id);

-- Index on rating for filtering high-rated properties
CREATE INDEX idx_review_rating ON Review(rating);

-- Index on created_at for review timeline queries
CREATE INDEX idx_review_created_at ON Review(created_at);

-- Composite index for property review analysis
CREATE INDEX idx_review_property_rating ON Review(property_id, rating);

-- Composite index for user review history
CREATE INDEX idx_review_user_created ON Review(user_id, created_at);

-- ===============================================
-- PAYMENT TABLE INDEXES
-- ===============================================

-- Index on booking_id for JOIN operations with Booking table
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);

-- Index on payment_date for temporal analysis
CREATE INDEX idx_payment_payment_date ON Payment(payment_date);

-- Index on amount for financial analysis
CREATE INDEX idx_payment_amount ON Payment(amount);

-- Index on payment_method for payment analysis
CREATE INDEX idx_payment_method ON Payment(payment_method);

-- Composite index for payment timeline analysis
CREATE INDEX idx_payment_date_amount ON Payment(payment_date, amount);

-- ===============================================
-- MESSAGE TABLE INDEXES
-- ===============================================

-- Index on sender_id for JOIN operations with User table
CREATE INDEX idx_message_sender_id ON Message(sender_id);

-- Index on receiver_id for JOIN operations with User table
CREATE INDEX idx_message_receiver_id ON Message(receiver_id);

-- Index on sent_at for message timeline queries
CREATE INDEX idx_message_sent_at ON Message(sent_at);

-- Composite index for conversation queries
CREATE INDEX idx_message_conversation ON Message(sender_id, receiver_id, sent_at);

-- ===============================================
-- SPECIALIZED INDEXES FOR COMPLEX QUERIES
-- ===============================================

-- Partial index for active bookings only (saves space)
CREATE INDEX idx_booking_active ON Booking(property_id, start_date, end_date) 
WHERE status IN ('confirmed', 'pending');

-- Partial index for recent bookings (last 12 months)
CREATE INDEX idx_booking_recent ON Booking(user_id, created_at) 
WHERE created_at >= CURRENT_DATE - INTERVAL '12 months';

-- Partial index for high-value bookings
CREATE INDEX idx_booking_high_value ON Booking(user_id, total_price) 
WHERE total_price > 1000;

-- Function-based index for case-insensitive location searches
CREATE INDEX idx_property_location_lower ON Property(LOWER(location));

-- Function-based index for email searches (case-insensitive)
CREATE INDEX idx_user_email_lower ON User(LOWER(email));

-- ===============================================
-- INDEXES FOR FULL-TEXT SEARCH (if supported)
-- ===============================================

-- Full-text search index for property names and descriptions
-- Note: Syntax may vary by database system
-- CREATE INDEX idx_property_fulltext ON Property 
-- USING gin(to_tsvector('english', name || ' ' || description));

-- ===============================================
-- PERFORMANCE MONITORING QUERIES
-- ===============================================

-- Query to check index usage statistics
-- SELECT 
--     schemaname,
--     tablename,
--     attname,
--     n_distinct,
--     correlation
-- FROM pg_stats 
-- WHERE tablename IN ('User', 'Booking', 'Property', 'Review', 'Payment', 'Message');

-- Query to monitor index size and usage
-- SELECT 
--     indexname,
--     idx_scan,
--     idx_tup_read,
--     idx_tup_fetch,
--     pg_size_pretty(pg_relation_size(indexrelid)) as size
-- FROM pg_stat_user_indexes 
-- WHERE schemaname = 'public'
-- ORDER BY idx_scan DESC;

-- ===============================================
-- MAINTENANCE COMMANDS
-- ===============================================

-- Analyze tables after creating indexes to update statistics
ANALYZE User;
ANALYZE Booking;
ANALYZE Property;
ANALYZE Review;
ANALYZE Payment;
ANALYZE Message;

-- ===============================================
-- INDEX CLEANUP (if needed)
-- ===============================================

-- Commands to drop indexes if they prove ineffective
-- DROP INDEX IF EXISTS idx_index_name;

-- ===============================================
-- NOTES
-- ===============================================

-- 1. Monitor index usage regularly using database statistics
-- 2. Drop unused indexes to save storage space and improve write performance
-- 3. Consider composite indexes for multi-column WHERE clauses
-- 4. Use partial indexes for frequently filtered subsets
-- 5. Rebuild indexes periodically for optimal performance
-- 6. Test query performance before and after index creation
-- 7. Consider the trade-off between read and write performance