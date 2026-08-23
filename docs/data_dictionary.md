Column        Meaning            Type          Business role

Order ID         Order identifier         Text      Degenerate/business key
Order Date          Order date              Date           DimDate
Ship Date           Shipping date           Date           DimDate
Ship Mode           Shipoing mode           Text           DimShipMode
Customer ID         Customer identifier     Text           DimCustomer
Customer Name       Customer name           Text           DimCustomer
Product ID          Product identifier      Text           DimProduct
Product Name        Product description     Text           DimProduct
Category            Product category        Text           DimProduct
Sales               Revenue                 Decimal           Fact
Quantity            Units sold              Integer           Fact
Profit              Profit/loss             Decimal           Fact
Discount            Discount                Decimal           Fact
Shipping Cost       Shipping expense        Decimal           Fact