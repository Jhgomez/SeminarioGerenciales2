import database
from tqdm import tqdm

def load(data):
    dim_airport_continent = data[0]
    dim_departure_country = data[1]
    dim_departure_airport = data[2]
    dim_departure_date = data[3]
    dim_arrival_airport = data[4]
    dim_pilot = data[5]
    dim_gender = data[6]
    dim_age = data[7]
    dim_nationality = data[8]
    dim_passenger = data[9]
    dim_flight_status = data[10]
    fact_flight = data[11]

    try:
        for _, row in tqdm(dim_airport_continent.iterrows(), total = len(dim_airport_continent), desc = "Insertando datos de continentes"):
            database.cursor.execute("""
                IF NOT EXISTS (SELECT 1 FROM practica1.dim_airport_continent WHERE sk_id = ?)
                BEGIN
                    INSERT INTO  practica1.dim_airport_continent (sk_id, continent_code, continent_name)
                    VALUES (?, ?, ?)
                END

                """,
                row['sk_id'], row['sk_id'], row['continent_code'], row['continent_name']
            )

        for _, row in tqdm(dim_departure_country.iterrows(), total = len(dim_departure_country), desc = "Insertando datos de paises de salidas"):
            database.cursor.execute("""
                IF NOT EXISTS (SELECT 1 FROM practica1.dim_departure_country WHERE sk_id = ?)
                BEGIN
                    INSERT INTO  practica1.dim_departure_country (sk_id, country_name, country_code)
                    VALUES (?, ?, ?)
                END

                """,
                row['sk_id'], row['sk_id'], row['country_name'], row['country_code']
            )

        for _, row in tqdm(dim_departure_airport.iterrows(), total = len(dim_departure_airport), desc = "Insertando datos de aeropuertos de salidas"):
            database.cursor.execute("""
                IF NOT EXISTS (SELECT 1 FROM practica1.dim_departure_airport WHERE sk_id = ?)
                BEGIN
                    INSERT INTO  practica1.dim_departure_airport (sk_id, airport_name)
                    VALUES (?, ?, ?)
                END

                """,
                row['sk_id'], row['sk_id'], row['airport_name']
            )

    except Exception as e:
        print(row)
        print(f"Error al insertar datos: {e}")