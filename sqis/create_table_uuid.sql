UUID primary key 사용

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE TABLE users_uuid_name (
  id_name UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(100)
);

INSERT INTO users_uuid_name (name) VALUES ('Alice');

SELECT id_name, name FROM users_uuid_name;


INSERT INTO users_uuid_name (name)
VALUES
('Alice'),
('Bob'),
('Charlie');

UPDATE users_uuid_name
set name = 'updatedName'
WHERE id_name = 'ffb496a1-a542-46a8-8032-ba968a8dc19b';

DELETE FROM users_uuid_name
WHERE id_name = '0804a668-1c11-47bf-8dba-77baf825e912';