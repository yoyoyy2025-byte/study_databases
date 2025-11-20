-- CREATE TABLE study_webscripings_database (
--     contents varchar(500),
--     link varchar(500),
--     link_html varchar(500),
--     link_href varchar(500)
-- );

CREATE TABLE study_webscripings_database (
    id VARCHAR(500) PRIMARY KEY,
    contents VARCHAR(500),
    link VARCHAR(500),
    link_html VARCHAR(500),
    link_href VARCHAR(500),
    created_at VARCHAR(500) DEFAULT NOW()
);


SELECT *
FROM study_webscripings_database;