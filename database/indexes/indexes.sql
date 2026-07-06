-- Index to optimize filtering by city and created_at
CREATE INDEX idx_hotel_bookings_city_created_at
ON hotel_bookings (city, created_at);

-- Index to optimize grouping by organization and status
CREATE INDEX idx_hotel_bookings_org_status
ON hotel_bookings (org_id, status);
