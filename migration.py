import mysql.connector
import csv
import json







conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="root",
    database="BelaRentaCar"
)

cursor = conn.cursor()


cursor.execute("SELECT * FROM Automovel")
resultados = cursor.fetchall()

for row in resultados:
    print(row)


cursor.close()
conn.close()
