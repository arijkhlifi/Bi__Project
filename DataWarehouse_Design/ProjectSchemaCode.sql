USE BI_Project;
DROP TABLE IF EXISTS fact_order_item;
DROP TABLE IF EXISTS dim_users;
-- Create Dimension Table: Users
CREATE TABLE dim_users (
    UserID VARCHAR(255) PRIMARY KEY,
    UserZIPCode INT,
    UserCity VARCHAR(255),
    UserState VARCHAR(255)
);

DROP TABLE IF EXISTS dim_sellers;
-- Create Dimension Table: Sellers
CREATE TABLE dim_sellers (
    SellerID VARCHAR(255) PRIMARY KEY,
    SellerZIPCode INT,
    SellerCity VARCHAR(255),
    SellerState VARCHAR(255)
);

DROP TABLE IF EXISTS dim_products;
-- Create Dimension Table: Products
CREATE TABLE dim_products (
    ProductID VARCHAR(255) PRIMARY KEY,
    ProductCategory VARCHAR(255),
    ProductNameLength DECIMAL(10, 3),
    ProductDescriptionLength DECIMAL(10, 2),
    ProductPhotosQuantity INT,
    ProductWeight DECIMAL(10, 2),
    ProductLength DECIMAL(10, 3),
    ProductHeight DECIMAL(10, 2),
    ProductWidth DECIMAL(10, 2)
);

DROP TABLE IF EXISTS dim_feedback;
-- Create Dimension Table: Feedback
CREATE TABLE dim_feedback (
    FeedbackID VARCHAR(255) PRIMARY KEY,
    FeedbackScore INT,
    FeedbackFromSentDate DATE,
    FeedbackAnswerDate DATE
);

DROP TABLE IF EXISTS dim_payment;
-- Create Dimension Table: Payment
CREATE TABLE dim_payment (
  PaymentID VARCHAR(255) PRIMARY KEY,
  PaymentSequential INT,
  PaymentType VARCHAR(255),
  PaymentInstallments INT,
  PaymentValue DECIMAL(10, 2)
);

 DROP TABLE IF EXISTS dim_date;
-- Create Dimension Table: Dates
CREATE TABLE dim_date (
    DateKey DATE PRIMARY KEY,
    OrderYear INT,
    OrderMonth INT(2),
    OrderMonthName VARCHAR(10),
    OrderDay VARCHAR(10),
    Season VARCHAR(20),
    OrderQuarter VARCHAR(2)
);

DROP TABLE IF EXISTS dim_time;
-- Create Dimension Table: Times
CREATE TABLE dim_time (
    TimeKey TIME PRIMARY KEY,
    OrderHour INT,
    OrderMinute INT,
    OrderSecond INT,
    AM_PM VARCHAR(2),
    OrderTimeOfDay VARCHAR(20)
);

DROP TABLE IF EXISTS dim_orders;
-- Create Dimension Table: Orders
CREATE TABLE dim_orders (
    OrderId VARCHAR(255) PRIMARY KEY,
    OrderStatus VARCHAR(20),
    OrderDate DATE,
    OrderTime TIME,
    OrderApprovedDate DATE,
    OrderApprovedTime TIME,
    OrderPickupDate DATE,
    OrderPickupTime TIME,
    OrderDeliveredDate DATE,
    OrderDeliveredTime TIME,
    EstimatedDeliveryDate DATE,
    EstimatedDeliveryTime TIME
);

-- Create Fact Table: Order Items
CREATE TABLE fact_order_item(
    OrderItemID INT PRIMARY KEY,
    OrderId VARCHAR(255),
    ProductID VARCHAR(255),
    UserID VARCHAR(255),
    SellerID VARCHAR(255),
	FeedbackID VARCHAR(255),
    PaymentID VARCHAR(255),
    DateKey DATE,
    TimeKey Time,
    ShippingDays INT,
	ShippingCost DECIMAL(10, 2),
    Price DECIMAL(10, 2),
	FOREIGN KEY (OrderID) REFERENCES dim_orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES dim_products(ProductID),
    FOREIGN KEY (SellerID) REFERENCES dim_sellers(SellerID),
    FOREIGN KEY (UserID) REFERENCES dim_users(UserID),
    FOREIGN KEY (FeedbackID) REFERENCES dim_feedback(FeedbackID),
	FOREIGN KEY (PaymentID) REFERENCES dim_payment(PaymentID),
    FOREIGN KEY (DateKey) REFERENCES dim_date(DateKey),
    FOREIGN KEY (TimeKey) REFERENCES dim_time(TimeKey)
);