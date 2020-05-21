CREATE TABLE spaces(id SERIAL PRIMARY KEY, name VARCHAR(300), description VARCHAR(2000), 
location VARCHAR(100), available_to DATE, available_from DATE, price INT ); 

ALTER TABLE spaces
ADD COLUMN user_id INT;