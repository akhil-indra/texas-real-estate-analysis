*playing with the data for some insights
clear all
cd "C:\Users\aindraba\Documents\final_project\datasets"
use "real_estate_nov5.dta", clear
reg list_price baths_full_calc sqft type year_built

// Generate a new variable from 'location' by splitting and keeping relevant parts
gen clean_location = regexs(1) if regexm(location, "([^_]+)") 

// Replace dashes with spaces for better readability
replace clean_location = subinstr(clean_location, "-", " ", .)

// Display the first few cleaned entries to verify
list location clean_location in 1/10

*******************************************************************
**Cleaning and Analysis of Real_estate_Nov% (most updated)**
*******************************************************************
clear all
cd "C:\Users\aindraba\Documents\final_project\datasets"
use "real_estate_nov5.dta", clear

list in 1/10 //Displaying the first few rows 

**Fill missing listPrice values with the mean:
summarize list_price, meanonly
replace list_price = r(mean) if missing(list_price)

drop if missing(baths_full) | missing(beds) // Dropping rows where baths_full or beds are missing
drop if missing(beds) | missing(sqft)

generate price_per_sqft = list_price / sqft //generate price_per_sqft

summarize list_price sqft beds baths year_built //Summary Statistics for Key Variables:

pwcorr list_price sqft beds baths year_built, star(0.05) //Correlation Matrix

* Clean histogram with customized y-axis formatting to avoid scientific notation
histogram list_price, normal kdensity bin(30) ///
    title("Distribution of Listing Prices", size(medium)) ///
    xlabel(0(500000)3000000, format(%10.0gc)) ///
    ylabel(, format(%10.0gc) nogrid angle(0)) ///
    xtitle("Listing Price ($)", size(medium)) ///
    ytitle("Frequency", size(medium)) ///
    graphregion(color(white)) ///
    plotregion(margin(zero)) ///
    legend(off)



* Summary statistics for the 'list_price' variable
summarize list_price

* Additional detailed percentiles (like 25%, 50%, 75%)
centile list_price, centile(25 50 75)


* Create a horizontal bar graph of property type counts
graph bar (count), over(type, label(angle(45))) ///
    bar(1, color(gs13)) ///
    ylabel(, angle(0) format(%10.0gc)) ///
    ytitle("Count") ///
    blabel(bar, format(%10.0gc)) ///
    graphregion(color(white))
	
	tabulate type

	
*******************************************	***************************
******************************NOV 18********************************
*************************************************************************

reg list_price baths baths_full beds sqft stories year_built price_per_sqft

**Generate Type as numerical variable
encode type, gen (type_new)

reg list_price baths baths_full beds sqft stories year_built price_per_sqft type_new

*****
** Data Cleaning
******
**Starting over to 
// Step 1: Load your dataset
clear all
cd "C:\Users\aindraba\Documents\final_project\datasets"
use "real_estate_nov18.dta"

* Calculate the mean of listPrice (excluding missing values)
summarize listprice, meanonly

* Replace missing values in listPrice with the mean
replace listprice = r(mean) if missing(listprice)

* generate price_per_sqft
generate price_per_sqft = listprice / sqft 

* coverting type in mumerical
encode type, gen (type_new)

 reg listprice baths_full beds sqft stories year_built price_per_sqft i.type_new

*generate log listprice
gen lnlistprice = ln(listprice)

*regression with lnlistprice 
 reg lnlistprice baths_full beds sqft stories year_built price_per_sqft i.type_new // Adj R= 87.03
 
* Update city variable
replace city = regexs(1) if regexm(url, "_([A-Za-z\-]+)_([A-Z]{2})_(\d{5})_")
replace city = subinstr(city, "-", " ", .) // Replace dashes with spaces

* Update state variable
replace state = regexs(2) if regexm(url, "_([A-Za-z\-]+)_([A-Z]{2})_(\d{5})_")

* Update postal_code variable
replace postal_code = regexs(3) if regexm(url, "_([A-Za-z\-]+)_([A-Z]{2})_(\d{5})_")

* Verify the updated variables
list url city state postal_code if !missing(city)

