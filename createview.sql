CREATE VIEW passengers_flow AS
WITH passenger_cnt AS (
    SELECT flight_id, COUNT(ticket_no) AS cnt_passengers 
    FROM ticket_flights 
    GROUP BY flight_id
),
flights_w_passengers AS (
    SELECT *
    FROM flights f
    LEFT JOIN passenger_cnt fp ON fp.flight_id = f.flight_id
),
arrival_info AS (
    SELECT arrival_airport AS airport_code, 
           COUNT(arrival_airport) AS arrival_flights_num, 
           SUM(cnt_passengers) AS arrival_psngr_num
    FROM flights_w_passengers
    GROUP BY arrival_airport
),
departure_info AS (
    SELECT departure_airport AS airport_code, 
           COUNT(departure_airport) AS departure_flights_num, 
           SUM(cnt_passengers) AS departure_psngr_num
    FROM flights_w_passengers
    GROUP BY departure_airport
)
SELECT 
    a.airport_code, 
    dep.departure_flights_num, 
    dep.departure_psngr_num, 
    arr.arrival_flights_num, 
    arr.arrival_psngr_num
FROM airports a
LEFT JOIN departure_info dep ON dep.airport_code = a.airport_code
LEFT JOIN arrival_info arr ON arr.airport_code = a.airport_code;
