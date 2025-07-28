use "C:\Users\Hi\Downloads\Non_PII_171_Social_welfare_2025_clean.dta",clear

keep if consent == 1

* Step 1: Count frequency by res_type × gender
contract res_type q6f

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

// UNO = res_type 1 → xpos: 3 to 7
replace xpos = 3 if res_type==1 & q6f==1
replace xpos = 4 if res_type==1 & q6f==2
replace xpos = 5 if res_type==1 & q6f==3
replace xpos = 6 if res_type==1 & q6f==4
replace xpos = 7 if res_type==1 & q6f==5

// SWO = res_type 2 → xpos: 10 to 14
replace xpos = 10 if res_type==2 & q6f==1
replace xpos = 11 if res_type==2 & q6f==2
replace xpos = 12 if res_type==2 & q6f==3
replace xpos = 13 if res_type==2 & q6f==4
replace xpos = 14 if res_type==2 & q6f==5

// WAO = res_type 3 → xpos: 17 to 21
replace xpos = 17 if res_type==3 & q6f==1
replace xpos = 18 if res_type==3 & q6f==2
replace xpos = 19 if res_type==3 & q6f==3
replace xpos = 20 if res_type==3 & q6f==4
replace xpos = 21 if res_type==3 & q6f==5

// PIO = res_type 4 → xpos: 24 to 28
replace xpos = 24 if res_type==4 & q6f==1
replace xpos = 25 if res_type==4 & q6f==2
replace xpos = 26 if res_type==4 & q6f==3
replace xpos = 27 if res_type==4 & q6f==4
replace xpos = 28 if res_type==4 & q6f==5

gen xpos_label = xpos + 0.02
gen pct_label = pct + 0.01
gen barlabel = pct * 100
format barlabel %4.1f

gen pct_text = string(round(pct*100, 0.1)) + "%"
gen labelpos = hiz + 0.05  // Adjust 0.01 to move higher if needed


* Step 6: Final graph with CI and labels
twoway ///
  (bar pct xpos if q6f==1, barwidth(0.6) color("120 33 82") fintensity(inten100)) ///
  (bar pct xpos if q6f==2, barwidth(0.6) color("245 171 41") fintensity(inten100)) ///
  (bar pct xpos if q6f==3, barwidth(0.6) color("41 128 185") fintensity(inten100)) ///
  (bar pct xpos if q6f==4, barwidth(0.6) color("39 174 96") fintensity(inten100)) ///
  (bar pct xpos if q6f==5, barwidth(0.6) color("192 57 43") fintensity(inten100)) ///
  (rcap hiz loz xpos, lcolor(black) lpattern(solid) lwidth(vthin)) ///
  (scatter labelpos xpos, msymbol(none) ///
     mlabel(barlabel) mlabpos(0) mlabcolor(black) mlabsize(small)), ///
  xlabel(5 "UNO" 12 "SWO" 19 "WAO" 26 "PIO", labsize(medsmall) noticks) ///
  ytitle("Share of respondents") ///
  xtitle("") ///
  title("Training Type by Respondent Type", size(medium)) ///
  legend(order(1 "No training" 2 "On-the-job" 3 "Formal" 4 "Both types" 5 "Informal") ///
         col(3) pos(6) size(small) region(lcolor(white))) ///
  graphregion(color(white)) xscale(noline) ///
  xsize(21.5) ysize(10)


