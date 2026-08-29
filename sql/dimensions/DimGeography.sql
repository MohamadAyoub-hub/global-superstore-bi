USE [SuperstoreBI]
GO

/****** Object:  Table [dw].[DimGeography]    Script Date: 8/29/2026 11:31:43 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dw].[DimGeography](
	[GeographyKey] [int] IDENTITY(1,1) NOT NULL,
	[Market] [nvarchar](50) NULL,
	[Region] [nvarchar](100) NULL,
	[Country] [nvarchar](100) NULL,
	[State] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[GeographyKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

