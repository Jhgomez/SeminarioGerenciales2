import database
import os

def display_querys():
    database.cursor.execute("USE seminario")

    while True:
        os.system('cls')

        print("Seleccione la consulta que desea hacer:")
        print('1. Contar las entradas en cada tabla')
        print('2. Porcentaje pasajeros por genero')
        print('3. Salidas por nacionalidad y mes')
        print('4. Conteo vuelos por pais')
        print('5. Top 5 aeropuertos con mas pasajeros')
        print('6. Conteo por estado de vuelo')
        #print('7. Top 5 paises mas visitados')
        #print('8. Top 5 continentes mas visitados')
        print('9. Top 5 Edades por genero que mas viajan')
        print('10. Conteo de vuelos por \'mes-año\'')

        option = input('\nOpción: ')

        if option == '1':
            entradas_tablas()

        if option == '2':
            porcentaje_por_genero()

        if option == '3':
            salidas_nacionalidad_mes()

        if option == '':
            __()

        if option == '':
            __()

        if option == '':
            __()
        if option == '':
            __()

        if option == '':
            __()

        if option == '':
            __()

        if option == '':
            __()

def entradas_tablas():

    result = database.cursor.execute("SELECT COUNT(sk_id) as C FROM practica1.dim_airport_continent").fetchval()

    print('\nEntradas en continentes de aeropuerto: ', result)

    result = database.cursor.execute("SELECT COUNT(sk_id) as C FROM practica1.dim_departure_country").fetchval()

    print('\nEntradas en paises de salida: ', result)

    result = database.cursor.execute("SELECT COUNT(sk_id) as C FROM practica1.dim_departure_airport").fetchval()

    print('\nEntradas en aeropuerto de salida: ', result)

    result = database.cursor.execute("SELECT COUNT(sk_id) as C FROM practica1.dim_departure_date").fetchval()

    print('\nEntradas fecha de salida: ', result)

    result = database.cursor.execute("SELECT COUNT(sk_id) as C FROM practica1.dim_arrival_airport").fetchval()

    print('\nEntradas aeropuerto destino: ', result)

    result = database.cursor.execute("SELECT COUNT(sk_id) as C FROM practica1.dim_pilot").fetchval()

    print('\nEntradas pilotos: ', result)

    result = database.cursor.execute("SELECT COUNT(sk_id) as C FROM practica1.dim_gender").fetchval()

    print('\nEntradas genero: ', result)

    result = database.cursor.execute("SELECT COUNT(sk_id) as C FROM practica1.dim_age").fetchval()

    print('\nEntradas edad: ', result)

    result = database.cursor.execute("SELECT COUNT(sk_id) as C FROM practica1.dim_nationality").fetchval()

    print('\nEntradas nacionalidades: ', result)

    result = database.cursor.execute("SELECT COUNT(sk_id) as C FROM practica1.dim_passenger").fetchval()

    print('\nEntradas pasajero: ', result)

    result = database.cursor.execute("SELECT COUNT(sk_id) as C FROM practica1.dim_flight_status").fetchval()

    print('\nEntradas estado de vuelo: ', result)

    result = database.cursor.execute("SELECT COUNT(id) as C FROM practica1.fact_flight").fetchval()

    print('\nEntradas hecho vuelo: ', result)

    input("\npress Enter to continue")


def porcentaje_por_genero():
    valuex = []
    valuex.append([1.1,2.2])
    
    total = database.cursor.execute("""
        SELECT COUNT(ff.id)
        FROM practica1.fact_flight ff
        RIGHT JOIN practica1.dim_passenger dp ON dp.sk_id = ff.sk_passenger
    """).fetchval()

    mujer_id = database.cursor.execute("""
        SELECT sk_id
        FROM practica1.dim_gender
        WHERE gender = 'Female'
    """).fetchval()

    mujer_porcentaje = database.cursor.execute(f"""
        SELECT (COUNT(ff.id)*100.0)/{total}
        FROM practica1.fact_flight ff
        LEFT JOIN practica1.dim_passenger dp ON dp.sk_id = ff.sk_passenger
        WHERE dp.sk_gender = {mujer_id}
    """).fetchval()

    hombre_porcentaje = 100.0 - float(mujer_porcentaje)

    print(f"mujeres: {mujer_porcentaje}")
    print(f"hombres: {hombre_porcentaje}")

    input("\npress Enter to continue")

def salidas_nacionalidad_mes():
    result = database.cursor.execute("""
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
    """).fetchall()

    for r in result:
        print(r)

    input("\npress Enter to continue")

def stored_procedure_example():

    database.cursor.execute("""
        CREATE OR ALTER PROCEDURE practica1.percentage_by_gender
            @top INT
        AS
        BEGIN
            DECLARE @ans INT

            SELECT @ans = sk_id
            FROM practica1.dim_gender
            WHERE sk_id = @top

            RETURN @ans
        END
    """)
    
    result = database.cursor.execute("""
        DECLARE @generoid INT
        EXEC @generoid = practica1.percentage_by_gender @top = 1
        SELECT @generoid
    """).fetchval()

    print('\ngenero 1 es: ', result)
    
    result = database.cursor.execute("""
        DECLARE @generoid INT
        EXEC @generoid = practica1.percentage_by_gender @top = 2
        SELECT @generoid
    """).fetchval()

    print('\ngenero 2 es: ', result)

    input("\npress Enter to continue")