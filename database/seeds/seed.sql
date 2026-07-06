-- Generate 5 organization UUIDs
WITH organizations AS (
    SELECT ARRAY[
        gen_random_uuid(),
        gen_random_uuid(),
        gen_random_uuid(),
        gen_random_uuid(),
        gen_random_uuid()
    ] AS orgs
)

INSERT INTO hotel_bookings (
    org_id,
    hotel_id,
    city,
    checkin_date,
    checkout_date,
    amount,
    status,
    created_at
)

SELECT
    (orgs[(gs % 5) + 1]),

    'HOTEL-' || ((gs % 10) + 1),

    (ARRAY[
        'delhi',
        'mumbai',
        'bengaluru',
        'hyderabad',
        'chennai'
    ])[(gs % 5) + 1],

    CURRENT_DATE + (gs % 30),

    CURRENT_DATE + (gs % 30) + 2,

    ROUND((1000 + random() * 9000)::numeric, 2),

    (ARRAY[
        'CONFIRMED',
        'PENDING',
        'CHECKED_IN',
        'CANCELLED'
    ])[(gs % 4) + 1],

    NOW() - ((gs % 30) || ' days')::interval

FROM generate_series(1,100) gs
CROSS JOIN organizations;


-- Create booking events for approximately half the bookings
INSERT INTO booking_events (
    booking_id,
    event_type,
    payload,
    created_at
)

SELECT
    id,

    CASE
        WHEN random() < 0.5 THEN 'BOOKING_CREATED'
        ELSE 'PAYMENT_RECEIVED'
    END,

    jsonb_build_object(
        'source', 'seed',
        'remarks', 'Generated sample event'
    ),

    created_at

FROM hotel_bookings

WHERE random() < 0.5;