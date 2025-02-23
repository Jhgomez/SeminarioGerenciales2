import pandas as pd

def extract():

    try:
        dataframe = pd.read_csv("C:/Users/Juan Enrique/seminario2/lab/practica1/VuelosDataSet.csv")
        print("Cantidad de registros:", len(dataframe))

        input("Para continuar presione \"Enter\"...")

        print("\nPrimeras 5 filas:")
        print(dataframe.head())

        input("Para continuar presione \"Enter\"...")

        print("\nUltimas 5 filas:")
        print(dataframe.tail())

        input("Para continuar presione \"Enter\"...")

        return dataframe

    except Exception as e:
        print(f"Error leyendo el archivo: {e}")
        input("Para continuar presione \"Enter\"...")
        return 0