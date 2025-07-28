
use "C:\Users\Hi\Downloads\171_Social_welfare_2025_clean_20 Jul 2025.dta", clear

/*
set scheme white_tableau

egen avg_exp = mean(q4f), by(res_type)

egen tag = tag(res_type)




tabplot res_type [iw=avg_exp] if tag, showval(format(%2.1f)) ///
bfcolor(blue*0.3)  ///
subtitle("Average Work Experience by Respondent Category", ///
pos(12) box bexpand justification(center)) ///
ytitle("Respondent Category") horizontal ///
barwidth(0.15) ylabel(, noticks nogrid angle(horizontal)) ///
yscale(noline) sep(res_type)
*/

label define officers 1 "UNO" 2 "SWO" 3 "WAO" 4 "PIO"
label values res_type officers

label define age 1 "<1" 2 "1-3" 3 "3-5" 4 "5-10" 5 "10+"
label values q4f age

/*
graph hbar, ///
over(q4f) /// the groups *within* each bar 
stack asyvars /// commands needed for stacking bars
blabel(bar, pos(center) format(%3.0f) size(medium) color(black)) /// add percentage labels
scheme(swift_red)


*#Stacked bar graph for a relationship between two variables

graph hbar, /// basic horizontal bar graph command (can make vertical by removing "h")
over(q4f) /// the groups *within* each bar (values seen within bars)
over(res_type) /// the groups that appear on the axis, identifying each stacked bar
stack asyvars /// commands needed for stacking bars
percentage /// necessary for communicating percentages within each category of second over() variable
ylab(, glpattern(solid) glcolor(gs15)) /// add vertical solid light gray lines
blabel(bar, pos(center) format(%3.0f) size(medium) color(white)) /// add percentages
legend(pos(6) row(1) title("Age Group of Mother", size(medsmall) margin(vsmall) box fcolor(black) color(white) lcolor(gs10)) size(medium)) ///
ytitle(Percent of Sample) /// title y-axis
graphregion(margin(small)) /// make region between plot and outer edge of graph size small
xsize(6.5) ysize(4.5) // make graph 6.5 inches wide and 4.5 inches tall

graph hbar, /// basic horizontal bar graph command (can make vertical by removing "h")
over(q4f) /// the groups *within* each bar (values seen within bars)
over(res_type, gap(200)) /// note use of "gap()" to adjust distances / widths of stacked bars
stack asyvars /// 
percentage ///
ytitle(Percent) ///
scheme(white_viridis) /// set scheme
plotregion(fcolor(gs15)) /// fill plot region with gs15 color
blabel(bar, pos(center) format(%3.0f) size(medium) color(gs4)) /// add percentages
ylab(, glpattern(solid) glcolor(gs12) glwidth(vthin)) ///
legend(pos(6) row(1) title("Age Group of Mother", size(medsmall) box fcolor(black) color(white) lcolor(gs10)) size(medium)) ///
title("Relationship Between Mothers' Race & Age Group", box fcolor(white) color(black) span) ///
graphregion(margin(vsmall)) ///
xsize(8.5) ysize(6.5) // graph dimensions

graph hbar, /// basic horizontal bar graph command (can make vertical by removing "h")
over(q4f) /// the groups *within* each bar (values seen within bars)
over(res_type) ///
stack asyvars /// commands needed for stacking bars
percentage ///
ytitle(Percent) ///
scheme(white_tableau) ///
blabel(bar, pos(center) format(%3.0f) size(medium) color(white)) /// add percentages
ylab(, glpattern(solid) glcolor(gs15) glwidth(vthin)) ///
legend(pos(6) row(1) title("Age Group of Mother", size(medsmall) box fcolor(gs6) color(white) lcolor(gs10)) size(medium)) ///
title("Relationship Between Mothers' Race & Age Group", box fcolor(black) color(white) span bexpand) ///
graphregion(margin(vsmall)) ///
xsize(6.5) ysize(4.5) /// graph dimensions
bar(1, fintensity(100) fcolor(red%90) lcolor(black) lwidth(vthin)) ///
bar(2, fintensity(100) fcolor(stc4%90) lcolor(black) lwidth(vthin)) ///
bar(3, fintensity(100) fcolor(ebblue%90) lcolor(black) lwidth(vthin)) ///
bar(4, fintensity(100) fcolor(stc15%90) lcolor(black) lwidth(vthin)) //
*/

*** forvalues i= 1/3 555 was not working because i=555 has no observations. **


graph hbar, /// basic horizontal bar graph command
over(q4f) /// the groups *within* each bar (values seen within bars)
over(res_type) /// the second over() variable: the values of each stacked bar
over(q1f, label(labcolor(white) angle(vertical))) /// third over() variable 
stack asyvars /// commands needed for stacking bars
percentage /// necessary for communicating percentages within each category
ytitle(Percent) ///	scheme(black_jet) ///
scheme(black_jet) ///
blabel(bar, pos(center) format(%3.0f) size(medium) color(white)) /// add percentages
ylab(, glpattern(solid) glcolor(gs3) glwidth(vthin)) ///
legend(pos(6) row(1) title("Experience at current job", size(medsmall) box fcolor(gs3) color(white) lcolor(gs10)) size(medium)) ///
title("Respondent's Experience at current job", box fcolor(black) color(white) span bexpand) ///
subtitle("Disaggregated by Gender", box fcolor(black) color(white) span bexpand) ///
graphregion(margin(vsmall)) ///
xsize(20) ysize(8) /// graph dimensions
bar(1, fintensity(100) fcolor(blue%95) lcolor(white) lwidth(thin)) ///
bar(2, fintensity(100) fcolor(midblue%95) lcolor(white) lwidth(thin)) ///
bar(3, fintensity(110) fcolor(cyan%95) lcolor(white) lwidth(thin)) /// make intensity a little darker
bar(4, fintensity(100) fcolor(stgreen%95) lcolor(white) lwidth(thin)) //
