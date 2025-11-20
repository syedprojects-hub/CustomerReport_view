--- Create a reusable customer analytics view
CREATE VIEW CUSTOMER_REPORT AS

-- Step 1: Base query — join sales and customers, calculate age
WITH base_query AS (
    SELECT 
        f.order_number,               -- Unique order ID
        f.product_key,                -- Product purchased
        f.order_date,                 -- Date of purchase
        f.sales_amount,               -- Revenue from the order
        f.quantity,                   -- Quantity purchased
        c.customer_key,               -- Customer identifier
        c.customer_number,            -- Customer number
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name, -- Full name
        TIMESTAMPDIFF(YEAR, c.birthdate, CURDATE()) AS age       -- Customer age
    FROM sales f
    LEFT JOIN customers c
        ON c.customer_key = f.customer_key
    WHERE f.order_date IS NOT NULL    -- Filter valid orders
),

-- Step 2: Aggregate customer-level metrics
customer_aggregation AS (
    SELECT 
        customer_key,
        customer_number,
        customer_name,
        age,
        COUNT(DISTINCT order_number) AS total_orders,     -- Total purchases
        SUM(sales_amount) AS total_sales,                 -- Total revenue per customer
        SUM(quantity) AS total_quantity,                  -- Total units bought
        COUNT(DISTINCT product_key) AS total_products,    -- Product variety
        MAX(order_date) AS last_order_date,               -- Most recent purchase
        TIMESTAMPDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan -- First-to-last order months
    FROM base_query
    GROUP BY 
        customer_key,
        customer_number,
        customer_name,
        age
)

-- Step 3: Final customer segmentation & metrics
SELECT 
    customer_key,
    customer_number,
    customer_name,
    age,

    -- Age-group classification
    CASE 
        WHEN age < 20 THEN 'Under 20'
        WHEN age BETWEEN 20 AND 39 THEN 'Young'
        ELSE 'Old'
    END AS age_group,

    -- Customer lifecycle segmentation
    CASE 
        WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'      -- Long relationship + high spend
        WHEN lifespan >= 12 AND total_sales < 5000 THEN 'Regular'  -- Long relationship + low/medium spend
        ELSE 'New'                                                 -- Less than 1 year
    END AS customer_group,

    total_orders,                -- Purchase count
    total_sales,                 -- Total revenue
    total_quantity,              -- Total units purchased
    total_products,              -- Distinct products purchased
    last_order_date,             -- Last purchase date
    lifespan,                    -- Total months between first & last purchase

    TIMESTAMPDIFF(MONTH, last_order_date, CURDATE()) AS recency,  -- Months since last order

    -- Average order value
    CASE 
        WHEN total_sales = 0 THEN 0
        ELSE total_sales / total_orders
    END AS avg_order_value,

    -- Average monthly spend across active lifespan
    CASE 
        WHEN lifespan = 0 THEN total_sales
        ELSE total_sales / lifespan
    END AS avg_monthly_spend

FROM customer_aggregation;
