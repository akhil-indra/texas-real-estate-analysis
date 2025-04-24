*****************************************************
* Texas Real Estate Price Analysis - Cleaned Do File
* Author: Akhil Indrabalan
*****************************************************

*playing with the data for some insights

// ----- Setup & Load Data -----

clear all  // Clear memory
cd "C:\Users\aindraba\Documents\final_project\datasets"
use "real_estate_nov5.dta", clear  // Load dataset

// ----- Data Exploration -----

reg list_price baths_full_calc sqft type year_built  // Run regression model

// ----- Feature Engineering -----

// Generate a new variable from 'location' by splitting and keeping relevant parts
gen clean_location = regexs(1) if regexm(location, "([^_]+)")  // Create new variable

// ----- Data Cleaning -----

// Replace dashes with spaces for better readability
replace clean_location = subinstr(clean_location, "-", " ", .)  // Modify existing variable
// Display the first few cleaned entries to verify

// ----- Data Exploration -----

list location clean_location in 1/10
*******************************************************************

// ----- Model Diagnostics -----

**Cleaning and Analysis of Real_estate_Nov% (most updated)**
*******************************************************************

// ----- Setup & Load Data -----

clear all  // Clear memory
cd "C:\Users\aindraba\Documents\final_project\datasets"
use "real_estate_nov5.dta", clear  // Load dataset

// ----- Data Exploration -----

list in 1/10 //Displaying the first few rows

// ----- Data Cleaning -----

**Fill missing listPrice values with the mean:

// ----- Data Exploration -----

summarize list_price, meanonly  // Summary statistics

// ----- Data Cleaning -----

replace list_price = r(mean) if missing(list_price)  // Modify existing variable
drop if missing(baths_full) | missing(beds) // Dropping rows where baths_full or beds are missing  // Remove rows with missing values
drop if missing(beds) | missing(sqft)  // Remove rows with missing values

// ----- Feature Engineering -----

generate price_per_sqft = list_price / sqft //generate price_per_sqft  // Create new variable

// ----- Data Exploration -----

summarize list_price sqft beds baths year_built //Summary Statistics for Key Variables:  // Summary statistics
pwcorr list_price sqft beds baths year_built, star(0.05) //Correlation Matrix  // Correlation matrix with significance stars

// ----- Visualization -----

* Clean histogram with customized y-axis formatting to avoid scientific notation  // Plot distribution of listing prices

// ----- Data Exploration -----

histogram list_price, normal kdensity bin(30) ///  // Plot distribution of listing prices
title("Distribution of Listing Prices", size(medium)) ///
xlabel(0(500000)3000000, format(%10.0gc)) ///
ylabel(, format(%10.0gc) nogrid angle(0)) ///
xtitle("Listing Price ($)", size(medium)) ///
ytitle("Frequency", size(medium)) ///

// ----- Visualization -----

graphregion(color(white)) ///

// ----- Regression Modeling -----

plotregion(margin(zero)) ///

// ----- Feature Engineering -----

legend(off)

// ----- Data Exploration -----

* Summary statistics for the 'list_price' variable
summarize list_price  // Summary statistics
* Additional detailed percentiles (like 25%, 50%, 75%)
centile list_price, centile(25 50 75)

// ----- Visualization -----

* Create a horizontal bar graph of property type counts
graph bar (count), over(type, label(angle(45))) ///
bar(1, color(gs13)) ///
ylabel(, angle(0) format(%10.0gc)) ///
ytitle("Count") ///
blabel(bar, format(%10.0gc)) ///
graphregion(color(white))

// ----- Data Exploration -----

tabulate type
*******************************************	***************************
******************************NOV 18********************************
*************************************************************************
reg list_price baths baths_full beds sqft stories year_built price_per_sqft  // Run regression model

// ----- Feature Engineering -----

**Generate Type as numerical variable
encode type, gen (type_new)  // Create new variable

// ----- Data Exploration -----

reg list_price baths baths_full beds sqft stories year_built price_per_sqft type_new  // Run regression model
*****
** Data Cleaning
******
**Starting over to
// Step 1: Load your dataset

// ----- Setup & Load Data -----

clear all  // Clear memory
cd "C:\Users\aindraba\Documents\final_project\datasets"
use "real_estate_nov18.dta"  // Load dataset

