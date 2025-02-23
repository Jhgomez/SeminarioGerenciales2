from extract import extract
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
            '4': todo,
            '5': todo,
            '6': todo,
            '7': exit,
        }

        dictionarySwitcher[option]()
        option = input("press enter")

if __name__ == "__main__":
    displayMenu()