from extract import extract
from transformation import transform
from load import load
import model as mdl
import querys as qrs
import os


clear = lambda: os.system('cls')

def displayMenu():
    while True:
        clear()
        print("Seleccione una opción:")
        print("1. Borrar Modelo")
        print("2. Crear Modelo")
        print("3. Extraer datos")
        print("4. Transformar datos")
        print("5. Cargar datos")
        print("6. Realizar Consultas")
        print("7. Salir")

        def todo(): 
            print("implementacion pendiente") 

        option = input("\nOpción: ")

        dictionarySwitcher = {
            '1': mdl.drop_model,
            '2': mdl.create_model,
            '3': extract,
            '4': transform,
            '5': load,
            '6': qrs.display_querys,
            '7': exit,
        }

        if option == '1':
            dataframe = dictionarySwitcher[option]()

        if option == '2':
            dataframe = dictionarySwitcher[option]()

        if option == '3':
            dataframe = dictionarySwitcher[option]()

        if option == "4":
            data = dictionarySwitcher[option](dataframe.copy())

        if option == "5":
            dictionarySwitcher[option](data.copy())

        if option == "6":
            clear()
            dictionarySwitcher[option]()

        option = input("press enter")

if __name__ == "__main__":
    displayMenu()