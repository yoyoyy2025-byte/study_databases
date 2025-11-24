{
  "database_task": "PostgreSQL books 테이블 관리",
  "connection_info": {
    "host": "localhost",
    "database": "your_db_name",
    "user": "your_user",
    "password": "your_password"
  },
  "tasks": [
    {
      "id": 1,
      "description": "books 테이블 생성",
      "function_call": "create_books_table()"
    },
    {
      "id": 2,
      "description": "테스트 데이터 삽입",
      "data": [
        {"title": "파이썬 입문", "price": 19000},
        {"title": "알고리즘 기초", "price": 25000},
        {"title": "네트워크 이해", "price": 30000}
      ],
      "function_call": "insert_books()"
    },
    {
      "id": 3.1,
      "description": "전체 도서 조회",
      "function_call": "get_all_books()"
    },
    {
      "id": 3.2,
      "description": "가격이 25000원 이상인 도서 조회",
      "function_call": "get_expensive_books()"
    },
    {
      "id": 3.3,
      "description": "제목으로 도서 조회 ('파이썬 입문')",
      "function_call": "get_book_by_title('파이썬 입문')"
    },
    {
      "id": 4,
      "description": "두 번째 도서 가격 27000으로 수정",
      "function_call": "update_second_book_price()"
    },
    {
      "id": 4.1,
      "description": "수정 후 전체 도서 조회 (검증)",
      "function_call": "get_all_books()"
    },
    {
      "id": 5,
      "description": "세 번째 도서 삭제",
      "function_call": "delete_third_book()"
    },
    {
      "id": 5.1,
      "description": "삭제 후 전체 도서 조회 (검증)",
      "function_call": "get_all_books()"
    }
  ]
}