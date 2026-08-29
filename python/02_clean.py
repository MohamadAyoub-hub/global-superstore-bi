import pandas as pd
SOURCE = "data/GlobalSuperstore.csv"
OUTPUT = "data/GlobalSuperstore_clean.csv"
df = pd.read_csv(SOURCE , encoding='ISO-8859-1')
# Clean column names
df.columns= (df.columns.str.strip().str.lower().str.replace(" ", "_").str.replace("-", "_"))
# Remove completely empty rows
df=df.dropna(how="all")
# trim text fields
text_columns = df.select_dtypes(include=["object"]).columns
for col in text_columns:
    df[col] = df[col].str.strip()
# convert dates
df["clean_order_date"]=pd.to_datetime(df["clean_order_date"],format="mixed", errors="coerce")
df["clean_ship_date"]=pd.to_datetime(df["clean_ship_date"], errors="coerce")
#convert numeric columns
numeric_columns=["sales","quantity","discount","profit","shipping_cost"]
for col in numeric_columns:
    if col in df.columns:
        df[col] = pd.to_numeric(df[col], errors="coerce")
# remove exact duplicates rows
df = df.drop_duplicates()
#save
df.to_csv(OUTPUT, index=False)
print("Cleaning completed.")
print("Rows :", len(df))
print("Output:",OUTPUT)