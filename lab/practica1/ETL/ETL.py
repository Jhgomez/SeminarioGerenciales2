import os

clear = lambda: os.system('cls')

def displayMenu():
    clear()
    while True:
        print("Seleccione una opción:")
        print("1. Borrar Modelo")
        print("2. Crear Modelo")
        print("3. Extraer datos")
        print("4. Transformar datos")
        print("5. Cargar datos")
        print("6. Realizar Consultas")
        print("7. Salir")

        option = input("Opción: ")

        dictionarySwitcher = {
            '0': prueba
        }

        dictionarySwitcher[option]()


def prueba():
    print("simon")

if __name__ == "__main__":
    displayMenu()