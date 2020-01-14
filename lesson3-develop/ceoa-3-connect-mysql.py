import mysql.connector

mydb = mysql.connector.connect(
  host="HOST",
  user="USERNAME",
  passwd="PASSWORD"
)

print(mydb)