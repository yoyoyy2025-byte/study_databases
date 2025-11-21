
안녕하세요\! 컴퓨터 언어와 데이터베이스(DB)가 처음이시군요. 정말 환영합니다\! 👋

이 문제들은 \*\*SQL(Structured Query Language)\*\*이라는 언어에 대한 문제입니다. 쉽게 말해, \*\*"데이터베이스(창고)에 명령을 내리는 언어"\*\*입니다. 엑셀을 다룰 때 마우스로 클릭하는 작업을, 코드로 작성해서 컴퓨터에게 시킨다고 생각하시면 아주 쉽습니다.

파이썬(Python)을 배우신다면, 파이썬 코드 안에서 이 SQL 명령어를 전송하여 데이터를 다루게 됩니다.

초보자 눈높이에 맞춰 하나씩 아주 쉽게 풀이해 드릴게요.

-----

### 📌 문제 1 — 테이블 생성 (CREATE)

데이터를 담을 \*\*'틀(표, 엑셀 시트)'\*\*을 만드는 작업입니다.

**[해답]**

```sql
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);
```

**[초보자를 위한 해설]**

  * `CREATE TABLE students`: "students"라는 이름의 표를 만들어줘\!
  * `id INT`: id 칸에는 \*\*숫자(Integer)\*\*만 들어갈 거야.
  * `PRIMARY KEY`: **(중요\!)** 이 칸은 주민등록번호처럼 **절대 중복되면 안 되고, 비어있어서도 안 되는 고유한 번호**야.
  * `name VARCHAR(50)`: name 칸에는 \*\*문자(Variable Character)\*\*가 최대 50글자까지 들어갈 수 있어.
  * `age INT`: age 칸에는 숫자가 들어가.

-----

### 📌 문제 2 — 데이터 넣기 (INSERT)

만들어진 표에 \*\*데이터 한 줄(행)\*\*을 추가하는 작업입니다.

**[해답]**

```sql
INSERT INTO students (id, name, age) VALUES (1, '홍길동', 23);
INSERT INTO students (id, name, age) VALUES (2, '이영희', 21);
INSERT INTO students (id, name, age) VALUES (3, '박철수', 26);
```

**[초보자를 위한 해설]**

  * `INSERT INTO students`: students 테이블에 넣어라.
  * `(id, name, age)`: 이 순서대로 데이터를 넣을게.
  * `VALUES (1, '홍길동', 23)`: 각 칸에 맞는 실제 값들이야. (문자는 항상 따옴표 `'`로 감싸야 해요\!)

-----

### 📌 문제 3 — 데이터 조회 (SELECT)

저장된 데이터를 \*\*눈으로 확인(검색)\*\*하는 작업입니다. 가장 많이 쓰입니다.

**[해답]**

**1. 전체 데이터 조회**

```sql
SELECT * FROM students;
```

*(설명: `*`은 "모든 컬럼(All)"을 뜻합니다. 엑셀 파일을 여는 것과 같습니다.)*

**2. 나이가 22세 이상인 학생 조회**

```sql
SELECT * FROM students WHERE age >= 22;
```

*(설명: `WHERE`는 "필터"입니다. 나이가 22보다 크거나 같은(`>=`) 데이터만 보여달라는 뜻입니다.)*

**3. 이름이 "홍길동"인 학생 조회**

```sql
SELECT * FROM students WHERE name = '홍길동';
```

*(설명: 이름이 정확히 '홍길동'과 일치하는(`=`) 데이터만 찾습니다.)*

-----

### 📌 문제 4 — 데이터 수정 (UPDATE)

이미 저장된 내용을 **고치는** 작업입니다.

**[해답]**

```sql
UPDATE students
SET age = 25
WHERE id = 2;
```

**[초보자를 위한 해설]**

  * `UPDATE students`: students 테이블을 고칠게.
  * `SET age = 25`: 나이를 25로 변경해줘.
  * **`WHERE id = 2` (매우 중요\!):** **id가 2번인 친구만** 고쳐줘.
      * ⚠️ 만약 `WHERE`를 빼먹으면? 테이블에 있는 **모든 학생의 나이가 25살로 바뀝니다.** (대참사\!)

-----

### 📌 문제 5 — 데이터 삭제 (DELETE)

데이터를 **지우는** 작업입니다.

**[해답]**

```sql
DELETE FROM students
WHERE id = 3;
```

**[초보자를 위한 해설]**

  * `DELETE FROM students`: students 테이블에서 지울게.
  * `WHERE id = 3`: **id가 3번인 데이터만** 콕 집어서.
      * ⚠️ 여기서도 `WHERE`를 안 쓰면? 학생 명단이 **싹 다 지워집니다.**

-----

### 📌 문제 6 — PRIMARY KEY (에러 찾기 심화)

이 문제는 코드를 실행했을 때 **오류가 나는 상황**을 이해하는 문제입니다.

**[질문에 대한 정답 및 해설]**

**1. 어떤 에러가 발생하는가?**

  * \*\*중복 키 오류 (Duplicate Entry Error)\*\*가 발생합니다.

**2. 왜 발생하는가?**

  * 첫 번째 줄에서 `book_id`를 **1**로 하여 '책 A'를 저장했습니다.
  * 두 번째 줄에서 또다시 `book_id`를 **1**로 하여 '책 B'를 저장하려고 시도했습니다.
  * 하지만 `book_id`는 \*\*PRIMARY KEY(기본키)\*\*로 설정되어 있기 때문에 **똑같은 번호를 두 번 쓸 수 없습니다.**

**3. PRIMARY KEY의 규칙**

  * **유일성 (Unique):** 중복된 값을 가질 수 없다. (모든 데이터는 서로 다른 ID를 가져야 함)
  * **NOT NULL:** 비어있는 값(NULL)을 허용하지 않는다. (ID가 없는 데이터는 존재할 수 없음)

**[🔥 오류를 고치려면?]**
두 번째 책의 번호(ID)를 겹치지 않는 다른 숫자로 바꿔주면 됩니다.

```sql
/* 오류가 있는 원본 코드 */
INSERT INTO books (book_id, title, price) VALUES (1, '책 A', 10000);
INSERT INTO books (book_id, title, price) VALUES (1, '책 B', 15000); -- ❌ 여기서 에러 빵!

/* ✅ 올바르게 고친 코드 (1 -> 2로 변경) */
INSERT INTO books (book_id, title, price) VALUES (1, '책 A', 10000);
INSERT INTO books (book_id, title, price) VALUES (2, '책 B', 15000); -- ⭕ 성공!
```

-----

### 💡 초보자를 위한 꿀팁 요약

1.  **SQL은 순서가 중요해요:** "무엇을(SELECT) - 어디서(FROM) - 어떤 조건으로(WHERE)" 순서로 말한다고 생각하세요.
2.  **PRIMARY KEY는 신분증:** 사람마다 주민번호가 다르듯, 데이터베이스의 각 줄(Row)도 서로 다른 ID를 가져야 컴퓨터가 헷갈리지 않아요.
3.  **WHERE는 안전장치:** 수정(`UPDATE`)하거나 삭제(`DELETE`)할 때 `WHERE`가 없으면 전체가 날아갈 수 있으니 꼭 확인하세요\!

혹시 이해가 안 되거나 더 궁금한 부분이 있으신가요? 파이썬에서 이 SQL을 어떻게 쓰는지 예시를 보여드릴 수도 있습니다. 언제든 물어봐 주세요\!