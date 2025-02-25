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
        for _, row in tqdm(dim_airport_continent.iterrows(), total = len(dim_airport_continent), desc = "Insertando datos de pasajeros"):
            database.cursor.execute("""
                IF NOT EXISTS (SELECT 1 FROM practica1.dim_airport_continent WHERE sk_id = ?)
                BEGIN
                    INSERT INTO  practica1.dim_airport_continent (sk_id, continent_code, continent_name)
                    VALUES (?, ?, ?)
                END

                PRINT(?)
                """,
                row['sk_id'], row['sk_id'], row['continent_code'], row['continent_name'], row['sk_id']
            )
    except Exception as e:
        print(row)
        print(f"Error al insertar datos: {e}")