// ----- Data Cleaning -----

* Calculate the mean of listPrice (excluding missing values)

// ----- Data Exploration -----

summarize listprice, meanonly  // Summary statistics

// ----- Data Cleaning -----

* Replace missing values in listPrice with the mean
replace listprice = r(mean) if missing(listprice)  // Modify existing variable

// ----- Feature Engineering -----

* generate price_per_sqft  // Create new variable
generate price_per_sqft = listprice / sqft  // Create new variable
* coverting type in mumerical
encode type, gen (type_new)  // Create new variable

// ----- Data Exploration -----

reg listprice baths_full beds sqft stories year_built price_per_sqft i.type_new  // Run regression model

// ----- Feature Engineering -----

*generate log listprice  // Create new variable
gen lnlistprice = ln(listprice)  // Create new variable

// ----- Data Exploration -----

*regression with lnlistprice
reg lnlistprice baths_full beds sqft stories year_built price_per_sqft i.type_new // Adj R= 87.03  // Run regression model
* Update city variable

// ----- Data Cleaning -----

replace city = regexs(1) if regexm(url, "_([A-Za-z\-]+)_([A-Z]{2})_(\d{5})_")  // Modify existing variable
replace city = subinstr(city, "-", " ", .) // Replace dashes with spaces  // Modify existing variable
* Update state variable
replace state = regexs(2) if regexm(url, "_([A-Za-z\-]+)_([A-Z]{2})_(\d{5})_")  // Modify existing variable
* Update postal_code variable
replace postal_code = regexs(3) if regexm(url, "_([A-Za-z\-]+)_([A-Z]{2})_(\d{5})_")  // Modify existing variable
* Verify the updated variables
list url city state postal_code if !missing(city)
* Coverting city into numerical

// ----- Feature Engineering -----

encode city, gen(city_num)  // Convert string to categorical numeric variable

// ----- Regression Modeling -----

*regression with i.city_num and i.type_new

// ----- Data Exploration -----

reg lnlistprice baths_full beds sqft stories year_built price_per_sqft i.type_new i.city_num // adj r= 95.97, r^2= 98.88  // Run regression model
reg lnlistprice baths_full beds sqft stories year_built price_per_sqft i.type_new city_num // adj r= 87.68  // Run regression model
reg lnlistprice i.city_num  // Run regression model
// List all unique cities in the dataset
levelsof city, local(citylist)
display `"`citylist'"'
// Count the number of unique cities

// ----- Feature Engineering -----

egen unique_cities = group(city)  // Create new variable
summ unique_cities
// Check the number of unique cities
distinct city

// ----- Data Exploration -----

// List all unique cities and count them
levelsof city, local(citylist)
display "`: word count `citylist''"

// ----- Data Cleaning -----

// Calculate the percentage of missing values
count if missing(year_built)
di "Percentage missing: " r(N) / _N * 100
**NOV20**
****

// ----- Setup & Load Data -----

clear all  // Clear memory
cd "C:\Users\aindraba\Documents\final_project\datasets"
use "real_estate_final_data_NOV23.dta"  // Load dataset
//linearity

// ----- Model Diagnostics -----

estat ovtest
//trying

// ----- Feature Engineering -----

gen sqft_sq = sqft^2  // Create new variable

// ----- Data Exploration -----

reg lnlistprice baths_full beds sqft sqft_sq stories year_built price_per_sqft i.type_new i.city_num  // Run regression model

// ----- Feature Engineering -----

gen beds_baths = beds * baths_full  // Create new variable

// ----- Data Exploration -----

reg lnlistprice baths_full beds sqft beds_baths stories year_built price_per_sqft i.type_new i.city_num  // Run regression model
///omitted variable

// ----- Model Diagnostics -----

estat ovtest
//multicolienarity
estat vif
//normality
predict res_std,rstandard  // Generate residuals or fitted values
swilk res_std
////qq plot

// ----- Visualization -----

qnorm res_std, rlopts(lcolor(red)) aspect(1)
// normality using k densty (bell shaped curve)

// ----- Model Diagnostics -----

predict res, resid  // Generate residuals or fitted values

// ----- Visualization -----

kdensity res, normal
qnorm res, rlopts(lcolor(red))

// ----- Model Diagnostics -----

swilk res

