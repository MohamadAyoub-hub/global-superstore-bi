CREATE OR ALTER PROCEDURE etl.ValidateStaging 
AS 
BEGIN 
	SET NOCOUNT ON ;
		IF EXISTS( SELECT 1 FROM stg.GlobalSuperstore WHERE order_id IS NULL OR Clean_order_date IS NULL OR customer_name IS NULL OR product_id IS NULL)
		BEGIN 
				;THROW 50001,'Staging validation failed : critical NULL values found.',1;
		END;
		IF EXISTS (SELECT 1 FROM stg.GlobalSuperstore WHERE quantity<=0)
		BEGIN 
			;THROW 50002,'Staging validation failed : invalid quantity .',1;
		END;
		IF EXISTS (SELECT 1 FROM stg.GlobalSuperstore WHERE sales <0)
		BEGIN 
			;THROW 50003,'Staging validation failed : negative sales.',1;
		END;
		PRINT 'Staging validation PASSED.';
END;
GO