
use "C:\Users\Hi\Downloads\Non_PII_171_Social_welfare_2025_clean.dta", clear
keep if consent == 1 & !missing(q7o)

* Step 1: Contract frequency of q7o
contract q7o, freq(freq)
sort q7o
gen xpos = _n  // simple positions: 1 to 5

* Step 2: Create label for counts
gen count_lbl = string(freq)

* Step 3: Basic vertical bar graph using twoway
twoway ///
  (bar freq xpos if q7o==1, barw(0.6) color("120 33 82")) ///
  (bar freq xpos if q7o==2, barw(0.6) color("245 171 41")) ///
  (bar freq xpos if q7o==3, barw(0.6) color("41 128 185")) ///
  (bar freq xpos if q7o==4, barw(0.6) color("39 174 96")) ///
  (bar freq xpos if q7o==5, barw(0.6) color("192 57 43")) ///
  (scatter freq xpos, msymbol(none) mlabel(count_lbl) ///
     mlabcolor(black) mlabsize(small) mlabpos(12)), ///
  xlabel(1 "Not Confident" 2 "Lacks confidence" 3 "Fairly" 4 "Quite" 5 "Very", angle(0)) ///
  ytitle("Number of Respondents") xtitle("") ///
  title("Overall Confidence in Using and Interpreting Data") ///
  legend(off) ///
  graphregion(color(white))

graph export "D:\IGC_Datahub\Analysis\New folder\Ready Files\Data Interpretation_1.pdf", as(pdf) name("Graph") replace

use "C:\Users\Hi\Downloads\Non_PII_171_Social_welfare_2025_clean.dta", clear
keep if consent == 1 & inlist(q7o, 3, 4, 5) & !missing(res_type)

* Step 1: Generate frequency table
contract res_type q7o, freq(freq)

* Step 2: Generate xpos for spacing between groups
gen xpos = .
foreach r in 1 2 3 4 {
    local base = 2 + (`r'-1)*5
    forvalues q = 3/5 {
        local pos = `q' - 2
        replace xpos = `base' + `pos' if res_type == `r' & q7o == `q'
    }
}

* Step 3: Label the bars with frequency counts
gen count_lbl = string(freq)

* Step 4: Plot twoway bar graph (colors styled per q7o category)
twoway ///
  (bar freq xpos if q7o==3, barw(0.6) color("41 128 185") lcolor(black)) /// Fairly confident
  (bar freq xpos if q7o==4, barw(0.6) color("39 174 96") lcolor(black)) /// Quite confident
  (bar freq xpos if q7o==5, barw(0.6) color("192 57 43") lcolor(black)) /// Very confident
  (scatter freq xpos, msymbol(none) mlabel(count_lbl) ///
     mlabcolor(black) mlabsize(small) mlabpos(12)), ///
  xlabel(3 "UNO" 8 "SWO" 13 "WAO" 18 "PIO", noticks labsize(medsmall)) ///
  xtitle("") ///
  ytitle("Number of Respondents", size(medsmall)) ///
  title("Confidence Level by Respondent Type (Categories 3–5)", size(medium)) ///
  legend(order(1 "Fairly confident" 2 "Quite confident" 3 "Very confident") ///
         pos(12) row(1) size(small) region(lcolor(white))) ///
  graphregion(color(white)) ///
  ylab(, glcolor(gs14) glwidth(vthin)) ///
  xsize(20) ysize(10)

  graph export "D:\IGC_Datahub\Analysis\New folder\Ready Files\Data Interpretation_2.pdf", as(pdf) name("Graph")