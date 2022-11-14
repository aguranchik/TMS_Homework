#удалить базу данных
DROP DATABASE test;

# создать базу данных
CREATE DATABASE test;

# использовать базу данных
USE test;

# создать таблицы
CREATE TABLE User (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL 
);

CREATE TABLE PersonalData (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    age TINYINT UNSIGNED,
    email VARCHAR(50) UNIQUE NOT NULL 
); 

# заполнить таблицы
INSERT INTO User (username, password, email) VALUES ('Ivanov', sha1('12345678'), 'ivanov@test.by');
INSERT INTO User (username, password, email) VALUES ('Petrov', sha1('12345679'), 'petrov@test.by');
INSERT INTO User (username, password, email) VALUES ('Sidorov', sha1('12345689'), 'sidorov@test.by');
INSERT INTO User (username, password, email) VALUES ('Yankovich', sha1('12345689'), 'yankovich@test.by');
INSERT INTO User (username, password, email) VALUES ('Kischyk', sha1('12345789'), 'kischyk@test.by');

INSERT INTO PersonalData (name, surname, age, email) VALUES ('Ivan', 'Ivanov', '34', 'ivanov@test.by');
INSERT INTO PersonalData (name, surname, age, email) VALUES ('Petr', 'Petrov', 54, 'petrov@test.by');
INSERT INTO PersonalData (name, surname, age, email) VALUES ('Sidor', 'Sidorov', 23, 'sidorov@test.by');
INSERT INTO PersonalData (name, surname, age, email) VALUES ('Yan', 'Yankovich', 43, 'yankovich@test.by');
INSERT INTO PersonalData (name, surname, age, email) VALUES ('Ivan', 'Kischyk', 33, 'kischyk@test.by');

# Вывести данные из первой таблицы в виде отсортированных по username данных
SELECT * FROM User ORDER BY 'username';

# Вывести username и age пользователей с сортировку по age
SELECT U.* FROM (SELECT username,age FROM PersonalData,User WHERE PersonalData.email=User.email) AS U ORDER BY U.age;

# Вывести все данные пользователей из обеих таблиц в одном output
SELECT * FROM PersonalData,User WHERE PersonalData.email=User.email