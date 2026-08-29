CREATE OR ALTER PROCEDURE etl.LoadDimCustomer
AS
BEGIN 
SET NOCOUNT ON ;
INSERT INTO dw.DimCustomer( CustomerName,Segment)
SELECT DISTINCT s.customer_name,s.segment
FROM stg.GlobalSuperstore s 
WHERE s.customer_name IS NOT NULL AND NOT EXISTS(SELECT 1 FROM dw.DimCustomer d WHERE d.CustomerName =s.customer_name );
END;
GO