// ----- Data Exploration -----

reg lnlistprice baths_full beds sqft stories year_built price_per_sqft i.type_new i.city_num  // Run regression model
///rerun for each variable/heteroscedacity

// ----- Model Diagnostics -----

estat hettest
//Solution to heteroscedascity

// ----- Data Exploration -----

reg lnlistprice baths_full beds sqft stories year_built price_per_sqft i.type_new i.city_num, vce(robust)  // Run regression model
///outlier assumption

// ----- Model Diagnostics -----

predict res_stud, rstudent  // Generate residuals or fitted values
******************
*****23 Nov*******
******************

// ----- Setup & Load Data -----

clear all  // Clear memory
cd "C:\Users\aindraba\Documents\final_project\datasets"
use "real_estate_final_data_NOV23.dta"  // Load dataset
// log variables

// ----- Feature Engineering -----

gen lnbaths_full = ln(baths_full)  // Create new variable
gen ln_beds = ln(beds)  // Create new variable
gen ln_sqft = ln(sqft)  // Create new variable
gen ln_stories = ln(stories)  // Create new variable
gen ln_yearbuilt = ln(year_built)  // Create new variable
gen ln_pricesqft = ln(price_per_sqft)  // Create new variable

// ----- Data Exploration -----

reg lnlistprice lnbaths_full ln_beds ln_sqft ln_stories ln_yearbuilt ln_pricesqft i.type_new i.city_num // 1 adj r  // Run regression model

// ----- Regression Modeling -----

**Trying out different variation of regression

// ----- Data Exploration -----

reg lnlistprice lnbaths_full // significant adj r 37  // Run regression model
reg  lnlistprice lnbaths_full ln_beds // ln_beds insignificant  // Run regression model
reg  lnlistprice lnbaths_full ln_sqft // both significant adj r 55  // Run regression model
reg lnlistprice lnbaths_full ln_sqft ln_stories // all Significant try ln_stories squared  // Run regression model
reg lnlistprice lnbaths_full ln_sqft ln_stories ln_yearbuilt // adj r 54  // Run regression model
reg lnlistprice lnbaths_full ln_beds ln_sqft ln_stories ln_yearbuilt //ln_stories not significant  // Run regression model
reg lnlistprice lnbaths_full ln_beds ln_sqft ln_yearbuilt // all significant adj r 57  // Run regression model

// ----- Model Diagnostics -----

estat vif

// ----- Data Exploration -----

reg lnlistprice lnbaths_full ln_beds ln_pricesqft // different model  // Run regression model
reg lnlistprice lnbaths_full ln_beds ln_sqft ln_yearbuilt i.type_new i.city_num // adj r 72  // Run regression model
reg lnlistprice lnbaths_full ln_beds ln_sqft ln_yearbuilt i.type_new // adj r 60  // Run regression model

// ----- Model Diagnostics -----

estat ovtest

// ----- Feature Engineering -----

** Generating interactive and polynomial terms
gen ln_sqft2 = ln_sqft^2  // Create new variable
gen ln_yearbuilt2 = ln_yearbuilt^2  // Create new variable
gen lnbaths_full2 = lnbaths_full^2  // Create new variable
gen ln_beds2 = ln_beds^2  // Create new variable
// Limited interaction terms
gen ln_sqft_baths = ln_sqft * lnbaths_full  // Create new variable
gen ln_sqft_yearbuilt = ln_sqft * ln_yearbuilt  // Create new variable
gen baths_yearbuilt = lnbaths_full * ln_yearbuilt  // Create new variable
gen ln_sqft_type = ln_sqft * type_new  // Create new variable
gen ln_sqft_lnbeds = ln_sqft * ln_beds  // Create new variable
gen lnbaths_lnbeds = lnbaths_full * ln_beds  // Create new variable

// ----- Regression Modeling -----

** Different regression Models
// Model 1

// ----- Data Exploration -----

