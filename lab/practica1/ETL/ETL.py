from extract import extract
from transformation import transform
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
            '1': todo,
            '2': todo,
            '3': extract,
            '4': transform,
            '5': todo,
            '6': todo,
            '7': exit,
        }

        if option == '3':
            dataframe = dictionarySwitcher[option]()

        if option == "4":
            dictionarySwitcher[option](dataframe)

        option = input("press enter")

if __name__ == "__main__":
    displayMenu()