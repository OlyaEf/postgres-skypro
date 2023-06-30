-- 1. Создать таблицу student с полями student_id serial, first_name varchar, last_name varchar, birthday date, phone varchar
CREATE TABLE student (
    student_id serial,
    first_name varchar(80),
    last_name varchar(80),
    birthday date,
    phone varchar(20)
                     );

-- 2. Добавить в таблицу student колонку middle_name varchar
alter table student add column middle_name varchar (80);

-- 3. Удалить колонку middle_name
alter table student drop column middle_name;

-- 4. Переименовать колонку birthday в birth_date
alter table student rename column birthday to birth_date;

-- 5. Изменить тип данных колонки phone на varchar(32)
alter table student alter column phone set data type varchar(32);

-- 6. Вставить три любых записи с автогенерацией идентификатора
INSERT INTO student (student_id, first_name, last_name, birthday, phone)
VALUES (2, 'Имя1', 'Фамилия1', '2000-01-01', '1234567890'),
       (3, 'Имя2', 'Фамилия2', '2000-02-02', '0987654321'),
       (4, 'Имя3', 'Фамилия3', '2000-03-03', '9876543210');

-- 7. Удалить все данные из таблицы со сбросом идентификатор в исходное состояние
TRUNCATE TABLE student restart identity cascade;
