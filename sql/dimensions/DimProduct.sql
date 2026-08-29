USE [SuperstoreBI]
GO

/****** Object:  Table [dw].[DimProduct]    Script Date: 8/29/2026 11:32:15 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dw].[DimProduct](
	[ProductKey] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [varchar](50) NULL,
	[ProductName] [nvarchar](500) NULL,
	[Category] [nvarchar](100) NULL,
	[SubCategory] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

