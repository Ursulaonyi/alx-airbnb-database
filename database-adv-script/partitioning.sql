-- Partitioning the Booking table by start_date (Range Partitioning by Year)
-- Step 1: Rename existing table
ALTER TABLE Booking RENAME TO Booking_old;

-- Step 2: Create partitioned parent table
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    property_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price NUMERIC(10,2) NOT NULL,
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_property FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE
) PARTITION BY RANGE (start_date);

-- Step 3: Create partitions (for example 2022–2025)
CREATE TABLE Booking_2022 PARTITION OF Booking
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE Booking_2023 PARTITION OF Booking
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE Booking_2024 PARTITION OF Booking
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE Booking_2025 PARTITION OF Booking
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Step 4: Migrate existing data
INSERT INTO Booking
SELECT * FROM Booking_old;

-- Step 5: (Optional) Drop old table
-- DROP TABLE Booking_old;

-- Step 6: Create indexes on partitions if needed
CREATE INDEX idx_booking_2024_user_id ON Booking_2024(user_id);
CREATE INDEX idx_booking_2024_property_id ON Booking_2024(property_id);

-- Step 7: (Optional) Drop old table
-- DROP TABLE Booking_old;
-- Step 8: Verify partitioning
SELECT
    relname AS partition_name,
    pg_size_pretty(pg_total_relation_size(relid)) AS partition_size,
    pg_relation_size(relid) AS partition_data_size,
    pg_indexes_size(relid) AS partition_index_size
FROM
    pg_catalog.pg_partitioned_table pt
JOIN
    pg_catalog.pg_class c ON pt.partrelid = c.oid
JOIN
    pg_catalog.pg_namespace n ON c.relnamespace = n.oid
JOIN  
    pg_catalog.pg_class p ON pt.partrelid = p.oid
WHERE
    n.nspname = 'public' AND
    c.relname LIKE 'Booking_%'
ORDER BY
    partition_name;
-- Step 9: Test partitioned table with a query
SELECT
    booking_id,
    user_id,
    property_id,
    start_date,
    end_date,
    total_price,
    status,
    created_at
FROM
    Booking
WHERE
    start_date >= '2024-01-01' AND
    start_date < '2025-01-01'
ORDER BY
    start_date DESC
LIMIT 10;
-- Step 10: Cleanup (if needed)
-- DROP TABLE Booking_2022;
-- DROP TABLE Booking_2023;
-- DROP TABLE Booking_2024;
-- DROP TABLE Booking_2025; 