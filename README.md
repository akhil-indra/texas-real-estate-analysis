# Texas Real Estate Price Analysis 🏠

## 📌 Project Overview
This project analyzes housing prices in Texas using econometric modeling with **Stata**. The dataset includes 500+ property listings, and the analysis applies log-transformations, interaction effects, and diagnostic tests to identify significant pricing drivers.

## 🧰 Files Included
- `Final_Report_Submission.pdf`: Full project write-up with regression tables and model summary
- `Akhil_version_Project_Do_file_NOV23.do`: Complete Stata script with regression models, diagnostic tests, and visualizations
- `real_estate_texas_500_2024.csv`: Raw dataset with cleaned property listing data

## 📊 Techniques Used
- Log-transformed variables (ln of price, sqft, bathrooms, year built)
- Quadratic & interaction terms
- Dummy variables for property type and city
- Diagnostic tests: `vif`, `ovtest`, `hettest`, `swilk`, `kdensity`, `qnorm`
- Regression output via `outreg2`

## 💡 Key Insights
- Square footage and full bathrooms are the most significant predictors of listing price
- Quadratic terms reveal diminishing returns in bedroom and size effects
- Newer homes and certain property types command price premiums
- Final model Adjusted R²: **0.645**

## 📷 Visualizations
- Histogram of prices with normal overlay
- Geomap of price clusters in Texas
- Bar graph of property types

---

📌 **Made for BUAN-B360 Econometrics, Loyola University New Orleans**  
By: Akhilendran Indrabalan | December 2024
