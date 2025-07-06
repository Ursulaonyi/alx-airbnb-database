-- Task 2: Apply Aggregations and Window Functions
-- ALX AirBnB Database Advanced Script

-- Query 1: Total number of bookings made by each user using COUNT and GROUP BY
-- This aggregation query counts bookings per user and provides user details
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    COUNT(b.booking_id) AS total_bookings,
    COUNT(CASE WHEN b.status = 'confirmed' THEN 1 END) AS confirmed_bookings,
    COUNT(CASE WHEN b.status = 'cancelled' THEN 1 END) AS cancelled_bookings,
    COUNT(CASE WHEN b.status = 'pending' THEN 1 END) AS pending_bookings,
    MIN(b.created_at) AS first_booking_date,
    MAX(b.created_at) AS last_booking_date,
    SUM(b.total_price) AS total_spent,
    AVG(b.total_price) AS avg_booking_value
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name, u.email, u.role
ORDER BY 
    total_bookings DESC, total_spent DESC;

-- Query 2: Window function to rank properties by total number of bookings
-- Using ROW_NUMBER() and RANK() to rank properties based on booking count
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    p.host_id,
    COUNT(b.booking_id) AS total_bookings,
    -- ROW_NUMBER: Assigns unique sequential numbers (no ties)
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS row_number_rank,
    -- RANK: Assigns same rank to tied values, skips subsequent ranks
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS rank_position,
    -- DENSE_RANK: Assigns same rank to tied values, no gaps in ranking
    DENSE_RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS dense_rank_position
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name, p.location, p.price_per_night, p.host_id
ORDER BY 
    total_bookings DESC, p.property_id;

-- Query 3: Advanced window functions - Properties ranked by bookings within each location
-- This demonstrates partitioning with window functions
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    p.host_id,
    COUNT(b.booking_id) AS total_bookings,
    -- Ranking within each location
    ROW_NUMBER() OVER (PARTITION BY p.location ORDER BY COUNT(b.booking_id) DESC) AS location_row_number,
    RANK() OVER (PARTITION BY p.location ORDER BY COUNT(b.booking_id) DESC) AS location_rank,
    -- Overall ranking
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS overall_rank,
    -- Percentage of total bookings in location
    ROUND(
        COUNT(b.booking_id) * 100.0 / 
        SUM(COUNT(b.booking_id)) OVER (PARTITION BY p.location), 2
    ) AS pct_of_location_bookings
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name, p.location, p.price_per_night, p.host_id
ORDER BY 
    p.location, location_rank;

