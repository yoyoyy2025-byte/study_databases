import psycopg2
import os

db_host = "db_postgresql"
db_port = "5432"
db_name = "main_db"
db_user = "admin"
db_password = "admin123"

conn = psycopg2.connect(
    host=db_host,
    port=db_port,
    dbname=db_name,
    user=db_user,
    password=db_password
)
print("PostgreSQL 데이터베이스에 성공적으로 연결되었습니다.")

with conn.cursor() as cursor :
    #cursor.execute("INSERT INTO users_uuid_name (name) VALUES ('from code');")
    # cursor.execute("""UPDATE users_uuid_name
    #                 SET name = 'code Name'
    #                 WHERE id_name = 'ffb496a1-a542-46a8-8032-ba968a8dc19b';""")
    # cursor.execute("""DELETE FROM users_uuid_name
    #                 WHERE id_name = '0804a668-1c11-47bf-8dba-77baf825e912';""")
    cursor.execute("SELECT name, id_name FROM users_uuid_name;")
    records = cursor.fetchall()
    for record in records : 
        print(record)
        print(f'{record[0]} ; {record[1]}')

conn.commit()