* Coverting city into numerical
encode city, gen(city_num)

*regression with i.city_num and i.type_new
reg lnlistprice baths_full beds sqft stories year_built price_per_sqft i.type_new i.city_num // adj r= 95.97, r^2= 98.88

reg lnlistprice baths_full beds sqft stories year_built price_per_sqft i.type_new city_num // adj r= 87.68

reg lnlistprice i.city_num

// List all unique cities in the dataset
levelsof city, local(citylist)
display `"`citylist'"'

// Count the number of unique cities
egen unique_cities = group(city)
summ unique_cities

// Check the number of unique cities
distinct city

// List all unique cities and count them
levelsof city, local(citylist)
display "`: word count `citylist''"

// Calculate the percentage of missing values
count if missing(year_built)
di "Percentage missing: " r(N) / _N * 100



**NOV20**
****
clear all
cd "C:\Users\aindraba\Documents\final_project\datasets"
use "real_estate_final_data_NOV23.dta"

//linearity
estat ovtest

//trying
gen sqft_sq = sqft^2
reg lnlistprice baths_full beds sqft sqft_sq stories year_built price_per_sqft i.type_new i.city_num
gen beds_baths = beds * baths_full
reg lnlistprice baths_full beds sqft beds_baths stories year_built price_per_sqft i.type_new i.city_num


///omitted variable 
estat ovtest
//multicolienarity
estat vif
//normality
predict res_std,rstandard
swilk res_std
////qq plot 
qnorm res_std, rlopts(lcolor(red)) aspect(1)

// normality using k densty (bell shaped curve)
predict res, resid
kdensity res, normal
qnorm res, rlopts(lcolor(red))
swilk res

reg lnlistprice baths_full beds sqft stories year_built price_per_sqft i.type_new i.city_num

///rerun for each variable/heteroscedacity
estat hettest
//Solution to heteroscedascity
reg lnlistprice baths_full beds sqft stories year_built price_per_sqft i.type_new i.city_num, vce(robust)

///outlier assumption
predict res_stud, rstudent


******************
*****23 Nov*******
******************
clear all
cd "C:\Users\aindraba\Documents\final_project\datasets"
use "real_estate_final_data_NOV23.dta"

// log variables
gen lnbaths_full = ln(baths_full)
gen ln_beds = ln(beds)
gen ln_sqft = ln(sqft)
gen ln_stories = ln(stories)
gen ln_yearbuilt = ln(year_built)
gen ln_pricesqft = ln(price_per_sqft)

reg lnlistprice lnbaths_full ln_beds ln_sqft ln_stories ln_yearbuilt ln_pricesqft i.type_new i.city_num // 1 adj r

**Trying out different variation of regression

reg lnlistprice lnbaths_full // significant adj r 37
reg  lnlistprice lnbaths_full ln_beds // ln_beds insignificant
reg  lnlistprice lnbaths_full ln_sqft // both significant adj r 55
reg lnlistprice lnbaths_full ln_sqft ln_stories // all Significant try ln_stories squared

reg lnlistprice lnbaths_full ln_sqft ln_stories ln_yearbuilt // adj r 54

reg lnlistprice lnbaths_full ln_beds ln_sqft ln_stories ln_yearbuilt //ln_stories not significant 
reg lnlistprice lnbaths_full ln_beds ln_sqft ln_yearbuilt // all significant adj r 57
estat vif

reg lnlistprice lnbaths_full ln_beds ln_pricesqft // different model 


reg lnlistprice lnbaths_full ln_beds ln_sqft ln_yearbuilt i.type_new i.city_num // adj r 72

reg lnlistprice lnbaths_full ln_beds ln_sqft ln_yearbuilt i.type_new // adj r 60
estat ovtest

** Generating interactive and polynomial terms 
gen ln_sqft2 = ln_sqft^2
gen ln_yearbuilt2 = ln_yearbuilt^2
gen lnbaths_full2 = lnbaths_full^2
gen ln_beds2 = ln_beds^2

