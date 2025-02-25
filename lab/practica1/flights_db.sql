USE master
GO

DROP DATABASE IF EXISTS seminario
GO

CREATE DATABASE seminario
GO

USE seminario
GO

DROP SCHEMA IF EXISTS practica1
GO

CREATE SCHEMA practica1
GO

IF OBJECT_ID('practica1.dim_flight_status', 'U') IS NOT NULL
    DROP TABLE practica1.dim_flight_status;
GO

IF OBJECT_ID('practica1.dim_nationality', 'U') IS NOT NULL
    DROP TABLE practica1.dim_nationality;
GO

IF OBJECT_ID('practica1.dim_age', 'U') IS NOT NULL
    DROP TABLE practica1.dim_age;
GO

IF OBJECT_ID('practica1.dim_gender', 'U') IS NOT NULL
    DROP TABLE practica1.dim_gender;
GO

IF OBJECT_ID('practica1.dim_passenger', 'U') IS NOT NULL
    DROP TABLE practica1.dim_passenger;
GO

IF OBJECT_ID('practica1.dim_pilot', 'U') IS NOT NULL
    DROP TABLE practica1.dim_pilot;
GO

IF OBJECT_ID('practica1.dim_arrival_airport', 'U') IS NOT NULL
    DROP TABLE practica1.dim_arrival_airport;
GO

IF OBJECT_ID('practica1.dim_departure_date', 'U') IS NOT NULL
    DROP TABLE practica1.dim_departure_date;
GO

IF OBJECT_ID('practica1.dim_airport_continent', 'U') IS NOT NULL
    DROP TABLE practica1.dim_airport_continent;
GO

IF OBJECT_ID('practica1.dim_departure_country', 'U') IS NOT NULL
    DROP TABLE practica1.dim_departure_country;
GO

IF OBJECT_ID('practica1.dim_departure_airport', 'U') IS NOT NULL
    DROP TABLE practica1.dim_departure_airport;
GO

IF OBJECT_ID('practica1.fact_flight', 'U') IS NOT NULL
    DROP TABLE practica1.fact_flight;
GO


CREATE TABLE practica1.dim_departure_airport (
	sk_id INTEGER NOT NULL,
	airport_name NVARCHAR(255) NOT NULL,
	PRIMARY KEY(sk_id)
);
GO

CREATE TABLE practica1.dim_departure_country (
	sk_id INTEGER NOT NULL,
	country_name NVARCHAR(64) NOT NULL,
	country_code NVARCHAR(4) NOT NULL,
	PRIMARY KEY(sk_id)
);
GO

CREATE TABLE practica1.dim_airport_continent (
	sk_id INTEGER NOT NULL,
	continent_code NVARCHAR(4) NOT NULL,
	continent_name NVARCHAR(16) NOT NULL,
	PRIMARY KEY(sk_id)
);
GO

CREATE TABLE practica1.dim_departure_date (
	sk_id INTEGER NOT NULL,
	departure_date DATE NOT NULL,
	month INTEGER NOT NULL,
	day INTEGER NOT NULL,
	year INTEGER NOT NULL,
	PRIMARY KEY(sk_id)
);
GO

CREATE TABLE practica1.dim_arrival_airport (
	sk_id INTEGER NOT NULL,
	arrival_airport NVARCHAR(8) NOT NULL,
	PRIMARY KEY(sk_id)
);
GO

CREATE TABLE practica1.dim_pilot (
	sk_id INTEGER NOT NULL,
	pilot_name NVARCHAR(64) NOT NULL,
	PRIMARY KEY(sk_id)
);
GO

CREATE TABLE practica1.dim_passenger (
	sk_id NVARCHAR(64) NOT NULL UNIQUE,
	sk_gender INTEGER NOT NULL,
	sk_age INTEGER NOT NULL,
	sk_nationality INTEGER NOT NULL,
	first_name NVARCHAR(32) NOT NULL,
	last_name NVARCHAR(32) NOT NULL,
	PRIMARY KEY(sk_id)
);
GO

CREATE TABLE practica1.dim_gender (
	sk_id INTEGER NOT NULL,
	gender NVARCHAR(8) NOT NULL,
	PRIMARY KEY(sk_id)
);
GO

CREATE TABLE practica1.dim_age (
	sk_id INTEGER NOT NULL,
	age INTEGER NOT NULL,
	PRIMARY KEY(sk_id)
);
GO

CREATE TABLE practica1.dim_nationality (
	sk_id INTEGER NOT NULL,
	nationality NVARCHAR(56) NOT NULL,
	PRIMARY KEY(sk_id)
);
GO

CREATE TABLE practica1.dim_flight_status (
	sk_id INTEGER NOT NULL,
	flight_status NVARCHAR(16) NOT NULL,
	PRIMARY KEY(sk_id)
);
GO

CREATE TABLE practica1.fact_flight (
	id INTEGER NOT NULL,
	sk_airport_continent INTEGER NOT NULL,
	sk_departure_country INTEGER NOT NULL,
	sk_departure_airport INTEGER NOT NULL,
	sk_departure_date INTEGER NOT NULL,
	sk_arrival_airport INTEGER NOT NULL,
	sk_pilot INTEGER NOT NULL,
	sk_passenger NVARCHAR(64) NOT NULL,
	sk_flight_status INTEGER NOT NULL,
	PRIMARY KEY(id)
);
GO

ALTER TABLE practica1.fact_flight
ADD FOREIGN KEY(sk_airport_continent) REFERENCES practica1.dim_airport_continent(sk_id)
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE practica1.fact_flight
ADD FOREIGN KEY(sk_departure_country) REFERENCES practica1.dim_departure_country(sk_id)
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE practica1.fact_flight
ADD FOREIGN KEY(sk_departure_airport) REFERENCES practica1.dim_departure_airport(sk_id)
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE practica1.fact_flight
ADD FOREIGN KEY(sk_departure_date) REFERENCES practica1.dim_departure_date(sk_id)
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE practica1.fact_flight
ADD FOREIGN KEY(sk_arrival_airport) REFERENCES practica1.dim_arrival_airport(sk_id)
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE practica1.fact_flight
ADD FOREIGN KEY(sk_pilot) REFERENCES practica1.dim_pilot(sk_id)
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE practica1.fact_flight
ADD FOREIGN KEY(sk_passenger) REFERENCES practica1.dim_passenger(sk_id)
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE practica1.dim_passenger
ADD FOREIGN KEY(sk_gender) REFERENCES practica1.dim_gender(sk_id)
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE practica1.dim_passenger
ADD FOREIGN KEY(sk_age) REFERENCES practica1.dim_age(sk_id)
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE practica1.dim_passenger
ADD FOREIGN KEY(sk_nationality) REFERENCES practica1.dim_nationality(sk_id)
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE practica1.fact_flight
ADD FOREIGN KEY(sk_flight_status) REFERENCES practica1.dim_flight_status(sk_id)
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO