import pandas as pd
FILE = "data/GlobalSuperstore_clean.csv"
df = pd.read_csv(FILE, encoding='ISO-8859-1')
errors =[]
# Required columns
required_columns = ["order_id", "clean_order_date", "clean_ship_date", "ship_mode", "customer_name", "segment", "country", "state", "market", "region", "product_id", "category", "sub_category", "product_name", "sales", "quantity", "discount", "profit","shipping_cost","order_priority"]
for col in required_columns:
    if col not in df.columns:
        errors.append(f"Missing required column: {col}")
#dates
if "clean_order_date" in df.columns:
    dates = pd.to_datetime(df["clean_order_date"], errors="coerce")
    invalid = dates.isna().sum()
    if invalid>0:
        errors.append(f"Invalid order_date values: {invalid}")
#Quantity
if "quantity" in df.columns:
    quantity = pd.to_numeric(df["quantity"], errors="coerce")
    invalid=quantity.isna().sum()
    if invalid>0:
        errors.append(f"Invalid quantity values: {invalid}")
#Sales
if "sales" in df.columns:
    sales = pd.to_numeric(df["sales"], errors="coerce")
    invalid=(sales<0).sum()
    if invalid>0:
        errors.append(f"Negative sales values: {invalid}")

#Result
print("="*60)
if errors:
    print("❌ Validation FAILED")
    for error in errors:
        print(" -", error)
    raise SystemExit(1)
else:
    print("✅ Validation PASSED")
    print("Rows validated:", len(df))