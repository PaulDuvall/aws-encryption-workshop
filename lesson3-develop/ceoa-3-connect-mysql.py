import mysql.connector

mydb = mysql.connector.connect(
  host="rotation-instance.c5hdxe5niwfc.us-east-1.rds.amazonaws.com",
  user="admin",
  passwd="m}^nm(vKQ]AyI(8t"
)

print(mydb)