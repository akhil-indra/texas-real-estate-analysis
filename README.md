#  Texas Residential Real Estate Price Analysis 🏡

This project was about understanding what actually drives housing prices in Texas. I used  data of over 500 residential property listings and built multiple regression models using Stata to analyze how different structural features. For example: Square footage of the property, Number of bathrooms, Age of the Property, and The Property type affect a home's listing price.

My objective was to find answers to these key questions:  
- What makes one house worth hundreds of thousands more than another?
- Does having more space actually translate to higher value?
- Are bathrooms more valuable or bedrooms?
- Does the age of a home increase its appeal or hurt it?
- And how do different property types (like townhomes vs. single-family homes) influence pricing?

---

### How I approached it

I cleaned and transformed the dataset and used multiple linear regression models to analyze how different structural affect listing prices.

The target variable was the natural log of list price (`ln(list_price)`), and I applied log transformations to other variables also - square footage, bathrooms, bedrooms, and year built to interpret as elasticities and reduce skew.

To better capture pricing behavior, I also added:
- **Quadratic terms** (like `ln_sqft^2`, `ln_yearbuilt^2`) to model diminishing returns
- **Interaction terms** (e.g., `ln_sqft × property type`) to reflect how size impacts value differently across property categories
- **Dummy variables** for property type and location (city)

I built five models with each with different vairbales and selected **Model 4** as the best based on interpretability, statistical significance, and an **Adjusted R² of 0.645**.

_All models were tested for multicollinearity, normality, omitted variables, and heteroskedasticity._

| Variable Name     | What It Represents                                 |
|-------------------|----------------------------------------------------|
| `list_price`      | Property listing price (USD)                       |
| `lnlistprice`     | Natural log of listing price                       |
| `sqft`            | Square footage of the property                     |
| `ln_sqft`         | Natural log of square footage                      |
| `baths_full`      | Number of full bathrooms                           |
| `lnbaths_full`    | Natural log of full bathrooms                      |
| `beds`            | Number of bedrooms                                 |
| `ln_beds`         | Natural log of bedrooms                            |
| `year_built`      | Year the property was built                        |
| `ln_yearbuilt`    | Natural log of year built                          |
| `ln_sqft_type`    | Interaction: ln(sqft) × property type              |
| `ln_yearbuilt2`   | Quadratic term: (ln_yearbuilt)^2                   |
| `ln_beds2`        | Quadratic term: (ln_beds)^2                        |

---

### What I found

Model 4 gave the best balance of interpretability and accuracy. It includeds log-transformed variables, interaction terms, and quadratic terms to capture nonlinear relationship of pricing.

- **Square footage of the Porperty** and **Number of Full Bathrooms** had the most consistent and significant impact on price. A 1% increase in square footage raised price by ~0.55%.
- **Number of Bedrooms** showed diminishing returns — Adding more bedrooms helped, but only up to 2. Beyond that the marginal value dropped and buyers didn’t pay a premium.
- **Age of the Property** had a nonlinear effect - very old homes lost value, but new builds after 2000 regained premium pricing msot likely due to buyers preference for modern design and energy efficiency.
- **Type of the Property** mattered a lot - farms, mobile homes, and townhomes were priced **100–900%** lower than single-family homes


## Distribution of Listing Prices

<img width="600" alt="image" src="https://github.com/user-attachments/assets/ba4c526b-1dfd-48fa-8a1b-7542eb93d965" />
  
_Shows skewed distribution of home prices in Texas — most between \$300K–\$500K, with a few luxury outliers._

## Geo Map 🌍 of Property Prices 

<img width="560" alt="image" src="https://github.com/user-attachments/assets/189c3691-08be-428a-89e1-067528bf456b" />

*Homes near urban areas like Dallas, Houston, and Austin cluster at the higher end of the pricing range*

---

### Quick View of Results and Regression Output

I summarized the **main predictors** from our best-performing model (Model 4), and shows how five different models compared during testing.

| Variable                  | Interpretation                                                                 |
|---------------------------|--------------------------------------------------------------------------------|
| `ln(sqft)`                | Significant positive (p < 0.01). 100% increase in sqft leads to ~55% higher price            |
| `ln(baths_full)`          | Strongest driver (p < 0.001). Bathrooms add more value than bedrooms         |
| `ln(beds)` / `ln(beds^2)` | Positive linear, negative quadratic — diminishing returns after 2 beds       |
| `ln(year_built)`          |Initially negative — older homes lose value                                 |
| `ln(year_built^2)`        | Rebounds at newer construction ages                                         |
| `ln_sqft_type`            | Square footage's effect varies across property types                        |
| `type_new` (dummies)      | Farms, mobile homes, and townhomes priced 100–900% lower than Single family Housess          |

<img width="658" alt="Screenshot 2025-04-22 at 8 35 31 PM" src="https://github.com/user-attachments/assets/4426d878-3deb-43cc-bedc-841d68b34385" />

*significant variables are denoted using astrix, VIFs and residual tests passed.*

---

### Tools Used for the Project

- **Stata** – for data cleaning, regression modeling, visulization, transformations, and diagnostic testing
- **Excel** – for charting, data cleaning, exporting
- **Econometric techniques** – log-log models, interaction terms, quadratic terms, dummy encoding

---

### Files in this repository

- `Final_Report.pdf` – Full report write-up with charts, methodology, and regression breakdown
- `real_estate_texas_500_2024.csv` – Kaggle dataset
- `stata_codes.do` – All Stata code: data prep - modeling - output - visuals

---

### Why this mattered to me

This project was more than a class final, it taught me how to take raw, messy data and turn it into something that can answer a real world question with confidence.

It forced me to think like a data analyst:
- How do I clean and prep this data right?
- Which model actually makes sense here?
- How do I explain this so someone in real estate (or policy) actually gets it?

This project gave me full-cycle experience, from analysis to insight, and sharpened both my technical and storytelling skills.

