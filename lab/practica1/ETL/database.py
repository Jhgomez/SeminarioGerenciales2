import pyodbc

SERVER = 'localhost'
DATABASE = 'seminario'
USERNAME = 'sa'
PASSWORD = 'abcdeF1+'

connectionString = f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={SERVER};DATABASE={DATABASE};UID={USERNAME};PWD={PASSWORD};Trusted_Connection=no'

conn = pyodbc.connect(connectionString)

cursor = conn.cursor()

def close_conn():
    cursor.close()
    conn.close()