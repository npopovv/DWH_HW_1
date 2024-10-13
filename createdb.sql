CREATE TABLE aircrafts (
    aircraft_code CHAR(3) PRIMARY KEY,
    model jsonb NOT NULL,
    range INTEGER NOT NULL
);

CREATE TABLE seats (
    aircraft_code CHAR(3) NOT NULL,
    seat_no VARCHAR(4) NOT NULL,
    fare_conditions VARCHAR(10) NOT NULL,
    
    CONSTRAINT fk_seats
      FOREIGN KEY(aircraft_code) 
      REFERENCES aircrafts(aircraft_code),
      
    CONSTRAINT pk_seats 
      PRIMARY KEY (aircraft_code, seat_no)
);

CREATE TABLE airports (
    airport_code CHAR(3) PRIMARY KEY,
    airport_name TEXT NOT NULL,
    city TEXT NOT NULL,
    coordinates_lon DOUBLE PRECISION NOT NULL,
    coordinates_lat DOUBLE PRECISION NOT NULL,
    timezone TEXT NOT NULL
    
);

CREATE TABLE bookings (
    book_ref CHAR(6) PRIMARY KEY,
    book_date timestamp with time zone NOT NULL,
    total_amount NUMERIC(10,2) NOT NULL
);

CREATE TABLE tickets (
    ticket_no CHAR(13) PRIMARY KEY,
    book_ref CHAR(6) NOT NULL,
    passenger_id VARCHAR(20) NOT NULL,
    passenger_name TEXT NOT NULL,
    contact_data jsonb,
    
    CONSTRAINT fk_book_ref
      FOREIGN KEY(book_ref) 
      REFERENCES bookings(book_ref)
);

CREATE TABLE ticket_flights (
    ticket_no CHAR(13) NOT NULL,
    flight_id INTEGER NOT NULL,
    fare_conditions NUMERIC(10,2) NOT NULL,
    amount NUMERIC(10,2) NOT NULL,

    CONSTRAINT fk_ticket_no
    	FOREIGN KEY(ticket_no) 
    	REFERENCES tickets(ticket_no),
      
    CONSTRAINT pk_ticket_flights 
    	PRIMARY KEY (ticket_no, flight_id)
);


CREATE TABLE boarding_passes (
    ticket_no CHAR(13) NOT NULL,
    flight_id INTEGER NOT NULL,
    boarding_no INTEGER NOT NULL,
    seat_no VARCHAR(4) NOT NULL,
    CONSTRAINT pk_boarding_passes
      PRIMARY KEY(ticket_no, flight_id),
    CONSTRAINT fk_ticket_flight
      FOREIGN KEY(ticket_no, flight_id)
      REFERENCES ticket_flights(ticket_no, flight_id)
);

CREATE TABLE flights (
    flight_id SERIAL PRIMARY KEY,
    flight_no CHAR(6) NOT NULL,
    scheduled_departure timestamp with time zone NOT NULL,
    scheduled_arrival timestamp with time zone NOT NULL,
    departure_airport CHAR(3) NOT NULL,
    arrival_airport CHAR(3) NOT NULL,
    status VARCHAR(20) NOT NULL,
    aircraft_code CHAR(3) NOT NULL,
    actual_departure timestamp with time zone,
    actual_arrival timestamp with time zone,
    
    CONSTRAINT fk_aircraft_code
      FOREIGN KEY(aircraft_code)
      REFERENCES aircrafts(aircraft_code),
    CONSTRAINT fk_arrival_airport
      FOREIGN KEY(arrival_airport)
      REFERENCES airports(airport_code),
    CONSTRAINT fk_departure_airport
      FOREIGN KEY(departure_airport)
      REFERENCES airports(airport_code)
);
