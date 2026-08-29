CREATE TABLE dw.DimDate (
DateKey INT NOT NULL PRIMARY KEY,
FullDate DATE NOT NULL UNIQUE,
Year INT NOT NULL,
Quarter INT NOT NULL,
QuarterName VARCHAR(10) NOT NULL,
Month INT NOT NULL,
MonthName VARCHAR(20) NOT NULL,
MonthShortName VARCHAR(10) NOT NULL,
WeekOfYear INT NOT NULL,
DayOfMonth INT NOT NULL,
DayOfWeek INT NOT NULL,
DayName VARCHAR(20) NOT NULL,
IsWeekend BIT NOT NULL);

DECLARE @StartDate DATE=
(
	SELECT MIN (d)
	FROM (
			SELECT MIN(Clean_order_date) AS d
			FROM stg.GlobalSuperstore
			UNION ALL
			SELECT MIN(Clean_Ship_Date)
			FROM stg.GlobalSuperstore
			) x
);
DECLARE @EndDate DATE =
(
	SELECT MAX(d)
	FROM
	(
		SELECT MAX(Clean_order_date) AS d
		FROM stg.GlobalSuperstore
		UNION ALL
		SELECT MAX(Clean_Ship_Date)
		FROM stg.GlobalSuperstore
		) x
	);

DECLARE @CurrentDate DATE = @StartDate;
WHILE @CurrentDate <= @EndDate
BEGIN
	INSERT INTO dw.DimDate
	(
		DateKey,
		FullDate,
		Year,
		Quarter,
		QuarterName,
		Month,
		MonthName,
		MonthShortName,
		WeekOfYear,
		DayOfMonth,
		DayOfWeek,
		DayName,
		IsWeekend
		)
		VALUES
		(
			CONVERT(INT, CONVERT(VARCHAR(8),@CurrentDate,112)),
			@CurrentDate,
			YEAR(@CurrentDate),
			DATEPART(QUARTER,@CurrentDate),
			'Q' + CAST(DATEPART(QUARTER,@CurrentDate) AS VARCHAR(1)),
			MONTH(@CurrentDate),
			DATENAME(MONTH,@CurrentDate),
			LEFT(DATENAME(MONTH,@CurrentDate),3),
			DATEPART(WEEK,@CurrentDate),
			DAY(@CurrentDate),
			DATEPART(WEEKDAY,@CurrentDate),
			DATENAME(WEEKDAY,@CurrentDate),
			CASE WHEN DATEPART(WEEKDAY, @CurrentDate) IN (1,7)
			THEN 1
			ELSE 0
			END
		);
	SET @CurrentDate = DATEADD(DAY,1,@CurrentDate);
	END;