reg lnlistprice lnbaths_full ln_beds ln_sqft ln_yearbuilt ///  // Run regression model
ln_sqft_baths ln_sqft_lnbeds ln_sqft_yearbuilt lnbaths_lnbeds i.type_new
//Model 2
reg lnlistprice lnbaths_full ln_beds ln_sqft ln_yearbuilt ///  // Run regression model
ln_sqft2 ln_yearbuilt2 lnbaths_full2 ln_beds2 i.type_new
//Model 3
reg lnlistprice lnbaths_full ln_beds ln_sqft ln_yearbuilt ///  // Run regression model
ln_sqft_baths ln_sqft_yearbuilt ln_sqft_lnbeds ///
ln_sqft2 ln_yearbuilt2 lnbaths_full2 ln_beds2 i.type_new
//Model 4
reg lnlistprice lnbaths_full ln_beds ln_yearbuilt ///  // Run regression model
ln_sqft_type ln_yearbuilt2 ln_beds2 i.type_new
//Model 5
reg lnlistprice lnbaths_full ln_beds ln_sqft ln_yearbuilt ///  // Run regression model
ln_sqft_baths ln_sqft_lnbeds ln_sqft_yearbuilt ///
baths_yearbuilt lnbaths_lnbeds ///
ln_sqft2 ln_yearbuilt2 lnbaths_full2 ln_beds2 i.type_new
************************
****BEST MODEL SO FAR***
************************
//Model 4
reg lnlistprice lnbaths_full ln_beds ln_yearbuilt ///  // Run regression model
ln_sqft_type ln_yearbuilt2 ln_beds2 i.type_new
** Diagnostic checks
// normality using k densty (bell shaped curve)

// ----- Model Diagnostics -----

predict res, resid  // Generate residuals or fitted values

// ----- Visualization -----

kdensity res, normal
// Shapiro–Wilk W test for normal data

// ----- Model Diagnostics -----

predict res_std, rstandard  // Generate residuals or fitted values
swilk res_std
//multicoliearnity
estat vif
//linearity
estat ovtest
//heteroscedacity
estat hettest
**Model 4 Robust**

// ----- Data Exporting -----

reg lnlistprice lnbaths_full ln_beds ln_yearbuilt ///  // Run regression model
ln_sqft_type ln_yearbuilt2 ln_beds2 i.type_new, vce(robust)

***Exporting to Final Models Word Document

// ----- Regression Modeling 1 Exporting -----

outreg2 using myreg.doc, replace ctitle (Model 1) label dec(3) title (Table 1: Factors which effect the real estate price in Texas in 2024. )  // Modify existing variable

reg lnlistprice lnbaths_full ln_beds ln_sqft ln_yearbuilt ln_sqft_baths ln_sqft_yearbuilt ln_sqft_lnbeds ln_sqft2 ln_yearbuilt2 lnbaths_full2 ln_beds2 i.type_new  // Run regression model

// ----- Regression Modeling 3 Exporting -----

outreg2 using myreg.doc, append ctitle (Model 3) label

// ----- Regression Modeling 4 Exporting ----

outreg2 using myreg.doc, append ctitle (Model 4) label

reg lnlistprice lnbaths_full ln_beds ln_sqft ln_yearbuilt ln_sqft_baths ln_sqft_lnbeds ln_sqft_yearbuilt baths_yearbuilt lnbaths_lnbeds ln_sqft2 ln_yearbuilt2 lnbaths_full2 ln_beds2 i.type_new  // Run regression model

// ----- Regression Modeling Labelling -----

outreg2 using myreg.doc, append ctitle (Model 5) label
label variable lnbaths_full "Log of Bathrooms"
label variable ln_beds "Log of Bedrooms"
label variable ln_sqft "Log of Square Feet"
label variable ln_yearbuilt "Log of Year Built"
label variable ln_sqft_baths "Log of Square Footage × Bathrooms"
label variable ln_sqft_lnbeds "Log of Square Footage × Bedrooms"
label variable ln_sqft_yearbuilt "Log of Square Feet × Year Built"
label variable lnbaths_lnbeds "Log of Bathrooms × Bedrooms"
label variable ln_sqft2 "Log of Square Feet^2"
label variable ln_yearbuilt2 "Log of Year Built^2"
label variable lnbaths_full2 "Log of Bathrooms^2"
label variable ln_beds2 "Log of Bedrooms^2"
label variable ln_sqft_type "Log Feet × Property Type^2"
label variable baths_yearbuilt "Bathrooms × Year Built"
label define type_new_lbl 2 "Farm" 4 "Mobile Home" 6 "Single Family" 7 "Townhomes"
label values type_new type_new_lbl
