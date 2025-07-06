# Complex Queries with Joins

## Overview
This task demonstrates mastery of SQL joins by implementing three different types of joins to retrieve data from the AirBnB database schema. Each query serves a specific purpose and showcases different join behaviors.

## Queries Implemented

### 1. INNER JOIN Query
**Purpose**: Retrieve all bookings with their respective users who made those bookings.

**Query Type**: `INNER JOIN`

**Tables Involved**: 
- `Booking` (b)
- `User` (u)

**Join Condition**: `b.user_id = u.user_id`

**Result**: Returns only bookings that have a corresponding user record. This excludes any orphaned bookings (if any exist) that don't have a valid user_id reference.

**Use Case**: Perfect for generating booking reports with guest details, ensuring data integrity by only showing complete booking-user relationships.

### 2. LEFT JOIN Query
**Purpose**: Retrieve all properties and their reviews, including properties that have no reviews.

**Query Type**: `LEFT JOIN`

**Tables Involved**:
- `Property` (p) - Left table
- `Review` (r) - Right table

**Join Condition**: `p.property_id = r.property_id`

**Result**: Returns all properties, regardless of whether they have reviews or not. Properties without reviews will show NULL values for review columns.

**Use Case**: Essential for property analysis, allowing hosts to see all their properties including those that haven't received reviews yet.

### 3. FULL OUTER JOIN Query
**Purpose**: Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.

**Query Type**: `FULL OUTER JOIN`

**Tables Involved**:
- `User` (u)
- `Booking` (b)

**Join Condition**: `u.user_id = b.user_id`

**Result**: Returns all users and all bookings. Users without bookings will show NULL values for booking columns, and bookings without valid users will show NULL values for user columns.

**Use Case**: Comprehensive data analysis to identify users who haven't made bookings and potentially orphaned booking records.

## Additional Complex Query
The file also includes a bonus query that demonstrates joining multiple tables:
- `Booking` ↔ `User` (guest information)
- `Booking` ↔ `Property` (property details)
- `Property` ↔ `User` (host information)

This query provides a complete view of confirmed bookings with guest, property, and host details.

## Key Learning Points

### Join Types Comparison
| Join Type | Returns | Use Case |
|-----------|---------|----------|
| INNER JOIN | Only matching records from both tables | When you need complete data relationships |
| LEFT JOIN | All records from left table + matching from right | When you need all records from primary table |
| FULL OUTER JOIN | All records from both tables | When you need comprehensive data analysis |

### Performance Considerations
- **INNER JOIN**: Generally fastest as it has the smallest result set
- **LEFT JOIN**: Moderate performance, depends on the size of the left table
- **FULL OUTER JOIN**: Potentially slowest as it returns the largest result set

### Data Integrity Insights
- INNER JOINs help identify clean, complete relationships
- LEFT JOINs reveal missing related data (e.g., properties without reviews)
- FULL OUTER JOINs expose orphaned records and data gaps

## Database Schema Assumptions
Based on the AirBnB database structure:
- `User` table contains both guests and hosts (differentiated by role)
- `Booking` table has foreign key reference to `User` (guest)
- `Property` table has foreign key reference to `User` (host)
- `Review` table has foreign key reference to `Property`

## Usage Instructions
1. Ensure your PostgreSQL database is set up with the AirBnB schema
2. Execute the queries in order to understand different join behaviors
3. Analyze the result sets to understand how each join type handles missing relationships
4. Use EXPLAIN ANALYZE to understand query performance characteristics

## Notes
- All queries include proper column aliases for clarity
- Results are ordered by relevant timestamps for better readability
- The queries handle NULL values appropriately for outer joins
- Comments explain the purpose and expected behavior of each query