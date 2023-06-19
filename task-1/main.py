"""Скрипт для заполнения данными таблиц в БД Postgres."""
from psycopg2 import connect
from datetime import datetime


def clear_table(conn, table_name):
    cur = conn.cursor()

    if table_name == 'customers':
        # Удаление связанных записей из таблицы orders
        cur.execute('DELETE FROM orders WHERE customer_id IN (SELECT customer_id FROM customers);')

    cur.execute(f'DELETE FROM {table_name};')
    conn.commit()
    cur.close()


def read_data(filename):
    with open(filename, 'r') as f:
        return f.read().split('\n')[1:]


def write_customers_data_to_db(conn, data):
    cur = conn.cursor()
    for el in data:
        cur.execute(
            'INSERT INTO customers (customer_id, company_name, contact_name)'
            'VALUES (%s, %s, %s)', el)
    conn.commit()
    cur.close()


def write_employees_data_to_db(conn, data):
    cur = conn.cursor()
    for el in data:
        employee_id, first_name, last_name, title, birth_date, notes = el[:6]

        # Проверка корректности формата даты
        try:
            birth_date = datetime.strptime(birth_date, '%Y-%m-%d').date()
        except ValueError:
            birth_date = None

        cur.execute(
            'INSERT INTO employees (employee_id, first_name, last_name, title, birth_date, notes) '
            'VALUES (%s, %s, %s, %s, %s, %s)',
            (employee_id, first_name, last_name, title, birth_date, notes)
        )
    conn.commit()
    cur.close()


def write_orders_data_to_db(conn, data):
    cur = conn.cursor()
    for el in data:
        cur.execute(
            'INSERT INTO orders (order_id, customer_id, employee_id, order_date, ship_city)'
            'VALUES (%s, %s, %s, %s, %s)', el)
    conn.commit()
    cur.close()


def connect_to_db():
    conn = connect(
        host='localhost',
        port=5432,
        user='postgres',
        password='postgres',
        database='north'
    )
    return conn


if __name__ == '__main__':
    con = connect_to_db()

    # Очистка таблиц перед записью
    clear_table(con, 'customers')
    clear_table(con, 'employees')
    clear_table(con, 'orders')

    # Заполнение таблицы customers
    data = read_data('north_data/customers_data.csv')
    data = [el.split(',') for el in data if el]
    write_customers_data_to_db(con, data)

    # Заполнение таблицы employees
    data_employees = read_data('north_data/employees_data.csv')
    data_employees = [el.replace('"', '').split(',') for el in data_employees if el]
    write_employees_data_to_db(con, data_employees)

    # Заполнение таблицы orders
    data_orders = read_data('north_data/orders_data.csv')
    data_orders = [el.split(',') for el in data_orders if el]
    write_orders_data_to_db(con, data_orders)

    con.close()

