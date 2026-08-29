CREATE OR ALTER PROCEDURE etl.LoadDimOrderPriority
AS
BEGIN 
SET NOCOUNT ON ;
INSERT INTO dw.DimOrderPriority(OrderPriority)
SELECT DISTINCT s.order_priority 
FROM stg.GlobalSuperstore s
WHERE s.order_priority IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM dw.DimOrderPriority d WHERE d.OrderPriority=s.order_priority
);
END;
GO
