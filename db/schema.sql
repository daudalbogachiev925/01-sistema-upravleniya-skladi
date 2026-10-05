CREATE TABLE warehouses (id SERIAL PRIMARY KEY, name TEXT, address TEXT);
CREATE TABLE cells (id SERIAL PRIMARY KEY, warehouse_id INT REFERENCES warehouses(id),
    code TEXT UNIQUE, capacity INT);
CREATE TABLE products (id SERIAL PRIMARY KEY, sku TEXT UNIQUE, name TEXT,
    unit TEXT, min_stock INT DEFAULT 0);
CREATE TABLE stock (product_id INT, cell_id INT, qty INT DEFAULT 0,
    PRIMARY KEY (product_id, cell_id));
CREATE TABLE movements (id BIGSERIAL PRIMARY KEY, product_id INT, cell_id INT,
    qty INT, kind TEXT CHECK (kind IN ('in','out','move','inv')),
    created TIMESTAMP DEFAULT NOW(), user_id INT);
