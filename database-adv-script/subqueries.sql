-- Task 1: Practice Subqueries
-- ALX AirBnB Database Advanced Script

-- Query 1: Non-correlated subquery to find properties with average rating > 4.0
-- This subquery calculates the average rating for each property and filters those above 4.0
SELECT 
    p.property_id,
    p.host_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.price_per_night,
    p.created_at
FROM 
    Property p
WHERE 
    p.property_id IN (
        SELECT 
            r.property_id
        FROM 
            Review r
        GROUP BY 
            r.property_id
        HAVING 
            AVG(r.rating) > 4.0
    )
ORDER BY 
    p.name;

-- Alternative Query 1: Using EXISTS with subquery (more efficient in some cases)
SELECT 
    p.property_id,
    p.host_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.price_per_night,
    p.created_at
FROM 
    Property p
WHERE 
    EXISTS (
        SELECT 1
        FROM Review r
        WHERE r.property_id = p.property_id
        GROUP BY r.property_id
        HAVING AVG(r.rating) > 4.0
    )
ORDER BY 
    p.name;

-- Query 2: Correlated subquery to find users who have made more than 3 bookings
-- This subquery references the outer query's user_id in its WHERE clause
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role,
    u.created_at
FROM 
    User u
WHERE 
    (SELECT COUNT(*) 
     FROM Booking b 
     WHERE b.user_id = u.user_id) > 3
ORDER BY 
    u.last_name, u.first_name;

-- Enhanced Query 2: Correlated subquery with additional booking details
-- Shows users with more than 3 bookings along with their booking count
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    u.created_at,
    (SELECT COUNT(*) 
     FROM Booking b 
     WHERE b.user_id = u.user_id) AS total_bookings,
    (SELECT COUNT(*) 
     FROM Booking b 
     WHERE b.user_id = u.user_id AND b.status = 'confirmed') AS confirmed_bookings
FROM 
    User u
WHERE 
    (SELECT COUNT(*) 
     FROM Booking b 
     WHERE b.user_id = u.user_id) > 3
ORDER BY 
    total_bookings DESC;

-- Bonus Query 3: Complex subquery - Properties with above-average ratings in their location
-- This finds properties that have better ratings than the average for their location
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    (SELECT AVG(r.rating) 
     FROM Review r 
     WHERE r.property_id = p.property_id) AS property_avg_rating,
    (SELECT AVG(r.rating) 
     FROM Review r 
     INNER JOIN Property p2 ON r.property_id = p2.property_id 
     WHERE p2.location = p.location) AS location_avg_rating
FROM 
    Property p
WHERE 
    (SELECT AVG(r.rating) 
     FROM Review r 
     WHERE r.property_id = p.property_id) > 
    (SELECT AVG(r.rating) 
     FROM Review r 
     INNER JOIN Property p2 ON r.property_id = p2.property_id 
     WHERE p2.location = p.location)
ORDER BY 
    p.location, property_avg_rating DESC;

-- Bonus Query 4: Users with bookings in the last 30 days (correlated subquery)
-- This demonstrates time-based correlated subqueries
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    (SELECT COUNT(*) 
     FROM Booking b 
     WHERE b.user_id = u.user_id 
     AND b.created_at >= CURRENT_DATE - INTERVAL '30 days') AS recent_bookings
FROM 
    User u
WHERE 
    EXISTS (
        SELECT 1
        FROM Booking b
        WHERE b.user_id = u.user_id
        AND b.created_at >= CURRENT_DATE - INTERVAL '30 days'
    )
ORDER BY 
    recent_bookings DESC;

-- Bonus Query 5: Properties with no reviews (using NOT EXISTS)
-- This demonstrates negative correlated subqueries
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    p.created_at
FROM 
    Property p
WHERE 
    NOT EXISTS (
        SELECT 1
        FROM Review r
        WHERE r.property_id = p.property_id
    )
ORDER BY 
    p.created_at DESC;