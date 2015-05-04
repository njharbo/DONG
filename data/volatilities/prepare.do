clear all
set more off

cd "/Users/njharbo/Dropbox/Dokumenter/Debatindlaeg/DONG/data/volatilities"

*insheet using optionmetrics.csv
insheet using implied-vol-put-call.csv

*clean data
keep if ticker=="IXC" & cp_flag=="P"
*drop if strike_price==0
keep date days impl_volatility

*tostring date, replace
*gen year=substr(date,1,4)
*gen month=substr(date,5,2)
*gen day=substr(date,7,2)
*foreach h in "day" "month" {
*forval i=1/12 {
*replace `h'="`i'" if `h'=="0`i'" 
*}
*}
*destring month day year, replace
*gen dato=mdy(month, day, year)
*format dato %tdNN/DD/CCYY
*drop date
*ren dato date

collapse (mean) impl_volatility, by(date days)

outsheet using tomatlab.csv, delim(,) replace

preserve
keep date
gen nj=date
collapse (max) date, by(nj)
drop nj
outsheet using tomatlab_dates.csv, delim(,) replace
restore

preserve
keep days
gen nj=days
collapse (max) days, by(nj)
drop nj
outsheet using tomatlab_days.csv, delim(,) replace
restore
