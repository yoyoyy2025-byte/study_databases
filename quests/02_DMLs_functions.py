import psycopg2
from psycopg2 import sql

# ✨ 데이터베이스 연결 정보 (사용자 환경에 맞게 수정하세요)
# 
DB_CONFIG = {
    "host": "localhost",
    "database": "your_db_name",
    "user": "your_user",
    "password": "your_password"
}

def get_connection():
    """데이터베이스 연결 객체를 반환합니다."""
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        return conn
    except psycopg2.Error as e:
        print(f"데이터베이스 연결 오류: {e}")
        return None

## 📌 문제 1 — 테이블 생성 함수 만들기
def create_books_table():
    """
    PostgreSQL에 books 테이블을 생성합니다.
    (UUID 확장이 DB에 설치되어 있어야 합니다: CREATE EXTENSION IF NOT EXISTS "uuid-ossp";)
    """
    conn = get_connection()
    if conn is None:
        return

    try:
        cur = conn.cursor()
        # 테이블이 존재하면 삭제 (테스트 용이성을 위해)
        cur.execute("DROP TABLE IF EXISTS books CASCADE;")

        # UUID PRIMARY KEY DEFAULT uuid_generate_v4() 사용
        create_table_query = """
        CREATE TABLE books (
            id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
            title VARCHAR(100) NOT NULL,
            price INT
        );
        """
        cur.execute(create_table_query)
        conn.commit()
        print("books 테이블이 생성되었습니다.")
    except psycopg2.Error as e:
        print(f"테이블 생성 오류: {e}")
    finally:
        if cur:
            cur.close()
        if conn:
            conn.close()

## 📌 문제 2 — INSERT 함수 만들기
def insert_books():
    """
    테스트 데이터를 books 테이블에 삽입합니다. (id는 자동 생성)
    """
    conn = get_connection()
    if conn is None:
        return

    # ✔ 테스트용 데이터
    test_data = [
        ("파이썬 입문", 19000),
        ("알고리즘 기초", 25000),
        ("네트워크 이해", 30000)
    ]
    
    try:
        cur = conn.cursor()
        insert_query = "INSERT INTO books (title, price) VALUES (%s, %s);"
        
        # executemany를 사용하여 여러 행을 효율적으로 삽입
        cur.executemany(insert_query, test_data)
        conn.commit()
        
        # 🔥 출력 예
        print(f"{cur.rowcount}개 도서가 삽입되었습니다.")
    except psycopg2.Error as e:
        print(f"데이터 삽입 오류: {e}")
    finally:
        if cur:
            cur.close()
        if conn:
            conn.close()

# 데이터 조회 결과를 깔끔하게 출력하는 보조 함수
def print_books(title, books_list):
    """조회된 도서 목록을 포맷팅하여 출력합니다."""
    print(f"\n--- {title} ---")
    if not books_list:
        print("조회된 도서가 없습니다.")
        return
        
    # 헤더 출력
    print(f"| {'ID (UUID)':<36} | {'Title':<15} | {'Price':<8} |")
    print("-" * 68)
    # 데이터 출력
    for book in books_list:
        # UUID, title, price 순서로 출력
        print(f"| {str(book[0]):<36} | {book[1]:<15} | {book[2]:<8} |")
    print("-" * 68)

## 📌 문제 3 — SELECT 함수 만들기
def get_all_books():
    """전체 도서를 조회하고 출력합니다."""
    conn = get_connection()
    if conn is None:
        return

    try:
        cur = conn.cursor()
        cur.execute("SELECT id, title, price FROM books ORDER BY title;")
        books = cur.fetchall()
        print_books("전체 도서 조회 결과", books)
        return books
    except psycopg2.Error as e:
        print(f"전체 조회 오류: {e}")
    finally:
        if cur:
            cur.close()
        if conn:
            conn.close()

def get_expensive_books():
    """가격이 25000원 이상인 도서를 조회하고 출력합니다."""
    conn = get_connection()
    if conn is None:
        return

    try:
        cur = conn.cursor()
        # 가격 조건: price >= 25000
        cur.execute("SELECT id, title, price FROM books WHERE price >= 25000 ORDER BY price DESC;")
        books = cur.fetchall()
        print_books("가격 25000원 이상 도서 조회 결과", books)
        return books
    except psycopg2.Error as e:
        print(f"가격 조건 조회 오류: {e}")
    finally:
        if cur:
            cur.close()
        if conn:
            conn.close()

