USE [SuperstoreBI]
GO

/****** Object:  Table [stg].[GlobalSuperstore]    Script Date: 8/29/2026 11:27:47 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[GlobalSuperstore](
	[order_id] [nvarchar](50) NOT NULL,
	[Clean_order_date] [date] NOT NULL,
	[Clean_Ship_Date] [date] NOT NULL,
	[ship_mode] [nvarchar](50) NOT NULL,
	[customer_name] [nvarchar](50) NOT NULL,
	[segment] [nvarchar](50) NOT NULL,
	[state] [nvarchar](50) NOT NULL,
	[country] [nvarchar](50) NOT NULL,
	[market] [nvarchar](50) NOT NULL,
	[region] [nvarchar](50) NOT NULL,
	[product_id] [nvarchar](50) NOT NULL,
	[category] [nvarchar](50) NOT NULL,
	[sub_category] [nvarchar](50) NOT NULL,
	[product_name] [nvarchar](500) NOT NULL,
	[sales] [decimal](18, 2) NOT NULL,
	[quantity] [int] NOT NULL,
	[discount] [decimal](5, 2) NOT NULL,
	[profit] [decimal](18, 2) NOT NULL,
	[shipping_cost] [decimal](18, 2) NOT NULL,
	[order_priority] [nvarchar](50) NOT NULL,
	[year] [int] NOT NULL
) ON [PRIMARY]
GO

