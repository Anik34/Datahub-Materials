use "C:\Users\Hi\Downloads\Non_PII_171_Social_welfare_2025_clean.dta",clear

keep if consent == 1

* Step 1: Count frequency by res_type × gender
contract res_type q1f

* Step 2: Total per res_type for percentage
egen total = sum(_freq), by(res_type)
gen pct = _freq / total

* Step 3: Standard error and 95% confidence interval
gen se = sqrt(pct * (1 - pct) / _freq)
replace se = 0 if _freq == 0  // Avoid NaNs
gen hiz = pct + 1.96 * se
gen loz = pct - 1.96 * se
replace loz=0 if loz<0 
replace hiz=1 if hiz>1

* Step 4: Create X-axis positions for each group (spacing)
gen xpos = .
replace xpos = res_type * 3 - 0.5 if q1f == 1  // Female
replace xpos = res_type * 3 + 0.5 if q1f == 2  // Male

* Step 5: Label formatting
label define genderlbl 1 "Female" 2 "Male"
label values q1f genderlbl

gen xpos_label = xpos + 0.02
gen pct_label = pct + 0.01
gen barlabel = pct * 100
format barlabel %4.1f

* Step 6: Final graph with CI and labels
twoway ///
  (bar pct xpos if q1f == 1, barwidth(0.8) color("120 33 82") fintensity(inten100)) ///
  (bar pct xpos if q1f == 2, barwidth(0.8) color("245 171 41") fintensity(inten100)) ///
  (rcap hiz loz xpos, lcolor(black) lwidth(medium)) ///
  (scatter pct_label xpos_label, msymbol(none) ///
     mlabel(barlabel) mlabpos(2) mlabcolor(black) mlabsize(small)), ///
  xlabel(3 "UNO" 6 "SWO" 9 "WAO" 12 "PIO", labsize(medsmall) noticks) ///
  ytitle("Share of respondents") ///
  xtitle("") ///
  title("Gender Distribution by Respondent Type", size(medium)) ///
  legend(order(1 "Female" 2 "Male") col(2) pos(6) size(small) region(lcolor(white))) ///
  graphregion(color(white)) xscale(noline)