-- Query 4: Running totals and cumulative statistics using window functions
-- This shows how window functions can calculate running totals
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.created_at,
    b.total_price,
    -- Running total of spending per user
    SUM(b.total_price) OVER (
        PARTITION BY u.user_id 
        ORDER BY b.created_at 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_spent,
    -- Running count of bookings per user
    ROW_NUMBER() OVER (
        PARTITION BY u.user_id 
        ORDER BY b.created_at
    ) AS booking_sequence,
    -- Average booking value up to current booking
    AVG(b.total_price) OVER (
        PARTITION BY u.user_id 
        ORDER BY b.created_at 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_avg_booking_value
FROM 
    User u
INNER JOIN 
    Booking b ON u.user_id = b.user_id
ORDER BY 
    u.user_id, b.created_at;

-- Query 5: Advanced aggregations with multiple grouping sets
-- This demonstrates complex aggregations for business intelligence
SELECT 
    COALESCE(p.location, 'ALL LOCATIONS') AS location,
    COALESCE(b.status, 'ALL STATUSES') AS booking_status,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.total_price) AS total_revenue,
    AVG(b.total_price) AS avg_booking_value,
    COUNT(DISTINCT b.user_id) AS unique_customers,
    COUNT(DISTINCT p.property_id) AS unique_properties
FROM 
    Booking b
INNER JOIN 
    Property p ON b.property_id = p.property_id
GROUP BY 
    ROLLUP(p.location, b.status)
ORDER BY 
    location, booking_status;

-- Query 6: Lead and Lag functions for time-based analysis
-- This shows how to compare current and previous/next values
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.created_at,
    b.total_price,
    -- Previous booking date for the user
    LAG(b.created_at) OVER (
        PARTITION BY u.user_id 
        ORDER BY b.created_at
    ) AS previous_booking_date,
    -- Next booking date for the user
    LEAD(b.created_at) OVER (
        PARTITION BY u.user_id 
        ORDER BY b.created_at
    ) AS next_booking_date,
    -- Days between current and previous booking
    EXTRACT(DAY FROM (
        b.created_at - LAG(b.created_at) OVER (
            PARTITION BY u.user_id 
            ORDER BY b.created_at
        )
    )) AS days_since_last_booking,
    -- Compare current booking value to previous
    b.total_price - LAG(b.total_price) OVER (
        PARTITION BY u.user_id 
        ORDER BY b.created_at
    ) AS price_change_from_previous
FROM 
    User u
INNER JOIN 
    Booking b ON u.user_id = b.user_id
ORDER BY 
    u.user_id, b.created_at;

-- Query 7: Percentile and statistical functions
-- This demonstrates advanced statistical analysis using window functions
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    COUNT(b.booking_id) AS total_bookings,
    -- Percentile rankings
    PERCENT_RANK() OVER (ORDER BY COUNT(b.booking_id)) AS booking_percentile,
    CUME_DIST() OVER (ORDER BY COUNT(b.booking_id)) AS cumulative_distribution,
    -- Quartile assignment
    NTILE(4) OVER (ORDER BY COUNT(b.booking_id)) AS quartile,
    -- Statistical comparisons
    COUNT(b.booking_id) - AVG(COUNT(b.booking_id)) OVER () AS bookings_vs_avg
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name, p.location, p.price_per_night
ORDER BY 
    total_bookings DESC;



# Apply Aggregations and Window Functions

## Overview
This task demonstrates mastery of SQL aggregation functions and window functions for advanced data analysis. These powerful tools enable complex calculations, rankings, and statistical analysis that are essential for business intelligence and data-driven decision making.

## Required Queries Implementation

### 1. User Booking Aggregations (COUNT + GROUP BY)

**Purpose**: Find the total number of bookings made by each user using COUNT function and GROUP BY clause.

**Key Features**:
- **Basic aggregation**: `COUNT(b.booking_id)` for total bookings
- **Conditional aggregation**: Status-based booking counts
- **Statistical measures**: MIN, MAX, SUM, AVG for comprehensive analysis
- **LEFT JOIN**: Includes users with zero bookings

**Business Value**: 
- Customer segmentation based on booking frequency
- Identification of high-value customers
- User engagement analysis

### 2. Property Ranking (Window Functions)

**Purpose**: Use window functions (ROW_NUMBER, RANK) to rank properties based on total bookings.

**Window Functions Demonstrated**:
- **ROW_NUMBER()**: Unique sequential ranking (no ties)
- **RANK()**: Standard ranking with gaps for ties
- **DENSE_RANK()**: Ranking without gaps for ties

**Business Value**:
- Property performance analysis
- Competitive positioning
- Portfolio optimization

## Advanced Window Functions

### 3. Location-Based Property Ranking

**Purpose**: Rank properties within their respective locations using PARTITION BY.

**Key Features**:
- **PARTITION BY**: Separate rankings per location
- **Multiple rankings**: Location-specific and overall rankings
- **Percentage calculations**: Share of bookings within location

**Business Value**:
- Market-specific performance analysis
- Location-based competitive intelligence
- Market share calculation

### 4. Running Totals and Cumulative Statistics

**Purpose**: Calculate running totals and cumulative averages for user spending patterns.

**Window Frame Features**:
- **ROWS BETWEEN**: Defines calculation window
- **UNBOUNDED PRECEDING**: Includes all previous rows
- **Running calculations**: Cumulative sums and averages

**Business Value**:
- Customer lifetime value tracking
- Spending pattern analysis
- Growth trend identification

## Advanced Aggregation Techniques

### 5. Multi-Dimensional Analysis (ROLLUP)

**Purpose**: Generate subtotals and grand totals across multiple dimensions.

**Features**:
- **ROLLUP**: Hierarchical aggregation
- **COALESCE**: Handle NULL values in grouping
- **Multiple metrics**: Bookings, revenue, customers, properties

**Business Value**:
- Executive dashboards
- Multi-level reporting
- Comprehensive business overview

### 6. Time-Based Analysis (LAG/LEAD)

**Purpose**: Compare current values with previous/next values for trend analysis.

**Window Functions**:
- **LAG()**: Access previous row values
- **LEAD()**: Access next row values
- **Date calculations**: Time intervals between events

**Business Value**:
- Customer behavior patterns
- Booking frequency analysis
- Price sensitivity tracking

### 7. Statistical Analysis (Percentiles)

**Purpose**: Perform statistical analysis using percentile and distribution functions.

**Statistical Functions**:
- **PERCENT_RANK()**: Relative ranking as percentage
- **CUME_DIST()**: Cumulative distribution
- **NTILE()**: Quartile assignment

**Business Value**:
- Performance benchmarking
- Statistical comparisons
- Data distribution analysis

## Function Categories Comparison

### Aggregation Functions
| Function | Purpose | Use Case |
|----------|---------|----------|
| COUNT | Count rows | Booking frequency |
| SUM | Total values | Revenue calculation |
| AVG | Average values | Mean booking value |
| MIN/MAX | Extreme values | Date ranges |

### Window Functions
| Function | Behavior | Use Case |
|----------|----------|----------|
| ROW_NUMBER | Unique sequential | Exact ordering |
| RANK | Gaps for ties | Competition ranking |
| DENSE_RANK | No gaps | Tier assignment |
| PERCENT_RANK | Percentile position | Statistical analysis |

### Window Frame Types
| Frame Type | Description | Use Case |
|------------|-------------|----------|
| UNBOUNDED PRECEDING | All previous rows | Running totals |
| CURRENT ROW | Only current row | Point-in-time |
| FOLLOWING | Future rows | Predictive analysis |

## Performance Considerations

### Aggregation Optimization
```sql
-- Recommended indexes for aggregation queries
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_status ON Booking(status);
CREATE INDEX idx_booking_created_at ON Booking(created_at);
```

### Window Function Optimization
```sql
-- Composite indexes for window functions
CREATE INDEX idx_booking_user_created ON Booking(user_id, created_at);
CREATE INDEX idx_property_location ON Property(location);
```

## Business Intelligence Applications

### Customer Analytics
- **Segmentation**: High, medium, low value customers
- **Behavior**: Booking patterns and frequency
- **Retention**: Customer lifecycle analysis

### Property Management
- **Performance**: Top-performing properties
- **Market Analysis**: Location-based comparisons
- **Pricing**: Revenue optimization

### Operational Insights
- **Trends**: Booking volume patterns
- **Forecasting**: Demand prediction
- **Optimization**: Resource allocation

## Real-World Use Cases

### Dashboard Metrics
1. **Top 10 Properties**: Most booked properties
2. **Customer Tiers**: VIP, regular, new customers
3. **Revenue Trends**: Monthly/quarterly performance
4. **Market Share**: Performance by location

### Reporting Scenarios
1. **Executive Summary**: High-level business metrics
2. **Property Reports**: Individual property performance
3. **Customer Analysis**: User behavior insights
4. **Market Research**: Competitive positioning

## Best Practices Demonstrated

### Query Design
- **Proper aliasing**: Clear table and column names
- **Logical grouping**: Meaningful aggregation levels
- **Appropriate ordering**: Results sorted by business relevance

### Performance Optimization
- **Efficient joins**: LEFT JOIN for inclusive analysis
- **Index-friendly**: Queries designed for optimal index usage
- **Selective filtering**: Reduced data processing

### Business Logic
- **Meaningful calculations**: Business-relevant metrics
- **Comprehensive analysis**: Multiple perspectives
- **Actionable insights**: Results support decision making

## Learning Outcomes

After completing this task, you should understand:
- How to use aggregation functions for summarization
- When to apply different window functions
- How to optimize queries for large datasets
- Real-world applications of analytical SQL
- Business intelligence query patterns

## Usage Instructions

1. **Sequential execution**: Run queries in order to understand progression
2. **Performance monitoring**: Use EXPLAIN ANALYZE for optimization
3. **Index creation**: Implement suggested indexes for better performance
4. **Business validation**: Verify results against expected business logic

## Notes
- All queries handle NULL values appropriately
- Results include comprehensive business metrics
- Performance considerations documented
- Real-world scenarios demonstrated
- Scalable patterns for large datasets