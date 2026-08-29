CREATE TABLE dw.FactSales
(
SalesKey BIGINT IDENTITY(1,1) PRIMARY KEY,
OrderID VARCHAR(100) NOT NULL ,
OrderDateKey INT NOT NULL,
ShipDateKey INT NOT NULL,
ShippingKey INT NOT NULL,
CustomerKey INT NOT NULL,
ProductKey INT NOT NULL,
GeographyKey INT NOT NULL,
Quantity INT,
Sales DECIMAL(10,2) ,
Discount DECIMAL(5,2),
Profit DECIMAL(18,2),
ShippingCost DECIMAL(18,2),
OrderPriorityKey INT NOT NULL
);

INSERT INTO dw.FactSales
(OrderID,OrderDateKey,ShipDateKey,ShippingKey,CustomerKey,ProductKey,GeographyKey,Quantity,Sales,Discount,Profit,ShippingCost,OrderPriorityKey)
SELECT s.order_id,d1.DateKey,d2.DateKey,sh.ShippingKey,c.CustomerKey,p.ProductKey,g.GeographyKey,s.quantity,s.sales,s.discount,s.profit,s.shipping_cost,op.OrderPriorityID
FROM stg.GlobalSuperstore s
LEFT JOIN dw.DimDate d1 ON s.Clean_order_date=d1.FullDate
LEFT JOIN dw.DimDate d2 ON s.Clean_Ship_Date=d2.FullDate
LEFT JOIN dw.DimProduct p ON s.product_id=p.ProductID AND s.product_name=p.ProductName
LEFT JOIN dw.DimCustomer c ON s.customer_name=c.CustomerName AND (s.segment =c.Segment OR (s.segment IS NULL AND c.Segment IS NULL))
LEFT JOIN dw.DimShipping sh ON s.ship_mode=sh.ShipMode
LEFT JOIN dw.DimGeography g ON s.market=g.Market AND s.region=g.Region AND s.country=g.Country AND s.state=g.State
LEFT JOIN dw.DimOrderPriority op ON s.order_priority =op.OrderPriority;