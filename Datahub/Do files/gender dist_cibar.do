* Set a professional scheme
set scheme white_tableau

* Load and prepare data
use "C:\Users\ashai\Dropbox\PC (2)\Downloads\Non_PII_171_Social_welfare_2025_clean.dta", clear
keep if consent == 1

* Generate binary female variable
gen female = (q1f == 1)

* Apply clean labels to respondent types
label define res_type_lbl 1 "UNO" 2 "SWO" 3 "WAO" 4 "PIO"
label values res_type res_type_lbl

* Generate CI bar graph
cibar female, over(res_type) ///
    level(95) ///
    ciopts(lcolor(black) lwidth(medium)) ///
    barcolor("74 134 232") ///
    bargap(30) ///
    graphopts( ///
        ytitle("Proportion Female", size(medsmall)) ///
        xtitle("Respondent Type", size(medsmall)) ///
        title("Gender Composition by Respondent Type", size(medsmall)) ///
        note("95% Confidence Intervals", size(vsmall)) ///
        ylabel(0(.1)1, labsize(small)) ///
        xlabel(, labsize(small)) ///
        graphregion(color(white)) ///
        plotregion(margin(small)) ///
        bgcolor(white) ///
    )

* Adjust display size
graph display, xsize(6.5) ysize(4.5)