def get_book_by_title(title):
    """특정 title을 가진 도서를 조회하고 출력합니다."""
    conn = get_connection()
    if conn is None:
        return

    try:
        cur = conn.cursor()
        # title 조건: title = %s (매개변수 사용)
        cur.execute("SELECT id, title, price FROM books WHERE title = %s;", (title,))
        books = cur.fetchall()
        print_books(f"제목 '{title}' 도서 조회 결과", books)
        return books
    except psycopg2.Error as e:
        print(f"제목으로 조회 오류: {e}")
    finally:
        if cur:
            cur.close()
        if conn:
            conn.close()

## 📌 문제 4 — UPDATE 함수 만들기
def update_second_book_price():
    """
    저장된 순서에서 두 번째 도서의 가격을 27000으로 변경합니다.
    (저장된 순서 = id가 자동 생성된 순서. 일반적으로는 ORDER BY를 명시해야 합니다.)
    여기서는 id의 순서를 기준으로 두 번째 행을 찾습니다.
    """
    conn = get_connection()
    if conn is None:
        return
        
    second_book_uuid = None

    try:
        cur = conn.cursor()
        
        # 1. SELECT 로 두 번째 도서의 UUID를 가져옵니다.
        # UUID는 대개 시간 순서대로 생성되므로, id로 ORDER BY 하면 삽입 순서를 대략적으로 알 수 있습니다.
        cur.execute("SELECT id FROM books ORDER BY id LIMIT 1 OFFSET 1;") # LIMIT 1 OFFSET 1: 두 번째 행 선택
        result = cur.fetchone()
        
        if result:
            second_book_uuid = result[0]
            
            # 2. UPDATE 를 수행합니다.
            update_query = "UPDATE books SET price = 27000 WHERE id = %s;"
            cur.execute(update_query, (second_book_uuid,))
            conn.commit()
            
            # ✨ 출력 예
            print("두 번째 도서 가격이 27000으로 수정되었습니다.")
        else:
            print("조회된 두 번째 도서가 없습니다.")
            
    except psycopg2.Error as e:
        print(f"데이터 수정 오류: {e}")
    finally:
        if cur:
            cur.close()
        if conn:
            conn.close()

## 📌 문제 5 — DELETE 함수 만들기
def delete_third_book():
    """
    저장된 순서에서 세 번째 도서 데이터를 삭제합니다.
    """
    conn = get_connection()
    if conn is None:
        return
        
    third_book_uuid = None

    try:
        cur = conn.cursor()
        
        # 1. SELECT 로 세 번째 도서의 UUID를 가져옵니다.
        # id 순서로 정렬하여 세 번째 행을 선택 (LIMIT 1 OFFSET 2)
        cur.execute("SELECT id FROM books ORDER BY id LIMIT 1 OFFSET 2;")
        result = cur.fetchone()
        
        if result:
            third_book_uuid = result[0]
            
            # 2. DELETE 를 수행합니다.
            delete_query = "DELETE FROM books WHERE id = %s;"
            cur.execute(delete_query, (third_book_uuid,))
            conn.commit()
            
            # ✨ 출력 예
            print("세 번째 도서가 삭제되었습니다.")
        else:
            print("조회된 세 번째 도서가 없습니다.")
            
    except psycopg2.Error as e:
        print(f"데이터 삭제 오류: {e}")
    finally:
        if cur:
            cur.close()
        if conn:
            conn.close()

if '__name__' == '__main__' :
    print("🚀 PostgreSQL books 테이블 관리 작업 시작")
    print("-" * 40)
    
    # 📌 문제 1: 테이블 생성
    create_books_table()
    print("-" * 40)

    # 📌 문제 2: 데이터 삽입
    insert_books()
    print("-" * 40)

    # 📌 문제 3: 조회 함수
    get_all_books() # 전체 조회
    get_expensive_books() # 가격 조건 조회
    get_book_by_title("파이썬 입문") # 제목 조건 조회
    print("-" * 40)
    
    # 📌 문제 4: 데이터 수정
    update_second_book_price()
    get_all_books() # 수정 결과 확인
    print("-" * 40)
    
    # 📌 문제 5: 데이터 삭제
    delete_third_book()
    get_all_books() # 삭제 결과 확인
    
    print("-" * 40)
    print("✅ 모든 작업이 완료되었습니다.")



    