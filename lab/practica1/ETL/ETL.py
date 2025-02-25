from extract import extract
from transformation import transform
from load import load
import model
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

        option = input("Opción: ")

        dictionarySwitcher = {
            '1': model.drop_model,
            '2': model.create_model,
            '3': extract,
            '4': transform,
            '5': load,
            '6': todo,
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

        option = input("press enter")

if __name__ == "__main__":
    displayMenu()