-- Performance Optimization for Complex Queries
-- ALX AirBnB Database Advanced Script
-- This file contains initial complex query and optimized versions

-- ===============================================
-- INITIAL COMPLEX QUERY (UNOPTIMIZED)
-- ===============================================

-- Query to retrieve all bookings with user details, property details, and payment details
-- This is the initial unoptimized version that will be analyzed for performance

SELECT 
    -- Booking details
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price as booking_total_price,
    b.status as booking_status,
    b.created_at as booking_created_at,
    
    -- User details
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role,
    u.created_at as user_created_at,
    
    -- Property details
    p.property_id,
    p.host_id,
    p.name as property_name,
    p.description as property_description,
    p.location,
    p.price_per_night,
    p.created_at as property_created_at,
    
    -- Host details
    h.first_name as host_first_name,
    h.last_name as host_last_name,
    h.email as host_email,
    
    -- Payment details
    pay.payment_id,
    pay.amount as payment_amount,
    pay.payment_date,
    pay.payment_method
FROM Booking b
LEFT JOIN User u ON b.user_id = u.user_id
LEFT JOIN Property p ON b.property_id = p.property_id
LEFT JOIN User h ON p.host_id = h.user_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC;

-- ===============================================
-- PERFORMANCE ANALYSIS - INITIAL QUERY
-- ===============================================

-- Analyze the initial query performance
EXPLAIN ANALYZE
SELECT 
    -- Booking details
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price as booking_total_price,
    b.status as booking_status,
    b.created_at as booking_created_at,
    
    -- User details
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role,
    u.created_at as user_created_at,
    
    -- Property details
    p.property_id,
    p.host_id,
    p.name as property_name,
    p.description as property_description,
    p.location,
    p.price_per_night,
    p.created_at as property_created_at,
    
    -- Host details
    h.first_name as host_first_name,
    h.last_name as host_last_name,
    h.email as host_email,
    
    -- Payment details
    pay.payment_id,
    pay.amount as payment_amount,
    pay.payment_date,
    pay.payment_method
FROM Booking b
LEFT JOIN User u ON b.user_id = u.user_id
LEFT JOIN Property p ON b.property_id = p.property_id
LEFT JOIN User h ON p.host_id = h.user_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC;

-- ===============================================
-- OPTIMIZED QUERY VERSION 1 - REDUCE COLUMNS
-- ===============================================

-- Optimized version 1: Only select necessary columns
EXPLAIN ANALYZE
SELECT 
    -- Essential booking details only
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    
    -- Essential user details only
    u.first_name,
    u.last_name,
    u.email,
    
    -- Essential property details only
    p.name as property_name,
    p.location,
    p.price_per_night,
    
    -- Essential host details only
    h.first_name as host_first_name,
    h.last_name as host_last_name,
    
    -- Essential payment details only
    pay.amount as payment_amount,
    pay.payment_method
FROM Booking b
LEFT JOIN User u ON b.user_id = u.user_id
LEFT JOIN Property p ON b.property_id = p.property_id
LEFT JOIN User h ON p.host_id = h.user_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC;

-- ===============================================
-- OPTIMIZED QUERY VERSION 2 - WITH PAGINATION
-- ===============================================

-- Optimized version 2: Add pagination to limit results
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name,
    u.last_name,
    u.email,
    p.name as property_name,
    p.location,
    p.price_per_night,
    h.first_name as host_first_name,
    h.last_name as host_last_name,
    pay.amount as payment_amount,
    pay.payment_method
FROM Booking b
LEFT JOIN User u ON b.user_id = u.user_id
LEFT JOIN Property p ON b.property_id = p.property_id
LEFT JOIN User h ON p.host_id = h.user_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC
LIMIT 100 OFFSET 0;

-- ===============================================
-- OPTIMIZED QUERY VERSION 3 - WITH FILTERING
-- ===============================================

-- Optimized version 3: Add WHERE clause for common filtering
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name,
    u.last_name,
    u.email,
    p.name as property_name,
    p.location,
    p.price_per_night,
    h.first_name as host_first_name,
    h.last_name as host_last_name,
    pay.amount as payment_amount,
    pay.payment_method
FROM Booking b
LEFT JOIN User u ON b.user_id = u.user_id
LEFT JOIN Property p ON b.property_id = p.property_id
LEFT JOIN User h ON p.host_id = h.user_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE b.created_at >= CURRENT_DATE - INTERVAL '1 year'
  AND b.status IN ('confirmed', 'completed')
ORDER BY b.created_at DESC
LIMIT 100;

-- ===============================================
-- OPTIMIZED QUERY VERSION 4 - INNER JOINS WHERE APPROPRIATE
-- ===============================================

-- Optimized version 4: Use INNER JOINs where data is always expected
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name,
    u.last_name,
    u.email,
    p.name as property_name,
    p.location,
    p.price_per_night,
    h.first_name as host_first_name,
    h.last_name as host_last_name,
    pay.amount as payment_amount,
    pay.payment_method
FROM Booking b
INNER JOIN User u ON b.user_id = u.user_id  -- Always expect user data
INNER JOIN Property p ON b.property_id = p.property_id  -- Always expect property data
INNER JOIN User h ON p.host_id = h.user_id  -- Always expect host data
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id  -- Payment might not exist yet
WHERE b.created_at >= CURRENT_DATE - INTERVAL '1 year'
  AND b.status IN ('confirmed', 'completed')
