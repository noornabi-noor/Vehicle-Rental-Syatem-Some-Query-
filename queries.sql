-- Query -> 1
SELECT
    b.booking_id,
    u.name AS customer_name,
    v.name AS vehicle_name,
    b.start_date,
    b.end_date,
    b.status
FROM bookings b
INNER JOIN users u
    ON b.user_id = u.user_id
INNER JOIN vehicles v
    ON b.vehicle_id = v.vehicle_id
ORDER BY b.booking_id;



-- Query -> 2
SELECT *
FROM vehicles
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings
    WHERE bookings.vehicle_id = vehicles.vehicle_id
)
ORDER BY vehicle_id ASC;



-- Query -> 3
SELECT *
FROM vehicles
WHERE type = 'car'
  AND status = 'available'
ORDER BY vehicle_id ASC;



-- Query -> 4
SELECT 
    vehicles.name AS vehicle_name,
    COUNT(bookings.booking_id) AS total_bookings
FROM vehicles
JOIN bookings ON vehicles.vehicle_id = bookings.vehicle_id
GROUP BY vehicles.vehicle_id, vehicles.name
HAVING COUNT(bookings.booking_id) > 2
ORDER BY vehicles.vehicle_id ASC;