// Limited interaction terms
gen ln_sqft_baths = ln_sqft * lnbaths_full
gen ln_sqft_yearbuilt = ln_sqft * ln_yearbuilt
gen baths_yearbuilt = lnbaths_full * ln_yearbuilt
gen ln_sqft_type = ln_sqft * type_new
gen ln_sqft_lnbeds = ln_sqft * ln_beds
gen lnbaths_lnbeds = lnbaths_full * ln_beds


** Different regression Models
// Model 1
reg lnlistprice lnbaths_full ln_beds ln_sqft ln_yearbuilt ///
    ln_sqft_baths ln_sqft_lnbeds ln_sqft_yearbuilt lnbaths_lnbeds i.type_new

//Model 2
reg lnlistprice lnbaths_full ln_beds ln_sqft ln_yearbuilt ///
    ln_sqft2 ln_yearbuilt2 lnbaths_full2 ln_beds2 i.type_new

//Model 3
reg lnlistprice lnbaths_full ln_beds ln_sqft ln_yearbuilt ///
    ln_sqft_baths ln_sqft_yearbuilt ln_sqft_lnbeds ///
    ln_sqft2 ln_yearbuilt2 lnbaths_full2 ln_beds2 i.type_new

//Model 4
reg lnlistprice lnbaths_full ln_beds ln_yearbuilt ///
    ln_sqft_type ln_yearbuilt2 ln_beds2 i.type_new
	
//Model 5
reg lnlistprice lnbaths_full ln_beds ln_sqft ln_yearbuilt ///
    ln_sqft_baths ln_sqft_lnbeds ln_sqft_yearbuilt ///
    baths_yearbuilt lnbaths_lnbeds ///
    ln_sqft2 ln_yearbuilt2 lnbaths_full2 ln_beds2 i.type_new
	
	
************************
****BEST MODEL SO FAR***
************************

//Model 4
reg lnlistprice lnbaths_full ln_beds ln_yearbuilt ///
    ln_sqft_type ln_yearbuilt2 ln_beds2 i.type_new
	
** Diagnostic checks
// normality using k densty (bell shaped curve)
predict res, resid
kdensity res, normal
// Shapiro–Wilk W test for normal data
predict res_std, rstandard
swilk res_std

//multicoliearnity
estat vif

//linearity
estat ovtest

//heteroscedacity 
estat hettest

**Model 4 Robust**
reg lnlistprice lnbaths_full ln_beds ln_yearbuilt ///
    ln_sqft_type ln_yearbuilt2 ln_beds2 i.type_new, vce(robust)
	

	
***Exporting to Final Models Word Document
reg lnlistprice lnbaths_full ln_beds ln_sqft ln_yearbuilt ln_sqft_baths ln_sqft_lnbeds ln_sqft_yearbuilt lnbaths_lnbeds i.type_new
outreg2 using myreg.doc, replace ctitle (Model 1) label dec(3) title (Table 1: Factors which effect the real estate price in Texas in 2024. )

reg lnlistprice lnbaths_full ln_beds ln_sqft ln_yearbuilt ln_sqft2 ln_yearbuilt2 lnbaths_full2 ln_beds2 i.type_new
outreg2 using myreg.doc, append ctitle (Model 2) label

reg lnlistprice lnbaths_full ln_beds ln_sqft ln_yearbuilt ln_sqft_baths ln_sqft_yearbuilt ln_sqft_lnbeds ln_sqft2 ln_yearbuilt2 lnbaths_full2 ln_beds2 i.type_new
outreg2 using myreg.doc, append ctitle (Model 3) label
	
reg lnlistprice lnbaths_full ln_beds ln_yearbuilt ln_sqft_type ln_yearbuilt2 ln_beds2 i.type_new, vce(robust)
outreg2 using myreg.doc, append ctitle (Model 4) label

reg lnlistprice lnbaths_full ln_beds ln_sqft ln_yearbuilt ln_sqft_baths ln_sqft_lnbeds ln_sqft_yearbuilt baths_yearbuilt lnbaths_lnbeds ln_sqft2 ln_yearbuilt2 lnbaths_full2 ln_beds2 i.type_new
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



	   
	   


