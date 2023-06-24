-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
SELECT c.company_name, concat(e.first_name, ' ', e.last_name) as FIO
FROM customers c
inner join orders o on c.customer_id = o.customer_id
inner join employees e on e.employee_id = o.employee_id
inner join shippers s on o.ship_via = s.shipper_id
where e.city = 'London'
and s.company_name = 'United Package';

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
SELECT p.product_name, p.units_in_stock, s.contact_name, s.phone
FROM products p
join suppliers s on p.supplier_id = s.supplier_id
join categories c on p.category_id= c.category_id
WHERE p.discontinued = 0 and p.units_in_stock < 25
AND (c.category_name='Dairy Products' or c.category_name='Condiments')
ORDER BY p.units_in_stock;

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
SELECT c.company_name
From customers c
WHERE not EXISTS(SELECT * FROM orders where orders.customer_id=c.customer_id);

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
SELECT DISTINCT product_name
FROM products
WHERE exists(
    select quantity from order_details
    where order_details.product_id = products.product_id
    and order_details.quantity = 10
);
