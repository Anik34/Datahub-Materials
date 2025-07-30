
use "D:\Datahub-Materials\Datahub\Datasets\Non_PII_171_Social_welfare_2025_clean.dta",clear
keep if consent==1

set scheme white_tableau

preserve

keep q8f
clonevar q8f_2=q8f
recode *_2(1=0)(0=1)
collapse (mean) q8f*
ren (q8f q8f_2) (yes no)
gen question=1
cd "D:\Datahub-Materials\Datahub\Files_experiment"
save question1,replace

restore

preserve

keep q10f
clonevar q10f_2=q10f
recode *_2(1=0)(0=1)
collapse (mean) q10f*
gen question=2
ren (q10f q10f_2) (yes no)
save question2,replace

restore

preserve

keep q13f
clonevar q13f_2=q13f
recode *_2(1=0)(0=1)
collapse (mean) q13f*
gen question=3
ren (q13f q13f_2) (yes no)
save question3,replace

restore

preserve

keep q15f
clonevar q15f_2=q15f
recode *_2(1=0)(0=1)
collapse (mean) q15f*
gen question=4
ren (q15f q15f_2) (yes no)
save question4,replace

restore

preserve

keep q16f
clonevar q16f_2=q16f
recode *_2(1=0)(0=1)
collapse (mean) q16f*
gen question=5
ren (q16f q16f_2) (yes no)
save question5,replace

restore

preserve

keep q18f
clonevar q18f_2=q18f
recode *_2(1=0)(0=1)
collapse (mean) q18f*
gen question=6
ren (q18f q18f_2) (yes no)
save question6,replace

restore

use "D:\Datahub-Materials\Datahub\Files_experiment\question1.dta",clear
append using "D:\Datahub-Materials\Datahub\Files_experiment\question2.dta"
append using "D:\Datahub-Materials\Datahub\Files_experiment\question3.dta"
append using "D:\Datahub-Materials\Datahub\Files_experiment\question4.dta"
append using "D:\Datahub-Materials\Datahub\Files_experiment\question5.dta"
append using "D:\Datahub-Materials\Datahub\Files_experiment\question6.dta"


generate str var4 = "Is electricity consistently available during office hours?" in 1
replace var4 = "Does this office have a backup power supply?" in 2
replace var4 = "Does the office have a reliable wireless internet connection?" in 3
replace var4 = "Does slow internet connectivity hinder your work?" in 4
replace var4 = "Are there additional technical equipments available? " in 5
replace var4 = "Is there a shortage of office staff?" in 6
ren var4 q

graph hbar yes no if quest==1, percent over(quest, gap(1)) over(q, gap(5)) ///
stack legend(off) blabel(bar, pos(center) format(%3.0f) size(medium) color(black)) ///
yscale(off) yline(20 40 60 80) name(a, replace)

graph hbar yes no if quest==2, percent over(quest, gap(1)) over(q, gap(5)) ///
stack legend(off) blabel(bar, pos(center) format(%3.0f) size(medium) color(black)) ///
yscale(off) yline(20 40 60 80) name(b, replace)

graph hbar yes no if quest==3, percent over(quest, gap(1)) over(q, gap(5)) ///
stack legend(off) blabel(bar, pos(center) format(%3.0f) size(medium) color(black)) ///
yscale(off) yline(20 40 60 80) name(c, replace)

graph hbar yes no if quest==4, percent over(quest, gap(1)) over(q, gap(5)) ///
stack legend(off) blabel(bar, pos(center) format(%3.0f) size(medium) color(black)) ///
yscale(off) yline(20 40 60 80) name(d, replace)

graph hbar yes no if quest==5, percent over(quest, gap(1)) over(q, gap(5)) ///
stack legend(off) blabel(bar, pos(center) format(%3.0f) size(medium) color(black)) ///
yscale(off) yline(20 40 60 80) name(e, replace)
/*
graph hbar yes no if quest==6, percent over(quest, gap(1)) over(q, gap(10)) ///
stack legend(off) yscale(off) yline(20 40 60 80) name(f, replace)


graph hbar yes no if quest==6, percent over(quest, gap(1)) over(q, gap(20)) ///
stack legend(position(6) rows(1) label(1 "Yes") label(0 "No")) ///
yline(20 40 60 80) name(f, replace)
*/

graph hbar yes no if quest==6, percent over(quest, gap(1)) over(q, gap(5)) ///
stack legend(position(6) rows(1) label(1 "Yes") label(2 "No")) ///
blabel(bar, pos(center) format(%3.0f) size(medium) color(black)) ///
yline(20 40 60 80) yscale(off) name(f, replace)

grc1leg a b c d e f, cols(1) imargin(0 0 0 0) ycommon xcommon legend(f)
