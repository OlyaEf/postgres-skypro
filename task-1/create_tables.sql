-- SQL-команды для создания таблиц
Create table customers (
           customer_id varchar(255) not null primary key,
           company_name varchar(255),
           contact_name varchar(255)
       );

Create table employees (
    employee_id serial primary key,
    first_name varchar(255) not null,
    last_name varchar(255),
    title text,
    birth_date date,
    notes text
);

Create table orders (
    order_id serial primary key,
    customer_id varchar(255) references customers(customer_id),
    employee_id varchar(255) references employees(employee_id),
    order_date date,
    ship_city varchar(255)
);

