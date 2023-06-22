-- Напишите запросы, которые выводят следующую информацию:
-- 1. "имя контакта" и "город" (contact_name, country) из таблицы customers (только эти две колонки)
SELECT contact_name, country
FROM customers;

-- 2. идентификатор заказа и разницу между датами формирования (order_date) заказа и его отгрузкой (shipped_date) из таблицы orders
SELECT order_id, shipped_date - order_date AS date_differential
FROM orders;

-- 3. все города без повторов, в которых зарегистрированы заказчики (customers)
SELECT DISTINCT country FROM customers

-- 4. количество заказов (таблица orders)
SELECT COUNT(*) oder_id FROM orders;

SELECT COUNT(*) AS order_count
FROM orders;

-- 5. количество стран, в которые отгружался товар (таблица orders, колонка ship_country)
SELECT COUNT(DISTINCT ship_country) AS country_count
FROM orders
WHERE ship_country is not null;