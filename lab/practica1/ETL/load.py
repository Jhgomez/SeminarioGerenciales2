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

        for _, row in tqdm(dim_departure_date.iterrows(), total = len(dim_departure_date), desc = "Insertando datos de fechas de salidas"):
            database.cursor.execute("""
                IF NOT EXISTS (SELECT 1 FROM practica1.dim_departure_date WHERE sk_id = ?)
                BEGIN
                    INSERT INTO  practica1.dim_departure_date (sk_id, departure_date, month, day, year)
                    VALUES (?, ?, ?, ?, ?)
                END

                """,

                row['sk_id'], row['sk_id'], row['departure_date'], row['month'], row['day'], row['year']
            )

        for _, row in tqdm(dim_arrival_airport.iterrows(), total = len(dim_arrival_airport), desc = "Insertando datos de aeropuertos de destino"):
            database.cursor.execute("""
                IF NOT EXISTS (SELECT 1 FROM practica1.dim_arrival_airport WHERE sk_id = ?)
                BEGIN
                    INSERT INTO  practica1.dim_arrival_airport (sk_id, arrival_airport)
                    VALUES (?, ?)
                END

                """,
                row['sk_id'], row['sk_id'], row['arrival_airport']
            )

        for _, row in tqdm(dim_pilot.iterrows(), total = len(dim_pilot), desc = "Insertando datos de pilotos"):
            database.cursor.execute("""
                IF NOT EXISTS (SELECT 1 FROM practica1.dim_pilot WHERE sk_id = ?)
                BEGIN
                    INSERT INTO  practica1.dim_pilot (sk_id, pilot_name)
                    VALUES (?, ?)
                END

                """,
                row['sk_id'], row['sk_id'], row['pilot_name']
            )

        for _, row in tqdm(dim_gender.iterrows(), total = len(dim_gender), desc = "Insertando datos de genero"):
            database.cursor.execute("""
                IF NOT EXISTS (SELECT 1 FROM practica1.dim_gender WHERE sk_id = ?)
                BEGIN
                    INSERT INTO  practica1.dim_gender (sk_id, gender)
                    VALUES (?, ?)
                END

                """,
                row['sk_id'], row['sk_id'], row['gender']
            )

        for _, row in tqdm(dim_age.iterrows(), total = len(dim_age), desc = "Insertando datos de edad"):
            database.cursor.execute("""
                IF NOT EXISTS (SELECT 1 FROM practica1.dim_age WHERE sk_id = ?)
                BEGIN
                    INSERT INTO  practica1.dim_age (sk_id, age)
                    VALUES (?, ?)
                END

                """,
                row['sk_id'], row['sk_id'], row['age']
            )

        for _, row in tqdm(dim_nationality.iterrows(), total = len(dim_nationality), desc = "Insertando datos de nacionalidades"):
            database.cursor.execute("""
                IF NOT EXISTS (SELECT 1 FROM practica1.dim_nationality WHERE sk_id = ?)
                BEGIN
                    INSERT INTO  practica1.dim_nationality (sk_id, nationality)
                    VALUES (?, ?)
                END

                """,
                row['sk_id'], row['sk_id'], row['nationality']
            )

        for _, row in tqdm(dim_passenger.iterrows(), total = len(dim_passenger), desc = "Insertando datos de pasajeros"):
            database.cursor.execute("""
                IF NOT EXISTS (SELECT 1 FROM practica1.dim_passenger WHERE sk_id = ?)
                BEGIN
                    INSERT INTO  practica1.dim_passenger (sk_id, sk_gender, sk_age, sk_nationality, first_name, last_name)
                    VALUES (?, ?, ?, ?, ?, ?)
                END

                """,
                row['sk_id'], row['sk_id'], row['sk_gender'], row['sk_age'], row['sk_nationality'], row['first_name'], row['last_name']
            )

        for _, row in tqdm(dim_flight_status.iterrows(), total = len(dim_flight_status), desc = "Insertando datos de estados de vuelo"):
            database.cursor.execute("""
                IF NOT EXISTS (SELECT 1 FROM practica1.dim_flight_status WHERE sk_id = ?)
                BEGIN
                    INSERT INTO  practica1.dim_flight_status (sk_id, flight_status)
                    VALUES (?, ?)
                END

                """,
                row['sk_id'], row['sk_id'], row['flight_status']
            )

    except Exception as e:
        print(row)
        print(f"Error al insertar datos: {e}")