
use "C:\Users\Hi\Downloads\171_Social_welfare_2025_clean_20 Jul 2025.dta", clear

keep if consent==1

egen avg_exp = mean(q4f), by(res_type q1f)
egen tag = tag(res_type q1f)

label define officers 1 "UNO" 2 "SWO" 3 "WAO" 4 "PIO"
label values res_type officers

label define gender 1 "FEMALE" 2 "MALE"
label values q1f gender

tabplot res_type q1f if tag [iw=avg_exp], ///
    horizontal barwidth(0.2) ///
    bfcolor(none) ///
    separate(q1f) ///
    bar1(bcolor(blue)) bar2(bcolor(pink)) ///
    showval(format(%3.1f)) ///
    subtitle("Average Work Experience by Respondent Category and Gender", ///
             pos(12) box bexpand justification(center)) ///
    ytitle("Respondent Category") ///
    ylabel(, noticks nogrid angle(horizontal)) ///
    yscale(noline) ///
	xlabel(, noticks nogrid angle(horizontal)) ///
    xscale(noline)
