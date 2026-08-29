CREATE OR ALTER PROCEDURE etl.LoadDimProduct
AS
BEGIN 
SET NOCOUNT ON ;
 INSERT INTO dw.DimProduct
 (ProductID,ProductName,Category,SubCategory)
 SELECT DISTINCT s.product_id,s.product_name,s.category,s.sub_category
 FROM stg.GlobalSuperstore s WHERE product_id IS NOT NULL AND NOT EXISTS(SELECT 1 FROM dw.DimProduct d WHERE d.ProductID=s.product_id AND d.ProductName=s.product_name);
 END;
 GO