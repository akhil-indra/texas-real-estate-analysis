#  Texas Residential Real Estate Price Analysis 🏡

This project is about understanding what actually drives house prices in Texas. I used real-world data from over 500 residential property listings and built multiple regression models using Stata to analyze how different features — like square footage, number of bathrooms, year built, and property type — affect a home's listing price.

The goal wasn’t just to run stats — I wanted to answer real questions:  
- Why do some homes cost way more than others?  
- Is square footage always worth more?  
- Do more bathrooms actually raise the price?  
- Does age help or hurt a home's value?  
- Do townhouses, mobile homes, or single-family homes behave differently in the market?

---

### How I approached it

I cleaned and transformed the dataset, built several econometric models, and tested for things like multicollinearity, heteroskedasticity, and model fit. I also log-transformed key variables to make the results interpretable as elasticities.

Then I experimented with:
- **Interaction terms** (e.g., sqft × property type)
- **Quadratic terms** (to check diminishing returns)
- **Dummy variables** for property type and city

These allowed me to explore not just direct effects, but how different variables combine or behave in non-linear ways.

---

### What I found

The final model (Model 4) gave the best balance of interpretability and accuracy.

- **Square footage** and **full bathrooms** had the most consistent, positive effect on listing price.
- **Bedrooms** showed diminishing returns — adding more bedrooms only helped up to a point.
- **Newer homes** gained value, but the relationship wasn’t linear. Very new or very old homes had unique effects.
- **Property type** mattered a lot — mobile homes, townhomes, and farms were priced significantly lower than single-family homes.

**Adjusted R²: 0.645**  


<img width="600" alt="image" src="https://github.com/user-attachments/assets/ba4c526b-1dfd-48fa-8a1b-7542eb93d965" />
  
*Shows skewed distribution of home prices in Texas — most between \$300K–\$500K, with a few luxury outliers.*

<img width="517" alt="image" src="https://github.com/user-attachments/assets/1d3a92ee-d431-4e3c-90f5-eac173335ff4" />
  
*Breakdown of listings by type — single-family homes dominate the market.*

---

### 📈 Quick View of Results and Output of Different Models

| Variable             | Effect Summary                                 |
|----------------------|------------------------------------------------|
| `ln(sqft)`           | Strong positive – every 1% increase raises price by ~0.55%  
| `ln(baths_full)`     | Strong positive – highly significant  
| `ln(beds)`           | Weak linear effect, stronger quadratic term  
| `ln(year_built)`     | Negative initially, but positive in squared term (nonlinear)  
| `type_new` dummies   | Significant drops for townhomes, mobile homes, farms


<img width="658" alt="Screenshot 2025-04-22 at 8 35 31 PM" src="https://github.com/user-attachments/assets/4426d878-3deb-43cc-bedc-841d68b34385" />

*A snapshot of regression output — significant variables starred, VIFs and residual tests passed.*

---

### Tools Used for the Project

- **Stata** – for regression modeling, transformations, and residual testing
- **Excel** – for charting (price histograms, bar graphs by type, and mapping)
- **Econometric techniques** – log-log models, interaction terms, quadratic terms, dummy encoding

---

### Files in this repository

- `Final_Report.pdf` – Full report write-up with charts, methodology, and regression breakdown
- `real_estate_texas_500_2024.csv` – Kaggle dataset
- `stata_codes.do` – All Stata code: data prep - modeling - output - visuals

---

### Why this mattered to me

This wasn’t just a class assignment. It taught me how to take raw, messy data and turn it into something that can answer a real-world question with confidence.

It forced me to think like a data analyst:
- How do I clean and prep this data right?
- Which model actually makes sense here?
- How do I explain this so someone in real estate (or policy) actually gets it?

This project gave me full-cycle experience, from analysis to insight, and sharpened both my technical and storytelling skills.

