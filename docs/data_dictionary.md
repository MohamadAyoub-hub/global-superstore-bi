Column        Meaning            Type          Business role
# Data Dictionary

## Source: Superstore

order_id                 Order identifier         Text      Degenerate/business key
Clean_order_date          Order date              Date           DimDate
Clean_Ship_Date          Shipping date           Date           DimDate
ship_mode                Shipping mode           Text           DimShipMode
Customer ID              Customer identifier     Text           DimCustomer
customer_name            Customer name           Text           DimCustomer
Product ID               Product identifier      Text           DimProduct
product_name             Product description     Text           DimProduct
category                 Product category        Text           DimProduct
sales                    Revenue                 Decimal           Fact
quantity                 Units sold              Integer           Fact
profit                   Profit/loss             Decimal           Fact
discount                 Discount                Decimal           Fact
shipping_cost            Shipping expense        Decimal           Fact