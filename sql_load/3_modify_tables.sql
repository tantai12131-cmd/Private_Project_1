-- ============================================================
-- COFFEE SHOP DATABASE - IMPORT CSV DATA
-- Run AFTER 01_create_tables.sql
-- ============================================================
-- IMPORTANT: Thay 'C:/your/path/to/' bằng đường dẫn thực tế
-- đến folder chứa các file CSV của bạn.
-- Windows dùng dấu / (không phải \)
-- Ví dụ: 'C:/Users/YourName/Desktop/coffee_shop_clean/'
-- ============================================================


-- ------------------------------------------------------------
-- 1. ITEMS
-- ------------------------------------------------------------
COPY items (item_id, sku, item_name, item_cat, item_size, item_price, currency)
FROM 'D:\Course Luke Youtube\Private_Project_1\csv_file\items.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


-- ------------------------------------------------------------
-- 2. INGREDIENTS
-- ------------------------------------------------------------
COPY ingredients (ing_id, ing_name, ing_weight, ing_meas, ing_price, currency)
FROM 'D:\Course Luke Youtube\Private_Project_1\csv_file\ingredients.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


-- ------------------------------------------------------------
-- 3. ORDERS
-- ------------------------------------------------------------
COPY orders (row_id, order_id, created_at, item_id, quantity, cust_name, in_or_out)
FROM 'D:\Course Luke Youtube\Private_Project_1\csv_file\orders.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


-- ------------------------------------------------------------
-- 4. RECIPES
-- ------------------------------------------------------------
COPY recipes (row_id, recipe_id, ing_id, quantity)
FROM 'D:\Course Luke Youtube\Private_Project_1\csv_file\recipes(1).csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


-- ------------------------------------------------------------
-- 5. INVENTORY
-- ------------------------------------------------------------
COPY inventory (inv_id, ing_id, quantity)
FROM 'D:\Course Luke Youtube\Private_Project_1\csv_file\inventory.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


-- ------------------------------------------------------------
-- 6. STAFF
-- ------------------------------------------------------------
COPY staff (staff_id, first_name, last_name, position, sal_per_hour)
FROM 'D:\Course Luke Youtube\Private_Project_1\csv_file\staff.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


-- ------------------------------------------------------------
-- 7. SHIFT (xử lý đặc biệt vì time bị lưu dạng số thập phân)

COPY shift (shift_id, day_of_week, start_time, end_time)
FROM 'D:\Course Luke Youtube\Private_Project_1\csv_file\shift.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


-- ------------------------------------------------------------
-- 8. ROTA
-- ------------------------------------------------------------
COPY rota (row_id, rota_id, date, shift_id, staff_id)
FROM 'D:\Course Luke Youtube\Private_Project_1\csv_file\rota.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


-- ============================================================
-- VERIFY: Kiểm tra số dòng sau khi import
-- ============================================================
SELECT 'orders'       AS table_name, COUNT(*) AS row_count FROM orders
UNION ALL
SELECT 'items',       COUNT(*) FROM items
UNION ALL
SELECT 'recipes',     COUNT(*) FROM recipes
UNION ALL
SELECT 'ingredients', COUNT(*) FROM ingredients
UNION ALL
SELECT 'inventory',   COUNT(*) FROM inventory
UNION ALL
SELECT 'staff',       COUNT(*) FROM staff
UNION ALL
SELECT 'shift',       COUNT(*) FROM shift
UNION ALL
SELECT 'rota',        COUNT(*) FROM rota
ORDER BY table_name;






SELECT *
FROM items
SELECT *
FROM ingredients
SELECT *
FROM inventory
SELECT *
FROM orders
SELECT *
FROM recipes
SELECT *
FROM rota
SELECT *
FROM shift
SELECT *
FROM staff
