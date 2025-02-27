USE seminario
GO

CREATE OR ALTER PROCEDURE practica1.porcentaje_vuelos_por_genero
AS
BEGIN
    DECLARE @total INT
	SELECT @total = COUNT(sk_id) FROM practica1.dim_passenger

	DECLARE @porcentajes TABLE(
		hombres FLOAT(53),
		mujeres FLOAT(53)
	)

	DECLARE @mujer_id INT

	SELECT @mujer_id = sk_id
	FROM practica1.dim_gender
	WHERE gender = 'Female'

	DECLARE @mujer_porcentaje FLOAT(53)

	SELECT @mujer_porcentaje = (COUNT(ff.id)*100.0)/@total
	FROM practica1.fact_flight ff
	LEFT JOIN practica1.dim_passenger dp ON dp.sk_id = ff.sk_passenger
	WHERE dp.sk_gender = @mujer_id

	INSERT INTO @porcentajes VALUES (100.0 - @mujer_porcentaje, @mujer_porcentaje)

	SELECT * FROM @porcentajes
END
GO

EXEC practica1.porcentaje_vuelos_por_genero
GO

CREATE OR ALTER PROCEDURE practica1.salidas_por_nacionalidad_mes
AS
BEGIN
	SELECT dn.nationality, ddd.year, ddd.month, COUNT(dn.sk_id) AS total
	FROM practica1.fact_flight ff
		RIGHT JOIN practica1.dim_departure_date ddd ON ddd.sk_id = ff.sk_departure_date
		RIGHT JOIN practica1.dim_passenger dp ON dp.sk_id = ff.sk_passenger
		RIGHT JOIN practica1.dim_nationality dn ON dn.sk_id = dp.sk_nationality
	GROUP BY
		dn.nationality,
		ddd.year,
		ddd.month
	ORDER BY
		dn.nationality,
		ddd.month
END
GO

CREATE OR ALTER PROCEDURE practica1.vuelos_por_pais
AS
BEGIN
	SELECT ddc.country_name, COUNT(ddc.sk_id) AS total 
	FROM practica1.fact_flight ff
	RIGHT JOIN practica1.dim_departure_country ddc ON ddc.sk_id = ff.sk_departure_country
	GROUP BY ddc.country_name
	ORDER BY ddc.country_name
END
GO

EXEC practica1.vuelos_por_pais
GO

CREATE OR ALTER PROCEDURE practica1.top_aeropuerto_salida_transitados
	@top INT
AS
BEGIN
	SELECT TOP (@top) dda.airport_name, COUNT(dda.sk_id) AS total 
	FROM practica1.fact_flight ff
	RIGHT JOIN practica1.dim_departure_airport dda ON dda.sk_id = ff.sk_departure_airport
	GROUP BY dda.airport_name
	ORDER BY total DESC
END
GO

CREATE OR ALTER PROCEDURE practica1.top_aeropuerto_destino_transitados
	@top INT
AS
BEGIN
	SELECT TOP (@top) daa.arrival_airport, COUNT(daa.sk_id) AS total 
	FROM practica1.fact_flight ff
	RIGHT JOIN practica1.dim_arrival_airport daa ON daa.sk_id = ff.sk_departure_airport
	GROUP BY daa.arrival_airport
	ORDER BY total DESC
END
GO

EXEC practica1.top_aeropuerto_salida_transitados @top = 5
EXEC practica1.top_aeropuerto_destino_transitados @top = 5
GO


CREATE OR ALTER PROCEDURE practica1.total_estado_de_vuelo
AS
BEGIN
	SELECT dfs.flight_status, COUNT(dfs.sk_id) 
	FROM practica1.fact_flight ff
	RIGHT JOIN practica1.dim_flight_status dfs ON dfs.sk_id = ff.sk_flight_status
	GROUP BY dfs.flight_status
END
GO

EXEC practica1.total_estado_de_vuelo
GO



CREATE OR ALTER PROCEDURE practica1.top_edades_por_genero
	@top INT
AS
BEGIN
	DECLARE @lista TABLE(
		edad INT,
		genero NVARCHAR(8),
		total INT
	)

	DECLARE @mujer_id INT

	SELECT @mujer_id = sk_id
	FROM practica1.dim_gender
	WHERE gender = 'Female'

	INSERT INTO @lista
	SELECT TOP (@top) da.age, dg.gender, COUNT(da.sk_id) as total
	FROM practica1.fact_flight ff
	RIGHT JOIN practica1.dim_passenger dp ON dp.sk_id = ff.sk_passenger
	RIGHT JOIN practica1.dim_age da ON da.sk_id = dp.sk_age
	RIGHT JOIN practica1.dim_gender dg ON dg.sk_id = dp.sk_gender 
	WHERE dp.sk_gender = @mujer_id
	GROUP BY 
		da.age,
		dg.gender
	ORDER BY total DESC

	DECLARE @hombre_id INT

	SELECT @hombre_id = sk_id
	FROM practica1.dim_gender
	WHERE gender = 'Male'

	INSERT INTO @lista
	SELECT TOP (@top) da.age, dg.gender, COUNT(da.sk_id) as total
	FROM practica1.fact_flight ff
	RIGHT JOIN practica1.dim_passenger dp ON dp.sk_id = ff.sk_passenger
	RIGHT JOIN practica1.dim_age da ON da.sk_id = dp.sk_age
	RIGHT JOIN practica1.dim_gender dg ON dg.sk_id = dp.sk_gender 
	WHERE dp.sk_gender = @hombre_id
	GROUP BY 
		da.age,
		dg.gender
	ORDER BY total DESC

	SELECT * FROM @lista
END
GO

EXEC practica1.top_edades_por_genero @top = 5
GO






CREATE OR ALTER PROCEDURE practica1.total_vuelos_por_mes_anio
AS
BEGIN
	SELECT dd.month, dd.year, COUNT(dd.sk_id) as total
	FROM practica1.fact_flight ff
	RIGHT JOIN practica1.dim_departure_date dd ON dd.sk_id = ff.sk_departure_date
	GROUP BY 
		dd.month,
		dd.year
	ORDER BY
		dd.month,
		dd.year
END
GO

EXEC practica1.total_vuelos_por_mes_anio
GO



Seleccione la consulta que desea hacer:
  1. Contar las entradas en cada tabla
  2. Porcentaje pasajeros por genero
  3. Salidas por nacionalidad y mes
  4. Conteo vuelos por pais
  5. Top 5 aeropuertos con mas pasajeros
  6. Conteo por estado de vuelo
7. Top 5 paises mas visitados   TODO
8. Top 5 continentes mas visitados  TODO
  9. Top 5 Edades por genero que mas viajan
  10. Conteo de vuelos por 'mes-año'