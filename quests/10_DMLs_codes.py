import psycopg2


"""PostgreSQL 데이터베이스에 연결합니다."""
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
    # cursor.execute("INSERT INTO users_uuid_name (name) VALUES ('from code');")
    # cursor.execute("""UPDATE users_uuid_name
    #                 SET name = 'code Name'
    #                 WHERE id_name = '9a328b2c-f195-499e-a3d0-c76ca59be4dd';""")
    # cursor.execute("""DELETE FROM users_uuid_name
    #                 WHERE id_name = '84afbbf1-c3f4-4508-bf2d-c84455eb4a49';""")
    cursor.execute("SELECT name, id_name FROM users_uuid_name;")
    records = cursor.fetchall()
    for record in records :
        print(record)
        print(f'{record[0]} : {record[1]}')
conn.commit()

#1번 문제

with conn.cursor() as cursor:
    cursor.execute("DROP TABLE IF EXISTS students;")
    create_table_query = """
        CREATE TABLE students (
            id SERIAL PRIMARY KEY, 
            name VARCHAR(50),
            age INT
        );
        """
    cursor.execute(create_table_query)


    #2번 문제
    students_data = [
            (1, '홍길동', 23),
            (2, '이영희', 21),
            (3, '박철수', 26)
        ]
        
    insert_query = "INSERT INTO students (id, name, age) VALUES (%s, %s, %s);"
    print(students_data)
        # executemany를 쓰면 여러 데이터를 한번에 넣을 수 있습니다.
    cursor.executemany(insert_query, students_data)
    #3번 문제
    cursor.execute("SELECT * FROM students;")
    for row in cursor.fetchall():
        print(row)

        
        cursor.execute("SELECT * FROM students WHERE age >= 22;")
    for row in cursor.fetchall():
        print(row)

        
        cursor.execute("SELECT * FROM students WHERE name = '홍길동';")
    for row in cursor.fetchall():
        print(row)
        
    #4번 문제
    update_query = "UPDATE students SET age = 25 WHERE id = 2;"
    cursor.execute(update_query)
    print('age')