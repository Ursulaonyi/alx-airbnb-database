-- Task 0: Complex Queries with Joins
-- ALX AirBnB Database Advanced Script

-- Query 1: INNER JOIN to retrieve all bookings and their respective users
-- This query combines booking data with user information for guests who made bookings
SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role
FROM 
    Booking b
INNER JOIN 
    User u ON b.user_id = u.user_id
ORDER BY 
    b.created_at DESC;

-- Query 2: LEFT JOIN to retrieve all properties and their reviews (including properties with no reviews)
-- This query shows all properties whether they have reviews or not
SELECT 
    p.property_id,
    p.host_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.price_per_night,
    p.created_at AS property_created_at,
    r.review_id,
    r.user_id AS reviewer_id,
    r.rating,
    r.comment,
    r.created_at AS review_created_at
FROM 
    Property p
LEFT JOIN 
    Review r ON p.property_id = r.property_id
ORDER BY 
    p.property_id, r.created_at DESC;

-- Query 3: FULL OUTER JOIN to retrieve all users and all bookings
-- This query shows all users and all bookings, even if user has no bookings or booking has no linked user
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    u.created_at AS user_created_at,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    b.created_at AS booking_created_at
FROM 
    User u
FULL OUTER JOIN 
    Booking b ON u.user_id = b.user_id
ORDER BY 
    u.user_id, b.created_at DESC;

-- Additional Query: Complex join with multiple tables for comprehensive booking information
-- This demonstrates a more complex scenario joining multiple related tables
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.first_name || ' ' || u.last_name AS guest_name,
    u.email AS guest_email,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    h.first_name || ' ' || h.last_name AS host_name,
    h.email AS host_email
FROM 
    Booking b
INNER JOIN 
    User u ON b.user_id = u.user_id
INNER JOIN 
    Property p ON b.property_id = p.property_id
INNER JOIN 
    User h ON p.host_id = h.user_id
WHERE 
    b.status = 'confirmed'
ORDER BY 
    b.start_date DESC;