ORDER BY b.created_at DESC
LIMIT 100;

-- ===============================================
-- OPTIMIZED QUERY VERSION 5 - WITH SUBQUERIES FOR COMPLEX LOGIC
-- ===============================================

-- Optimized version 5: Use subquery for payment aggregation
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name,
    u.last_name,
    u.email,
    p.name as property_name,
    p.location,
    p.price_per_night,
    h.first_name as host_first_name,
    h.last_name as host_last_name,
    COALESCE(pay_summary.total_paid, 0) as total_paid,
    pay_summary.payment_count
FROM Booking b
INNER JOIN User u ON b.user_id = u.user_id
INNER JOIN Property p ON b.property_id = p.property_id
INNER JOIN User h ON p.host_id = h.user_id
LEFT JOIN (
    SELECT 
        booking_id,
        SUM(amount) as total_paid,
        COUNT(*) as payment_count
    FROM Payment
    GROUP BY booking_id
) pay_summary ON b.booking_id = pay_summary.booking_id
WHERE b.created_at >= CURRENT_DATE - INTERVAL '1 year'
  AND b.status IN ('confirmed', 'completed')
ORDER BY b.created_at DESC
LIMIT 100;

-- ===============================================
-- OPTIMIZED QUERY VERSION 6 - FINAL OPTIMIZED VERSION
-- ===============================================

-- Final optimized version with all optimizations combined
EXPLAIN ANALYZE
WITH recent_bookings AS (
    SELECT 
        booking_id,
        user_id,
        property_id,
        start_date,
        end_date,
        total_price,
        status,
        created_at
    FROM Booking
    WHERE created_at >= CURRENT_DATE - INTERVAL '1 year'
      AND status IN ('confirmed', 'completed')
),
payment_summary AS (
    SELECT 
        booking_id,
        SUM(amount) as total_paid,
        COUNT(*) as payment_count,
        STRING_AGG(payment_method, ', ') as payment_methods
    FROM Payment
    WHERE booking_id IN (SELECT booking_id FROM recent_bookings)
    GROUP BY booking_id
)
SELECT 
    rb.booking_id,
    rb.start_date,
    rb.end_date,
    rb.total_price,
    rb.status,
    u.first_name,
    u.last_name,
    u.email,
    p.name as property_name,
    p.location,
    p.price_per_night,
    h.first_name as host_first_name,
    h.last_name as host_last_name,
    COALESCE(ps.total_paid, 0) as total_paid,
    COALESCE(ps.payment_count, 0) as payment_count,
    ps.payment_methods
FROM recent_bookings rb
INNER JOIN User u ON rb.user_id = u.user_id
INNER JOIN Property p ON rb.property_id = p.property_id
INNER JOIN User h ON p.host_id = h.user_id
LEFT JOIN payment_summary ps ON rb.booking_id = ps.booking_id
ORDER BY rb.created_at DESC
LIMIT 100;

-- ===============================================
-- ADDITIONAL PERFORMANCE TESTING QUERIES
-- ===============================================

-- Test specific use cases with targeted queries

-- Query 1: Bookings for a specific user
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    p.name as property_name,
    p.location,
    SUM(pay.amount) as total_paid
FROM Booking b
INNER JOIN Property p ON b.property_id = p.property_id
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE b.user_id = 12345
GROUP BY b.booking_id, b.start_date, b.end_date, b.total_price, b.status, p.name, p.location
ORDER BY b.created_at DESC;

-- Query 2: Properties with recent bookings
EXPLAIN ANALYZE
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.price_per_night,
    h.first_name as host_name,
    COUNT(b.booking_id) as recent_bookings,
    AVG(b.total_price) as avg_booking_price
FROM Property p
INNER JOIN User h ON p.host_id = h.user_id
LEFT JOIN Booking b ON p.property_id = b.property_id 
    AND b.created_at >= CURRENT_DATE - INTERVAL '3 months'
GROUP BY p.property_id, p.name, p.location, p.price_per_night, h.first_name
HAVING COUNT(b.booking_id) > 0
ORDER BY recent_bookings DESC
LIMIT 50;

-- Query 3: Payment summary by method
EXPLAIN ANALYZE
SELECT 
    pay.payment_method,
    COUNT(*) as payment_count,
    SUM(pay.amount) as total_amount,
    AVG(pay.amount) as avg_amount
FROM Payment pay
INNER JOIN Booking b ON pay.booking_id = b.booking_id
WHERE pay.payment_date >= CURRENT_DATE - INTERVAL '6 months'
GROUP BY pay.payment_method
ORDER BY total_amount DESC;

-- ===============================================
-- INDEX RECOMMENDATIONS FOR OPTIMIZATION
-- ===============================================

-- Ensure these indexes exist for optimal performance:
/*
CREATE INDEX IF NOT EXISTS idx_booking_created_at ON Booking(created_at);
CREATE INDEX IF NOT EXISTS idx_booking_status ON Booking(status);
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON Booking(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON Booking(property_id);
CREATE INDEX IF NOT EXISTS idx_payment_booking_id ON Payment(booking_id);
CREATE INDEX IF NOT EXISTS idx_payment_payment_date ON Payment(payment_date);
CREATE INDEX IF NOT EXISTS idx_property_host_id ON Property(host_id);
CREATE INDEX IF NOT EXISTS idx_booking_created_status ON Booking(created_at, status);
*/