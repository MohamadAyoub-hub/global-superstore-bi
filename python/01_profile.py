import pandas as pd
df=pd.read_csv("data/GlobalSuperstore.csv", encoding='ISO-8859-1')
df["Clean_order_date"]=pd.to_datetime(df["Clean_order_date"], format="mixed")
df["Clean_Ship_Date"]=pd.to_datetime(df["Clean_Ship_Date"], format="mixed")

print(df.head())
def profile_dataframe(df):
    profile= pd.DataFrame({
        "dtypes": df.dtypes,
        "missing_values": df.isna().sum(),
        "missing_percent":df.isna().mean()*100,
        "unique":df.nunique(),
        "duplicated":df.duplicated().sum()
    })
    return profile
profile=profile_dataframe(df)
print(profile)
df.groupby("order_id").size().sort_values(ascending=False).head()
print(df)
print(df["Clean_order_date"].min())
print(df["Clean_order_date"].max())
print(df["Clean_Ship_Date"].min())
print(df["Clean_Ship_Date"].max())
print(df[df["profit"]<0])
