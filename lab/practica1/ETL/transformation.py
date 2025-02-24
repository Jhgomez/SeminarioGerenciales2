import pandas as pd

def transform(dataframe):
    # PARA ACCEDER A UNA COLUMNA ESPECÍFICA DEL DATAFRAME, SE UTILIZA dataframe['NOMBRE DE LA COLUMNA']
    # ESTO PERMITE OBTENER UNA SERIE DE PANDAS QUE CONTIENE LOS VALORES DE ESA COLUMNA
    # CON ELLO, SE PUEDE APLICAR MÉTODOS DE PANDAS A ESA SERIE

    # UNA SITUACIÓN QUE SE PUEDE PRESENTAR ES QUE SE DESEE CREAR UNA DIMENSIÓN A PARTIR DE UNA COLUMNA DEL DATAFRAME
    # PARA ELLO, SE DEBE OBTENER LOS VALORES ÚNICOS DE ESA COLUMNA Y ASIGNARLES UN ID ÚNICO

    dim_airport_continent = dataframe[['continent_code', 'continent_name']].drop_duplicates()
    dim_airport_continent['sk_id'] = range(1, len(dim_airport_continent) + 1)

    print('continent_code dups')
    print(dim_airport_continent['continent_code'].duplicated().sum())  # Debe ser 0
    input("Para continuar presiona \"Enter\"...")

    print('continent_name dups')
    print(dim_airport_continent['continent_name'].duplicated().sum())  # Debe ser 0
    input("Para continuar presiona \"Enter\"...")

    print("dim_airport_continent:")
    print(dim_airport_continent.head())
    input("Para continuar presiona \"Enter\"...")


    dim_departure_country = dataframe[['country_name', 'country_code']].drop_duplicates()
    dim_departure_country['sk_id'] = range(1, len(dim_departure_country) + 1)

    print('country_name dups')
    print(dim_departure_country['country_name'].duplicated().sum())  # Debe ser 0
    print('country_code dups')
    print(dim_departure_country['country_code'].duplicated().sum())
    input("Para continuar presiona \"Enter\"...")

    print("dim_departure_country:")
    print(dim_departure_country.head())
    input("Para continuar presiona \"Enter\"...")


    dim_departure_airport = dataframe[['airport_name']].drop_duplicates()   
    dim_departure_airport['sk_id'] = range(1, len(dim_departure_airport) + 1)

    print("dim_departure_airport:")
    print(dim_departure_airport.head())
    input("Para continuar presiona \"Enter\"...")



    dataframe['departure_date'] = dataframe['departure_date'].apply(parse_dates)

    dim_departure_date = dataframe[['departure_date']].drop_duplicates()
    dim_departure_date['sk_id'] = range(1, len(dim_departure_date) + 1)

    dim_departure_date['year'] = dim_departure_date['departure_date'].dt.year
    dim_departure_date['month'] = dim_departure_date['departure_date'].dt.month
    dim_departure_date['day'] = dim_departure_date['departure_date'].dt.day
    
    print("DimDepartureDate:")
    print(dim_departure_date.head())
    input("Para continuar presiona \"Enter\"...")


    dim_arrival_airport = dataframe[['arrival_airport']].drop_duplicates()
    dim_arrival_airport['sk_id'] = range(1, len(dim_arrival_airport) + 1)

    print("dim_arrival_airport:")
    print(dim_arrival_airport.head())
    input("Para continuar presiona \"Enter\"...")


    dim_pilot = dataframe[['pilot_name']].drop_duplicates()
    dim_pilot['sk_id'] = range(1, len(dim_pilot) + 1)

    print("dim_pilot:")
    print(dim_pilot.head())
    input("Para continuar presiona \"Enter\"...")


    dim_gender = dataframe[['gender']].drop_duplicates()
    dim_gender['sk_id'] = range(1, len(dim_gender) + 1)

    print("dim_gender:")
    print(dim_gender.head())
    input("Para continuar presiona \"Enter\"...")


    dim_age = dataframe[['age']].drop_duplicates()
    dim_age['sk_id'] = range(1, len(dim_age) + 1)

    print("dim_age:")
    print(dim_age.head())
    input("Para continuar presiona \"Enter\"...")


    dim_nationality = dataframe[['nationality']].drop_duplicates()
    dim_nationality['sk_id'] = range(1, len(dim_nationality) + 1)

    print("dim_nationality:")
    print(dim_nationality.head())
    input("Para continuar presiona \"Enter\"...")


    dim_flight_status = dataframe[['flight_status']].drop_duplicates()
    dim_flight_status['sk_id'] = range(1, len(dim_flight_status) + 1)

    print("dim_flight_status:")
    print(dim_flight_status.head())
    input("Para continuar presiona \"Enter\"...")
    


    dim_passenger = dataframe[['sk_id', 'first_name', 'last_name', 'gender', 'age', 'nationality']].drop_duplicates()
    dim_passenger['sk_gender'] = dim_passenger['gender'].map(dim_gender.set_index('gender')['sk_id'])

    print("dim_passenger:")
    print(dim_passenger.head())
    input("Para continuar presiona \"Enter\"...")

    
    # ENTONCES UTILIZANDO LOS ID DE LAS DIMENSIONES, SE DEBE RELACIONAR CON LA TABLA DE HECHOS CON LOS ID CORRESPONDIENTES
    # PARA ELLO SE PUEDE UTILIZAR LA FUNCIÓN map DE PANDAS

    # df['NOMBRE DE LA COLUMNA'].map(SERIE.set_index('NOMBRE DE LA COLUMNA')['NOMBRE DE LA COLUMNA A RELACIONAR'])
    # LA LÓGICCA DE ESTA FUNCIÓN ES LA SIGUIENTE:
    # 1. SE TOMA LA COLUMNA DEL DATAFRAME QUE SE DESEA RELACIONAR
    # 2. SE UTILIZA LA FUNCIÓN set_index PARA ESTABLECER LA COLUMNA COMO ÍNDICE DE LA SERIE
    # 3. SE RELACIONA LA COLUMNA DEL DATAFRAME CON LA SERIE UTILIZANDO map
    # 4. SE OBTIENE UNA SERIE CON LOS VALORES RELACIONADOS
    # 5. SE ASIGNA LA SERIE AL DATAFRAME CON df['NOMBRE DE LA COLUMNA RELACIONADA'] = SERIE
    df['DepartureDateID'] = df['Departure Date'].map(dim_departure_date.set_index('Departure Date')['DepartureDateID'])
    df['ArrivalAirportID'] = df['Arrival Airport'].map(dim_arrival_airport.set_index('Arrival Airport')['ArrivalAirportID'])
    df['PilotID'] = df['Pilot Name'].map(dim_pilot.set_index('Pilot Name')['PilotID'])
    df['FlightStatusID'] = df['Flight Status'].map(dim_flight_status.set_index('Flight Status')['FlightStatusID'])
    df['DepartureAirportID'] = df['Airport Name'].map(dim_departure_airport.set_index('Airport Name')['DepartureAirportID'])
    
    # POR ULTIMO CREAMOS LA TABLA DE HECHOS CON LOS ID DE LAS DIMENSIONES RELACIONADAS Y LOS DATOS DE LA TABLA ORIGINAL
    fact_flight = df[['Passenger ID', 'DepartureDateID', 'ArrivalAirportID', 'PilotID', 'FlightStatusID', 'DepartureAirportID']]
    
    # VERIFICAMOS CADA UNA PARA VER COMO QUEDARON (MOSTRAR LAS PRIMERAS 5 FILAS)
    print("DimPassenger:")
    print(dim_passenger.head())
    print("Número total de registros:", len(dim_passenger))
    input("Para continuar presiona \"Enter\"...")
    print("DimDepartureDate:")
    print(dim_departure_date.head())
    print("Número total de registros:", len(dim_departure_date))
    input("Para continuar presiona \"Enter\"...")
    print("DimArrivalAirport:")
    print(dim_arrival_airport.head())
    print("Número total de registros:", len(dim_arrival_airport))
    input("Para continuar presiona \"Enter\"...")
    print("DimPilot:")
    print(dim_pilot.head())
    print("Número total de registros:", len(dim_pilot))
    input("Para continuar presiona \"Enter\"...")
    print("DimFlightStatus:")
    print(dim_flight_status.head())
    print("Número total de registros:", len(dim_flight_status))
    input("Para continuar presiona \"Enter\"...")
    print("DimDepartureAirport:")
    print(dim_departure_airport.head())
    print("Número total de registros:", len(dim_departure_airport))
    input("Para continuar presiona \"Enter\"...")
    print("FactFlight:")
    print(fact_flight.head())
    print("Número total de registros:", len(fact_flight))
    input("Para continuar presiona \"Enter\"...")
    
    # RETORNAMOS LAS DIMENSIONES Y LA TABLA DE HECHOS PARA PODER CARGARLOS EN LA BASE DE DATOS
    # PODEMOS RETORNAR CADA UNA O UTILIZAR UNA TUPLA O LISTA PARA RETORNARLAS TODAS JUNTAS
    # return dim_passenger, dim_departure_date, dim_departure_airport, dim_arrival_airport, dim_pilot, dim_flight_status, fact_flight
    # O
    return [dim_passenger, dim_departure_date, dim_departure_airport, dim_arrival_airport, dim_pilot, dim_flight_status, fact_flight]


# LAS FECHAS PUEDEN ESTAR EN FORMATO 'MM/DD/YYYY' O 'MM-DD-YYYY', POR LO QUE SE DEBE NORMALIZAR A UN FORMATO CONSISTENTE
def parse_dates(str_date):
    # SE RECORREN LOS FORMATOS DE FECHA HASTA ENCONTRAR UNO QUE FUNCIONE
    for fmt in ('%m/%d/%Y', '%m-%d-%Y'):
        try:
            # SE INTENTA CONVERTIR LA FECHA AL FORMATO '%Y-%m-%d' (YYYY-MM-DD) COMO LO REQUIERE SQL SERVER
            return pd.to_datetime(str_date, format=fmt)
        except ValueError:
            continue
        # SI NO SE PUDO CONVERTIR LA FECHA, SE RETORNA UN VALOR NULO (NaT)
    return pd.NaT