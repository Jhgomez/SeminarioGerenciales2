import pyodbc

SERVER = 'localhost'
DATABASE = 'seminario'
USERNAME = 'sa'
PASSWORD = 'abcdeF1+'

connectionString = f'DRIVER={{ODBC Driver 18 for SQL Server}};SERVER={SERVER};DATABASE={DATABASE};UID={USERNAME};PWD={PASSWORD}'

conn = pyodbc.connect(connectionString)

cursor = conn.cursor()

def close_conn():
    cursor.close()
    conn.close()