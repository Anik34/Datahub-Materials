
set scheme white_tableau

use "C:\Users\Hi\Downloads\Non_PII_171_Social_welfare_2025_clean.dta",clear

keep if consent==1


*** We have dropped observations because it was close to 0.5% for the sub-categories.
*** If we try to show the categories, the graph takes an awkward shape because the 
*** bar width is determined by how many observations are determined by each of the 
*** sub-categories present.

drop if res_type==2 & q5o==2 
drop if res_type==4 & q5o==1

label define position 1"UNO" 2 "SWO" 3 "WAO" 4"PIO"
label values res_type position

graph hbar, /// basic horizontal bar graph command (can make vertical by removing "h")
over(q5o) /// the groups *within* each bar (values seen within bars)
over(res_type) ///
stack asyvars /// commands needed for stacking bars
percentage ///
ytitle(Percent) ///
scheme(gg_viridis) ///
blabel(bar, pos(center) format(%3.0f) color(white)) /// add percentages
ylab(, glpattern(solid) glcolor(gs15) glwidth(vthin)) ///
legend(pos(6) col(3) title("Variation between technological comfort", size(medsmall) box fcolor(gs6) color(white) lcolor(gs10)) size(medium)) ///
title("Ease of Technology Usage", box fcolor(black) color(white) span bexpand) ///
graphregion(margin(vsmall))  ///
xsize(21.5) ysize(10) /// graph dimensions
bar(1, fintensity(100) fcolor(red%90) lcolor(black) lwidth(vthin)) ///
bar(2, fintensity(100) fcolor(teal%90) lcolor(black) lwidth(vthin)) ///
bar(3, fintensity(100) fcolor(ebblue%90) lcolor(black) lwidth(vthin)) ///
bar(4, fintensity(100) fcolor(orange%90) lcolor(black) lwidth(vthin)) ///
bar(5, fintensity(100) fcolor(green%90) lcolor(black) lwidth(vthin)) //

