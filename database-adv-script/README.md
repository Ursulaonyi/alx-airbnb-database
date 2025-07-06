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


# Subqueries

## Overview
This task demonstrates mastery of SQL subqueries by implementing both non-correlated and correlated subqueries. Subqueries are powerful tools for complex data retrieval and analysis, allowing us to nest queries within queries for sophisticated filtering and calculations.

## Queries Implemented

### 1. Non-Correlated Subquery: Properties with Average Rating > 4.0

**Purpose**: Find all properties where the average rating is greater than 4.0 using a subquery.

**Query Type**: Non-correlated subquery with `IN` operator

**Key Features**:
- **Inner subquery**: Calculates average rating per property using `GROUP BY` and `HAVING`
- **Outer query**: Retrieves property details for properties with high ratings
- **Independence**: The subquery can run independently of the outer query

**Alternative Implementation**: Also provided using `EXISTS` operator for potentially better performance in large datasets.

**Business Value**: Helps identify high-quality properties for featured listings or premium recommendations.

### 2. Correlated Subquery: Users with More Than 3 Bookings

**Purpose**: Find users who have made more than 3 bookings using a correlated subquery.

**Query Type**: Correlated subquery with `COUNT` function

**Key Features**:
- **Correlation**: The subquery references `u.user_id` from the outer query
- **Dynamic filtering**: Each user's booking count is calculated individually
- **Performance**: Executes for each row in the outer query

**Enhanced Version**: Includes additional booking statistics (total bookings, confirmed bookings) for comprehensive user analysis.

**Business Value**: Identifies loyal customers for VIP programs or targeted marketing campaigns.

## Additional Advanced Subqueries

### 3. Complex Nested Subquery: Properties with Above-Average Location Ratings

**Purpose**: Find properties that perform better than the average for their location.

**Technique**: Multiple correlated subqueries comparing property ratings to location averages.

**Business Value**: Helps identify standout properties within specific markets.

### 4. Time-Based Correlated Subquery: Recent Active Users

**Purpose**: Find users with bookings in the last 30 days.

**Technique**: Date-based filtering using `CURRENT_DATE` and `INTERVAL`.

**Business Value**: Identifies recently active users for engagement campaigns.

### 5. Negative Correlated Subquery: Properties Without Reviews

**Purpose**: Find properties that have no reviews.

**Technique**: `NOT EXISTS` to identify missing relationships.

**Business Value**: Helps identify properties needing review encouragement.

## Subquery Types Comparison

| Subquery Type | Execution | Performance | Use Case |
|---------------|-----------|-------------|----------|
| **Non-Correlated** | Once, independently | Generally faster | Fixed filtering criteria |
| **Correlated** | Once per outer row | Can be slower | Dynamic, row-dependent filtering |
| **EXISTS** | Stops at first match | Efficient for existence checks | Boolean conditions |
| **IN** | Compares all values | Good for small result sets | Membership testing |

## Performance Considerations

### Non-Correlated Subqueries
- **Advantages**: Execute only once, can be cached
- **Best for**: Large datasets with simple filtering
- **Optimization**: Can often be converted to JOINs for better performance

### Correlated Subqueries
- **Advantages**: More flexible, can access outer query data
- **Challenges**: Execute repeatedly, potentially slower
- **Optimization**: Use indexes on correlated columns

## Query Execution Analysis

### Query 1 Performance Tips:
```sql
-- Create index for better performance
CREATE INDEX idx_review_property_rating ON Review(property_id, rating);
```

### Query 2 Performance Tips:
```sql
-- Create index for correlated subquery
CREATE INDEX idx_booking_user_id ON Booking(user_id);
```

## Real-World Applications

### Property Management
- **High-rated properties**: Featured listings, premium placement
- **Location analysis**: Market positioning, competitive analysis
- **Review gaps**: Properties needing attention

### User Analytics
- **Loyalty programs**: Frequent bookers identification
- **Engagement tracking**: Recent activity monitoring
- **Customer segmentation**: Booking behavior analysis

## SQL Best Practices Demonstrated

1. **Proper aliasing**: Clear table aliases for readability
2. **Logical ordering**: Results sorted by relevant criteria
3. **Efficient filtering**: Using appropriate subquery types
4. **Documentation**: Comments explaining complex logic
5. **Alternative approaches**: Multiple solutions for comparison

## Database Schema Dependencies

The queries assume the following relationships:
- `Property` ↔ `Review` (one-to-many)
- `User` ↔ `Booking` (one-to-many)
- `Property.location` for geographical grouping
- Timestamp fields for temporal analysis

## Usage Instructions

1. **Sequential execution**: Run queries in order to understand progression
2. **Performance monitoring**: Use `EXPLAIN ANALYZE` to compare execution plans
3. **Index optimization**: Create suggested indexes for better performance
4. **Data validation**: Verify results against expected business logic

## Learning Outcomes

After completing this task, you should understand:
- When to use correlated vs non-correlated subqueries
- Performance implications of different subquery types
- How to write complex nested queries
- Real-world applications of subquery patterns
- Optimization strategies for subquery performance

## Notes
- All queries handle NULL values appropriately
- Results are ordered for consistent output
- Comments explain the business logic behind each query
- Alternative implementations provided for comparison
- Performance considerations documented for production use