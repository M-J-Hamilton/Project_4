#DROP SCHEMA gans;

Create DATABASE gans;
USE gans;

# Set up cities table
# and datatypes of the columns and set primary key

CREATE TABLE IF NOT EXISTS cities (
	city_id VARCHAR(10) NOT NULL,
    city_name VARCHAR(100) NULL DEFAULT NULL,
    country VARCHAR(100) NULL DEFAULT NULL,
    country_code VARCHAR(5) NULL DEFAULT NULL,
    region VARCHAR(100) NULL DEFAULT NULL,
    elevation FLOAT NULL DEFAULT NULL,
    city_latitude FLOAT NULL,
    city_longitude FLOAT NULL,
    population INT NULL,
	PRIMARY KEY(city_id)
);

SELECT * FROM cities;
#DESCRIBE cities;

# Setting up weather table
# Before altering datatypes and setting key, weather has duplicate forecast_time values, therefore 
# a new ID column with unique values is necessary for the primary key

CREATE TABLE IF NOT EXISTS weather_conditions (
	weather_id INT NOT NULL AUTO_INCREMENT,
    outlook VARCHAR(100) NULL,
    forecast_time DATETIME NULL,
    temperature FLOAT,
    temp_feels_like FLOAT NULL,
    clouds FLOAT NULL,
    rain FLOAT NULL,
    wind_speed FLOAT NULL,
    snow FLOAT NULL,
    humidity FLOAT NULL,
    city VARCHAR(100) NULL,
    city_id VARCHAR(10) NULL,
    information_retrieved_at VARCHAR(100) NULL,
    PRIMARY KEY (weather_id),
    FOREIGN KEY (`city_id`)
	REFERENCES cities(`city_id`)
    );

ALTER TABLE weather_conditions
ADD INDEX `weather_city_id_idx` (`city_id` ASC) VISIBLE;

#SELECT * FROM weather_conditions;
#DESCRIBE weather_conditions;

CREATE TABLE IF NOT EXISTS airports (
	icao CHAR(4) NOT NULL,
    iata CHAR(3) NULL,
    airport_name VARCHAR(100) NULL,
    municipality_name VARCHAR(100) NULL,
    country_code VARCHAR(5) NULL,
    airport_latitude FLOAT NULL,
    airport_longitude FLOAT NULL,
    city_id VARCHAR(10) NULL,
    PRIMARY KEY (icao),
    FOREIGN KEY (`city_id`)
	REFERENCES weather_conditions(`city_id`)
);

# Setting foreign key:
ALTER TABLE airports
ADD INDEX `airport_city_id_idx` (`city_id` ASC) VISIBLE;

SELECT * FROM airports;
#DESCRIBE airports;

CREATE TABLE IF NOT EXISTS flights (
	flight_id INT NOT NULL AUTO_INCREMENT,
	arrival_icao CHAR(4) NULL,
    arrival_time_local DATETIME,
    arrival_terminal VARCHAR(10) NULL,
	departure_city VARCHAR(100) NULL,
	departure_icao CHAR(4) NULL,
    airline VARCHAR(100) NULL,    
    flight_number VARCHAR(10) NULL,
    data_retrieved_on DATETIME NULL,
    PRIMARY KEY(flight_id),
    FOREIGN KEY (arrival_icao) REFERENCES airports(icao)
);

# Setting foreign key:
ALTER TABLE flights
ADD INDEX `flights_icao_idx` (`arrival_icao` ASC) VISIBLE;

SELECT * FROM flights;
# DESCRIBE flights;

SELECT COUNT(*);