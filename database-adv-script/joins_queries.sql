-- 1. INNER JOIN: Retrieve all bookings and the respective users who made those bookings
SELECT 
    b.id AS booking_id,
    b.property_id,
    b.user_id,
    u.name AS user_name,
    u.email AS user_email,
    b.start_date,
    b.end_date,
    b.status
FROM 
    Booking b
INNER JOIN 
    Users u ON b.user_id = u.id;

-- 2. LEFT JOIN: Retrieve all properties and their reviews, including properties that have no reviews
SELECT 
    p.id AS property_id,
    p.name AS property_name,
    p.location,
    r.id AS review_id,
    r.rating,
    r.comment
FROM 
    Property p
LEFT JOIN 
    Review r ON p.id = r.property_id;

-- 3. FULL OUTER JOIN: Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
SELECT 
    u.id AS user_id,
    u.name AS user_name,
    u.email AS user_email,
    b.id AS booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.status
FROM 
    Users u
FULL OUTER JOIN 
    Booking b ON u.id = b.user_id;