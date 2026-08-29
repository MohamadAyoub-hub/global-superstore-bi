 CREATE OR ALTER PROCEDURE etl.LoadDimGeography
AS 
BEGIN 
SET NOCOUNT ON ;
INSERT INTO dw.DimGeography ( Market,Country,Region,State)
SELECT DISTINCT 
s.market,s.country,s.region,s.state
FROM stg.GlobalSuperstore s
WHERE NOT EXISTS(SELECT 1 FROM dw.DimGeography d WHERE d.Market=s.market AND d.Country=s.country AND d.Region=s.region AND d.State=s.state);
END;
GO