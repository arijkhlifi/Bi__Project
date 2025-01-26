-- When Is the Peak month of Our E-Commerce?
SELECT 
    dim_date.OrderMonthName AS MonthName, 
    COUNT(DISTINCT fact_order_item.OrderId) AS TotalOrders
FROM 
    dim_date
JOIN 
    fact_order_item
ON 
    dim_date.DateKey = fact_order_item.DateKey
GROUP BY 
    dim_date.OrderMonthName
ORDER BY 
    TotalOrders DESC;
-- When Is the Peak Season of Our E-Commerce?
SELECT 
    dim_date.Season, 
    COUNT(DISTINCT fact_order_item.OrderId) AS TotalOrders
FROM 
    dim_date
JOIN 
    fact_order_item
ON 
    dim_date.DateKey = fact_order_item.DateKey
GROUP BY 
    dim_date.Season
ORDER BY 
    TotalOrders DESC;

-- What Time Users Are Most Likely Making An Order Or Using The E-Commerce App?
SELECT 
    dim_time.OrderTimeOfDay AS TimeOfDay, 
    COUNT(DISTINCT fact_order_item.OrderId) AS TotalOrders
FROM 
    dim_time
JOIN 
    fact_order_item
ON 
    dim_time.TimeKey = fact_order_item.TimeKey
GROUP BY 
    dim_time.OrderTimeOfDay
ORDER BY 
    TotalOrders DESC;

-- What Is The Preferred Way To Pay In The E-Commerce?
SELECT 
    dim_payment.PaymentType AS PaymentType, 
    COUNT(dim_payment.PaymentType) AS TotalOrders
FROM 
    dim_payment
JOIN 
    fact_order_item
ON 
    dim_payment.PaymentID = fact_order_item.PaymentID
GROUP BY 
    dim_payment.PaymentType
ORDER BY 
    TotalOrders DESC;

-- What Is The Frequency Of Purchase In Each State?
SELECT 
    dim_users.UserState AS UserState,
    COUNT(DISTINCT fact_order_item.OrderId) * 1.0 / COUNT(DISTINCT fact_order_item.UserID) AS PurchaseFrequency
FROM 
    fact_order_item
LEFT JOIN 
    dim_users
ON 
    fact_order_item.UserID = dim_users.UserID
GROUP BY 
    dim_users.UserState
ORDER BY 
    PurchaseFrequency DESC;

-- Which Logistic Route Has Heavy Traffic In Our E-Commerce? (Web Traffic)
SELECT 
    CONCAT(dim_sellers.SellerState, ', ', dim_sellers.SellerCity, ' ==> ', dim_users.UserState, ', ', dim_users.UserCity) AS LogisticRoute,
    COUNT(DISTINCT fact_order_item.OrderId) AS TotalOrders
FROM 
    fact_order_item
JOIN 
    dim_users
ON 
    dim_users.UserID = fact_order_item.UserID
JOIN 
    dim_sellers
ON 
    dim_sellers.SellerID = fact_order_item.SellerID
GROUP BY 
    dim_sellers.SellerState, dim_sellers.SellerCity, dim_users.UserState, dim_users.UserCity
ORDER BY 
    TotalOrders DESC
LIMIT 10;
