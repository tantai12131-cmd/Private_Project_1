-- ============================================================
-- COFFEE SHOP DATABASE - CREATE TABLES
-- Project: Restaurant Cost Management Optimization
-- Author: [Your Name]
-- Date: 2024
-- ============================================================
-- Run this file FIRST before importing any CSV data.
-- Order matters: parent tables before child tables (FK constraints).
-- ============================================================
/* XÓA HẾT CÁI CŨ NẾU LỖI (BỎ QUa)
DROP TABLE IF EXISTS recipes CASCADE;
DROP TABLE IF EXISTS inventory CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS shift CASCADE;
DROP TABLE IF EXISTS ingredients CASCADE;
DROP TABLE IF EXISTS items CASCADE;
DROP TABLE IF EXISTS rota CASCADE;
DROP TABLE IF EXISTS staff CASCADE;
*/

-- ------------------------------------------------------------
-- 1. ITEMS
-- Parent table: referenced by orders, recipes
-- ------------------------------------------------------------
CREATE TABLE items (
    item_id     TEXT        PRIMARY KEY,
    sku         TEXT        NOT NULL,
    item_name   TEXT        NOT NULL,
    item_cat    TEXT,
    item_size   TEXT,
    item_price  NUMERIC(6,2),
    currency    TEXT
);


-- ------------------------------------------------------------
-- 2. INGREDIENTS
-- Parent table: referenced by recipes, inventory
-- ------------------------------------------------------------
CREATE TABLE ingredients (
    ing_id      TEXT        PRIMARY KEY,
    ing_name    TEXT        NOT NULL,
    ing_weight  INT,
    ing_meas    TEXT,
    ing_price   NUMERIC(8,2),
    currency    TEXT
);


-- ------------------------------------------------------------
-- 3. ORDERS
-- References: items(item_id)
-- ------------------------------------------------------------
CREATE TABLE orders (
    row_id      INT         PRIMARY KEY,
    order_id    TEXT        NOT NULL,
    created_at  TIMESTAMP   NOT NULL,
    item_id     TEXT        REFERENCES items(item_id),
    quantity    INT,
    cust_name   TEXT,
    in_or_out   TEXT        CHECK (in_or_out IN ('in', 'out', 'unknown'))
);


-- ------------------------------------------------------------
-- 4. RECIPES
-- References: items(sku via recipe_id), ingredients(ing_id)
-- Note: recipe_id matches the SKU column in items table
-- ------------------------------------------------------------
CREATE TABLE recipes (
    row_id      INT         PRIMARY KEY,
    recipe_id   TEXT        NOT NULL,
    ing_id      TEXT        REFERENCES ingredients(ing_id),
    quantity    NUMERIC(8,2)
);


-- ------------------------------------------------------------
-- 5. INVENTORY
-- References: ingredients(ing_id)
-- ------------------------------------------------------------
CREATE TABLE inventory (
    inv_id      TEXT        PRIMARY KEY,
    ing_id      TEXT        REFERENCES ingredients(ing_id),
    quantity    INT
);


-- ------------------------------------------------------------
-- 6. STAFF
-- Parent table: referenced by rota
-- ------------------------------------------------------------
CREATE TABLE staff (
    staff_id        TEXT        PRIMARY KEY,
    first_name      TEXT        NOT NULL,
    last_name       TEXT        NOT NULL,
    position        TEXT,
    sal_per_hour    NUMERIC(6,2)
);


-- ------------------------------------------------------------
-- 7. SHIFT
-- Parent table: referenced by rota
-- Note: start_time/end_time stored as TIME
-- Excel exports these as decimal fractions (e.g. 0.291 = 07:00)
-- → Convert during COPY import using a staging approach (see import file)
-- ------------------------------------------------------------
CREATE TABLE shift (
    shift_id        TEXT        PRIMARY KEY,
    day_of_week     TEXT        NOT NULL,
    start_time      TIME        NOT NULL,
    end_time        TIME        NOT NULL
);


-- ------------------------------------------------------------
-- 8. ROTA
-- References: shift(shift_id), staff(staff_id)
-- ------------------------------------------------------------
CREATE TABLE rota (
    row_id      INT         PRIMARY KEY,
    rota_id     TEXT        NOT NULL,
    date        DATE        NOT NULL,
    shift_id    TEXT        REFERENCES shift(shift_id),
    staff_id    TEXT        REFERENCES staff(staff_id)
);


-- ============================================================
-- VERIFY: Run after creation to confirm all tables exist
-- ============================================================
-- SELECT table_name FROM information_schema.tables
-- WHERE table_schema = 'public'
-- ORDER BY table_name;