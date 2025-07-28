use "C:\Users\Hi\Downloads\Non_PII_171_Social_welfare_2025_clean.dta", clear

keep if consent == 1

* Step 1: Frequency by res_type × q6f
contract res_type q6f

* Step 2: Calculate share and CI
egen total = sum(_freq), by(res_type)
gen pct = _freq / total

gen se  = sqrt(pct * (1 - pct) / _freq)
replace se = 0 if _freq == 0
gen hiz = min(pct + 1.96 * se, 1)
gen loz = max(pct - 1.96 * se, 0)

* Step 3: Create xpos for 4 groups × 5 categories
gen xpos = .
foreach g in 1 2 3 4 {
    local base = 3 + (`g'-1)*7
    forvalues t = 1/5 {
        replace xpos = `base' + (`t'-1) if res_type == `g' & q6f == `t'
    }
}

* Step 4: Bengali numeral formatting
gen label_en = string(round(pct*100, 0.1), "%4.1f")
gen barlabel_bn = label_en
replace barlabel_bn = subinstr(barlabel_bn, "0", "০", .)
replace barlabel_bn = subinstr(barlabel_bn, "1", "১", .)
replace barlabel_bn = subinstr(barlabel_bn, "2", "২", .)
replace barlabel_bn = subinstr(barlabel_bn, "3", "৩", .)
replace barlabel_bn = subinstr(barlabel_bn, "4", "৪", .)
replace barlabel_bn = subinstr(barlabel_bn, "5", "৫", .)
replace barlabel_bn = subinstr(barlabel_bn, "6", "৬", .)
replace barlabel_bn = subinstr(barlabel_bn, "7", "৭", .)
replace barlabel_bn = subinstr(barlabel_bn, "8", "৮", .)
replace barlabel_bn = subinstr(barlabel_bn, "9", "৯", .)

* Step 5: Label positioning
gen labelpos = hiz + 0.05

/*
twoway ///
  (bar pct xpos if q6f==1, barwidth(0.6) color("120 33 82") fintensity(inten100)) ///
  (bar pct xpos if q6f==2, barwidth(0.6) color("245 171 41") fintensity(inten100)) ///
  (bar pct xpos if q6f==3, barwidth(0.6) color("41 128 185") fintensity(inten100)) ///
  (bar pct xpos if q6f==4, barwidth(0.6) color("39 174 96") fintensity(inten100)) ///
  (bar pct xpos if q6f==5, barwidth(0.6) color("192 57 43") fintensity(inten100)) ///
  (scatter pct xpos, msymbol(none) ///
     mlabel(pct_text) mlabpos(12) mlabcolor(black) mlabsize(small)), ///
  xlabel(5 "UNO" 12 "SWO" 19 "WAO" 26 "PIO", labsize(medsmall) noticks) ///
  ytitle("Share of respondents (%)") ///
  xtitle("") ///
  title("Training Type by Respondent Type", size(medium) pos(6)) ///
  legend(order(1 "No training" 2 "On-the-job" 3 "Formal" 4 "Both types" 5 "Informal") ///
         col(3) pos(12) size(small) region(lcolor(white))) ///
  graphregion(color(white)) xscale(noline) ///
  xsize(21.5) ysize(10)
*/
  
* Step 6: Final graph
twoway ///
  (bar pct xpos if q6f==1, barwidth(0.6) color("120 33 82") fintensity(inten100)) ///
  (bar pct xpos if q6f==2, barwidth(0.6) color("245 171 41") fintensity(inten100)) ///
  (bar pct xpos if q6f==3, barwidth(0.6) color("41 128 185") fintensity(inten100)) ///
  (bar pct xpos if q6f==4, barwidth(0.6) color("39 174 96") fintensity(inten100)) ///
  (bar pct xpos if q6f==5, barwidth(0.6) color("192 57 43") fintensity(inten100)) ///
  (rcap hiz loz xpos, lcolor(black) lpattern(solid) lwidth(vthin)) ///
  (scatter labelpos xpos, msymbol(none) ///
     mlabel(barlabel_bn) mlabpos(0) mlabcolor(black) mlabsize(small)), ///
  xlabel(5 "UNO" 12 "SWO" 19 "WAO" 26 "PIO", labsize(medsmall) noticks) ///
  ytitle("উত্তরদাতার হার (%)", size(medsmall)) ///
  xtitle("") ///
  title("বিভিন্ন উত্তরদাতার মধ্যে প্রশিক্ষণ প্রাপ্তির পার্থক্য", size(medium)) ///
  legend(order(1 "প্রশিক্ষণ  পাইনি " 2 "কর্মক্ষেত্রে পেয়েছি" 3 "কর্মক্ষেত্রের বাইরে পেয়েছি" 4 "দুটিই পেয়েছি" 5 "নিজে শিখেছি") ///
       keygap (4pt) row(2) col(3) colgap(20) pos(6) size(small) region(lcolor(white))) ///
  graphregion(color(white)) xscale(noline) ///
  xsize(21.5) ysize(10)

  /*
  
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


*/