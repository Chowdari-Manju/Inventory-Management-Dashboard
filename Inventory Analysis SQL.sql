-- ============================================================
-- INVENTORY ANALYSIS PROJECT
-- Database: PostgreSQL
-- Tool: pgAdmin 4
-- ============================================================


-- ============================================================
-- 1. CREATE INVENTORY TABLE
-- ============================================================

CREATE TABLE inventory (
    inventory_id VARCHAR(10),
    product_id VARCHAR(10),
    product_name VARCHAR(100),
    category VARCHAR(50),
    supplier VARCHAR(100),
    stock_quantity INT,
    reorder_level INT,
    unit_cost NUMERIC(10,2),
    sales_quantity INT,
    warehouse VARCHAR(50),
    order_date DATE
);


-- ============================================================
-- 2. TOTAL STOCK QUANTITY
-- Purpose: Calculate the total quantity of inventory in stock.
-- ============================================================

SELECT SUM(stock_quantity) AS total_stock
FROM inventory;


-- ============================================================
-- 3. LOW STOCK PRODUCTS
-- Purpose: Identify products that are below their reorder level.
-- ============================================================

SELECT product_name, stock_quantity, reorder_level
FROM inventory
WHERE stock_quantity < reorder_level;


-- ============================================================
-- 4. TOTAL INVENTORY VALUE
-- Purpose: Calculate the total monetary value of current stock.
-- ============================================================

SELECT SUM(stock_quantity * unit_cost) AS total_inventory_value
FROM inventory;


-- ============================================================
-- 5. INVENTORY VALUE BY CATEGORY
-- Purpose: Analyze inventory value across product categories.
-- ============================================================

SELECT 
    category,
    SUM(stock_quantity * unit_cost) AS inventory_value
FROM inventory
GROUP BY category
ORDER BY inventory_value DESC;


-- ============================================================
-- 6. TOTAL STOCK BY WAREHOUSE
-- Purpose: Compare stock quantities across warehouses.
-- ============================================================

SELECT 
    warehouse,
    SUM(stock_quantity) AS total_stock
FROM inventory
GROUP BY warehouse
ORDER BY total_stock DESC;


-- ============================================================
-- 7. TOP 10 PRODUCTS BY INVENTORY VALUE
-- Purpose: Identify the products with the highest inventory value.
-- ============================================================

SELECT
    product_name,
    category,
    stock_quantity,
    unit_cost,
    stock_quantity * unit_cost AS inventory_value
FROM inventory
ORDER BY inventory_value DESC
LIMIT 10;


-- ============================================================
-- 8. INVENTORY VALUE BY WAREHOUSE
-- Purpose: Analyze the monetary value of inventory by warehouse.
-- ============================================================

SELECT
    warehouse,
    SUM(stock_quantity * unit_cost) AS inventory_value
FROM inventory
GROUP BY warehouse
ORDER BY inventory_value DESC;


-- ============================================================
-- 9. INVENTORY VALUE BY SUPPLIER
-- Purpose: Analyze the inventory value associated with each supplier.
-- ============================================================

SELECT
    supplier,
    SUM(stock_quantity * unit_cost) AS inventory_value
FROM inventory
GROUP BY supplier
ORDER BY inventory_value DESC;


-- ============================================================
-- 10. SALES BY CATEGORY
-- Purpose: Compare total sales quantities across categories.
-- ============================================================

SELECT
    category,
    SUM(sales_quantity) AS total_sales
FROM inventory
GROUP BY category
ORDER BY total_sales DESC;


-- ============================================================
-- END OF INVENTORY ANALYSIS SQL
-- ============================================================