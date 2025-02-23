CREATE TABLE [fact_flight] (
	[id] INTEGER NOT NULL IDENTITY UNIQUE,
	[sk_airport_continent] INTEGER NOT NULL,
	[sk_departure_country] INTEGER NOT NULL,
	[sk_departure_airport] INTEGER NOT NULL,
	[sk_departure_date] INTEGER NOT NULL,
	[sk_arrival_airport] INTEGER NOT NULL,
	[sk_pilot] INTEGER NOT NULL,
	[sk_passenger] INTEGER NOT NULL,
	[sk_flight_status] INTEGER NOT NULL,
	PRIMARY KEY([id])
);
GO

CREATE TABLE [dim_departure_airport] (
	[sk_id] INTEGER NOT NULL IDENTITY UNIQUE,
	[airport_name] NVARCHAR NOT NULL,
	PRIMARY KEY([sk_id])
);
GO

CREATE TABLE [dim_departure_country] (
	[sk_id] INTEGER NOT NULL IDENTITY UNIQUE,
	[country_name] NVARCHAR NOT NULL,
	[country_code] NVARCHAR NOT NULL,
	PRIMARY KEY([sk_id])
);
GO

CREATE TABLE [dim_airport_continent] (
	[sk_id] INTEGER NOT NULL IDENTITY UNIQUE,
	[continent_code] VARCHAR NOT NULL,
	[continent_name] VARCHAR NOT NULL,
	PRIMARY KEY([sk_id])
);
GO

CREATE TABLE [dim_departure_date] (
	[sk_id] INTEGER NOT NULL IDENTITY UNIQUE,
	[departure_date] DATE NOT NULL,
	[month] INTEGER NOT NULL,
	[day] INTEGER NOT NULL,
	[year] INTEGER NOT NULL,
	PRIMARY KEY([sk_id])
);
GO

CREATE TABLE [dim_arrival_airport] (
	[sk_id] INTEGER NOT NULL IDENTITY UNIQUE,
	[arrival_airport] NVARCHAR NOT NULL,
	PRIMARY KEY([sk_id])
);
GO

CREATE TABLE [dim_pilot] (
	[sk_id] INTEGER NOT NULL IDENTITY UNIQUE,
	[pilot_name] NVARCHAR NOT NULL,
	PRIMARY KEY([sk_id])
);
GO

CREATE TABLE [dim_passenger] (
	[sk_id] INTEGER NOT NULL IDENTITY UNIQUE,
	[sk_gender] INTEGER NOT NULL,
	[sk_age] INTEGER NOT NULL,
	[sk_nationality] INTEGER NOT NULL,
	[name] VARCHAR NOT NULL,
	PRIMARY KEY([sk_id])
);
GO

CREATE TABLE [dim_gender] (
	[sk_id] INTEGER NOT NULL IDENTITY UNIQUE,
	[gender] VARCHAR NOT NULL,
	PRIMARY KEY([sk_id])
);
GO

CREATE TABLE [dim_age] (
	[sk_id] INTEGER NOT NULL IDENTITY UNIQUE,
	[age] INTEGER NOT NULL,
	PRIMARY KEY([sk_id])
);
GO

CREATE TABLE [dim_nationality] (
	[sk_id] INTEGER NOT NULL IDENTITY UNIQUE,
	[nationality] NVARCHAR NOT NULL,
	PRIMARY KEY([sk_id])
);
GO

CREATE TABLE [dim_flight_status] (
	[id] INTEGER NOT NULL IDENTITY UNIQUE,
	[flight_status] VARCHAR NOT NULL,
	PRIMARY KEY([id])
);
GO

ALTER TABLE [fact_flight]
ADD FOREIGN KEY([sk_airport_continent]) REFERENCES [dim_airport_continent]([sk_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [fact_flight]
ADD FOREIGN KEY([sk_departure_country]) REFERENCES [dim_departure_country]([sk_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [fact_flight]
ADD FOREIGN KEY([sk_departure_airport]) REFERENCES [dim_departure_airport]([sk_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [fact_flight]
ADD FOREIGN KEY([sk_departure_date]) REFERENCES [dim_departure_date]([sk_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [fact_flight]
ADD FOREIGN KEY([sk_arrival_airport]) REFERENCES [dim_arrival_airport]([sk_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [fact_flight]
ADD FOREIGN KEY([sk_pilot]) REFERENCES [dim_pilot]([sk_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [fact_flight]
ADD FOREIGN KEY([sk_passenger]) REFERENCES [dim_passenger]([sk_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [dim_passenger]
ADD FOREIGN KEY([sk_gender]) REFERENCES [dim_gender]([sk_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [dim_passenger]
ADD FOREIGN KEY([sk_age]) REFERENCES [dim_age]([sk_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [dim_passenger]
ADD FOREIGN KEY([sk_nationality]) REFERENCES [dim_nationality]([sk_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [fact_flight]
ADD FOREIGN KEY([sk_flight_status]) REFERENCES [dim_flight_status]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO