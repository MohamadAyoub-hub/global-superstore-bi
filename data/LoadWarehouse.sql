CREATE OR ALTER PROCEDURE etl.LoadWarehouse
AS 
BEGIN 
	SET NOCOUNT ON;
	SET XACT_ABORT ON;
	DECLARE @StartTime DATETIME2 = SYSDATETIME();
	DECLARE @OldWatermark DATE;
	DECLARE @NewWatermark DATE;
	DECLARE @RowsProcessed INT;
	BEGIN TRY 
		-- 1 LOG Start
		INSERT INTO etl.ETLLog(ProcessName,StartTime,Status)
		VALUES ('LoadWarhouse',@StartTime,'RUNNING');
		--2 Transaction
		BEGIN TRANSACTION;
		--3 Get Old WaterMark
		SELECT
			@OldWatermark = WatermarkValue
		FROM etl.WaterMark
		WHERE TableName='GlobalSuperstore';
		--4 Get New WaterMark
		SELECT @NewWatermark = MAX(Clean_order_date)
		FROM stg.GlobalSuperstore 
		--5 Validate
		EXEC etl.ValidateStaging
		--6 Check new data
		IF @NewWatermark IS NULL
		BEGIN 
			COMMIT TRANSACTION;
			RETURN;
		END;
		IF @NewWatermark<=@OldWatermark
		BEGIN 
			COMMIT TRANSACTION;
			RETURN;
		END;
		--7 Load Dim
		EXEC etl.LoadDimShipping;
		EXEC etl.LoadDimCustomer;
		EXEC etl.LoadDimGeography;
		EXEC etl.LoadDimOrderPriority;
		EXEC etl.LoadDimProduct;
		--8 Load Fact
		EXEC etl.LoadFactSales
			@OldWatermark = @OldWatermark,@NewWatermark=@NewWatermark;
		--9 COUNT
		SELECT
			@RowsProcessed =COUNT(*)
		FROM stg.GlobalSuperstore
		WHERE Clean_order_date> @OldWatermark
		AND Clean_order_date<=@NewWatermark;
		--10 Update WaterMark
		UPDATE etl.WaterMark
		SET WatermarkValue=@NewWatermark,LastUpdated = SYSDATETIME()
		WHERE TableName ='GlobalSuperstore';
		--11 Commit
		COMMIT TRANSACTION;
		--12 Log Success
		UPDATE etl.ETLLog
		SET 
			EndTime = SYSDATETIME(),
			Status ='SUCCESS',
			RowsProcessed= @RowsProcessed
		WHERE ETLLogID=( SELECT MAX(ETLLogID) FROM etl.ETLLog WHERE ProcessName= 'LoadWarehouse');
		END TRY
		BEGIN CATCH 
			--ROLLBACK
			IF @@TRANCOUNT>0
				ROLLBACK TRANSACTION;
			--LOG ERROR
			UPDATE etl.ETLLog
			SET 
				EndTime=SYSDATETIME(),Status='FAILED',ErrosMessage=ERROR_MESSAGE()
			WHERE ETLLogID=(SELECT MAX(ETLLogID) FROM etl.ETLLog WHERE ProcessName ='LoadWarehouse');
			THROW;
		END CATCH;
END;
GO