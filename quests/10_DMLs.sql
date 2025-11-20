-- -- 1번 문제

-- -- CREATE TABLE news_articles (
-- --     id INT PRIMARY KEY,          -- 고유 식별 컬럼
-- --     title VARCHAR(500),
-- --     url VARCHAR(500),
-- --     author VARCHAR(500),
-- --     published_at VARCHAR(500)    -- 날짜도 문자열로 처리
-- -- );

-- SELECT *
-- FROM news_articles;


-- -- SELECT * FROM news_articles
-- -- WHERE author = '홍길동'

-- INSERT INTO news_articles (id, title, url, author, published_at)
-- --  VALUES (1,'AI 시대 도래', 'https://news.com/ai', '홍길동', '2025-01-01');
-- --  VALUES (2,'경제 성장률 상승', 'https://news.com/economy', '이영희', '2025-01-05');

-- UPDATE news_articles
-- SET title = '새로운 문자열'
-- WHERE id = 1;

-- DELETE FROM news_articles WHERE id = 2;

-- -- 2번 문제
--  CREATE TABLE web_links (
--      id INT PRIMARY KEY,          
--      link_text VARCHAR(500),
--      link_url VARCHAR(500),
--      category VARCHAR(500)  
--  );


--   INSERT INTO web_links (id, link_text, link_url, category)
--   VALUES (1,'네이버', 'https://naver.com', 'portal'),
--          (2,'구글', 'https://google.com', 'portal'),
--          (3,'깃허브', 'https://github.com', 'dev');

--           SELECT * FROM web_links
--  WHERE category = 'portal'

-- UPDATE web_links
--  SET category = 'code'
--  WHERE id = 3;


--  DELETE FROM web_links WHERE link_text = '네이버';

-- --3번 문제

--  CREATE TABLE  scraping_html_results (
--      id INT PRIMARY KEY,          
--      page_title VARCHAR(500),
--      page_url VARCHAR(500),
--      html_length  INT,
--      status_code  INT  
--  );

--    INSERT INTO scraping_html_results (id, page_title, page_url, html_length, status_code)
--   VALUES (1,'홈페이지', 'https://site.com', 15700, 200),
--          (2,'블로그', 'https://blog.com', 9800, 200),
--          (3,'404 페이지', 'https://site.com/notfound', 0, 404);


--           SELECT * FROM scraping_html_results
--           WHERE status_code = '200';
 
-- UPDATE scraping_html_results
--  SET html_length = '12000'
--  WHERE id = 2;

--  DELETE FROM scraping_html_results WHERE status_code = '404';

--  4번 문제

--  CREATE TABLE keyword_search_logs (
--      id INT PRIMARY KEY,          
--      keyword VARCHAR(500),
--      result_count INT,
--      search_time VARCHAR(500)  
--  );

--    INSERT INTO keyword_search_logs (id, keyword, result_count, search_time)
--   VALUES (1,'python', 120,'2025-11-19 10:00:00'),
--          (2,'chatgpt', 300, '2025-11-19 10:05:00'),
--          (3,'docker', 90,'2025-11-19 10:10:00');


--           SELECT * FROM keyword_search_logs
--           WHERE result_count >= 100;


-- UPDATE keyword_search_logs
--  SET result_count = 150
--  WHERE id = 3;          


--  DELETE FROM keyword_search_logs WHERE keyword = 'python';

--5번 문제

 CREATE TABLE shop_products (
     id INT PRIMARY KEY,          
     name VARCHAR(500),
     price INT,
     stock INT,  
     category VARCHAR(500)  
 );

   INSERT INTO shop_products (id, name, price, stock, category)
  VALUES (1,'USB 메모리', 12000, 50, '전자제품'),
         (2,'블루투스 스피커', 45000, 20, '전자제품'),
         (3,'물병', 5000, 100, '생활용품');


SELECT * FROM shop_products
WHERE price >= 10000;


UPDATE shop_products
 SET stock = 80
 WHERE id = 3;   

  DELETE FROM shop_products WHERE name = '블루투스 스피커';