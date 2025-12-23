# Vehicle Rental System - Database Design & SQL Queries

## Overview
This project implements a **simplified Vehicle Rental System** to demonstrate database design, ERD relationships, and SQL queries. The system manages:

- **Users**  
- **Vehicles**  
- **Bookings**

The main objectives are:

1. Design an ERD showing **1-to-1, 1-to-many, and many-to-1 relationships**.
2. Understand and implement **primary keys (PK) and foreign keys (FK)**.
3. Write **SQL queries** using JOIN, EXISTS, WHERE, GROUP BY, and HAVING.

---

## Part 1: Database Design & ERD

### Tables & Business Logic

#### Users Table
- **Fields:** `user_id (PK)`, `name`, `email (unique)`, `password`, `phone`, `role (Admin/Customer)`  
- **Constraints:** Each email must be unique; role determines access type.

#### Vehicles Table
- **Fields:** `vehicle_id (PK)`, `name`, `type (car/bike/truck)`, `model`, `registration_number (unique)`, `rental_price`, `status (available/rented/maintenance)`  
- **Constraints:** Unique registration number; status tracks availability.

#### Bookings Table
- **Fields:** `booking_id (PK)`, `user_id (FK)`, `vehicle_id (FK)`, `start_date`, `end_date`, `status (pending/confirmed/completed/cancelled)`, `total_cost`  
- **Constraints:** Each booking links exactly **one user** and **one vehicle**.

### Relationships
- **One-to-Many:** User → Bookings  
- **Many-to-One:** Bookings → Vehicle  
- **One-to-One (logical):** Each booking connects exactly **one user** and **one vehicle**.  

> Primary and foreign keys enforce relationships and ensure **data integrity**.

**ERD Link:** [(https://drawsql.app/teams/myself-668/diagrams/vehicle-rental-system)]

---

## Part 2: SQL Queries with Explanations

### Sample Data
- Users, Vehicles, and Bookings tables populated with sample data to test queries.

---

### Query 1: Retrieve booking info with Customer and Vehicle name (INNER JOIN)

```sql
SELECT
    bookings.booking_id,
    users.name AS customer_name,
    vehicles.name AS vehicle_name,
    bookings.start_date,
    bookings.end_date,
    bookings.status
FROM bookings
INNER JOIN users ON bookings.user_id = users.user_id
INNER JOIN vehicles ON bookings.vehicle_id = vehicles.vehicle_id
ORDER BY bookings.booking_id;
```

### Explanation:
- INNER JOIN links bookings to users and vehicles.
- Only bookings with valid users and vehicles are shown.
- ORDER BY bookings.booking_id ensures sorted output.

---

### Query 2: Find all vehicles never booked (NOT EXISTS)

```sql
SELECT *
FROM vehicles
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings
    WHERE bookings.vehicle_id = vehicles.vehicle_id
)
ORDER BY vehicle_id ASC;
```

### Explanation:

- Outer query checks all vehicles.
- NOT EXISTS ensures the vehicle has no matching bookings in the bookings table.
- ORDER BY vehicle_id ASC sorts vehicles by ID.

---

### Query 3: Retrieve all available vehicles of a specific type (WHERE)
```sql

SELECT *
FROM vehicles
WHERE type = 'car'
  AND status = 'available'
ORDER BY vehicle_id ASC;
```

### Explanation:

- Filters vehicles to only cars that are available.
- WHERE clause filters row-level data before aggregation.
- Sorted by vehicle_id for predictable output.

---

### Query 4: Total number of bookings per vehicle (GROUP BY + HAVING)

```sql
SELECT 
    vehicles.name AS vehicle_name,
    COUNT(bookings.booking_id) AS total_bookings
FROM vehicles
JOIN bookings ON vehicles.vehicle_id = bookings.vehicle_id
GROUP BY vehicles.vehicle_id, vehicles.name
HAVING COUNT(bookings.booking_id) > 2
ORDER BY vehicles.vehicle_id ASC;
```

### Explanation:
- JOIN links vehicles to their bookings.
- GROUP BY aggregates bookings per vehicle.
- COUNT calculates total bookings for each vehicle.
- HAVING COUNT(...) > 2 filters only vehicles booked more than twice.
- ORDER BY ensures output sorted by vehicle ID.

---
