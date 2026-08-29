USE [SuperstoreBI]
GO

/****** Object:  StoredProcedure [etl].[LoadDimShipping]    Script Date: 8/29/2026 11:43:02 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER   PROCEDURE [etl].[LoadDimShipping]
AS 
BEGIN 
SET NOCOUNT ON;
INSERT INTO dw.DimShipping(ShipMode)
SELECT DISTINCT s.ship_mode
FROM stg.GlobalSuperstore s
WHERE s.ship_mode IS NOT NULL
AND NOT EXISTS ( SELECT 1 FROM dw.DimShipping d WHERE d.ShipMode=s.ship_mode);
END;
GO

