# BI Architecture

## Source

Kaggle Global Superstore / Superstore Sales Analystics

## Ingestion

Python / Pandas

## Database

Microsoft SQL Server

## Layers

Raw
⬇
Staging
⬇
Transformation
⬇
Data Warehouse
⬇
PowerBi Semantic Model
⬇
PowerBi Report

## Warehouse Model

Star Schema

### Dimensions

- DimDate
- DimCustomer
- DimProduct
- DimGeography
- DimShipMode
- DimOrderPriority

### Fact

- FactSales