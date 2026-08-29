CREATE OR ALTER PROCEDURE etl.LoadFactSales
@OldWatermark DATE , @NewWatermark DATE
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO dw.FactSales (OrderID,OrderDateKey,ShipDateKey,ShippingKey,CustomerKey,ProductKey,GeographyKey,Quantity,Sales,Discount,Profit,ShippingCost,OrderPriorityKey)
SELECT s.order_id,od.DateKey,sd.DateKey,sh.ShippingKey,c.CustomerKey,p.ProductKey,g.GeographyKey,s.quantity,s.sales,s.discount,s.profit,s.shipping_cost,op.OrderPriorityID
FROM stg.GlobalSuperstore s INNER JOIN dw.DimDate od ON od.FullDate=s.Clean_order_date
							LEFT JOIN dw.DimDate sd ON od.FullDate = s.Clean_Ship_Date
							INNER JOIN dw.DimCustomer c ON c.CustomerName = s.customer_name
							INNER JOIN dw.DimProduct p ON p.ProductID = s.product_id AND p.ProductName=s.product_name
							INNER JOIN dw.DimGeography g ON g.Market=s.market AND g.Country=s.country AND g.Region=s.region AND g.State=s.state
							INNER JOIN dw.DimShipping sh ON sh.ShipMode=s.ship_mode
							INNER JOIN dw.DimOrderPriority op ON op.OrderPriority=s.order_priority
WHERE s.Clean_order_date>@OldWatermark
AND s.Clean_order_date<=@NewWatermark
AND NOT EXISTS (SELECT 1 FROM  dw.FactSales f INNER JOIN dw.DimProduct dp ON dp.ProductKey=f.ProductKey 
				WHERE f.OrderID=s.order_id AND dp.ProductID=s.product_id);
END;
GO
							