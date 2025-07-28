
*-----------------------------
* Create Donut Chart in Stata
*-----------------------------

* Load example dataset
use "C:\Users\Hi\Downloads\171_Social_welfare_2025_clean_20 Jul 2025.dta",clear

* Create base pie chart
graph pie, over(q1f) scheme(white_tableau) plabel(_all percent,format("%2.0f") gap (+5) size(medlarge)) legend(title(Gender) label(1 "Female") label(2 "Male"))
graph save donut_base, replace

* Add donut hole using gr_edit
local csize = 60  // Change this to adjust size of donut hole

gr_edit .plotregion1.AddMarker added_markers editor ///
    .0715713654788885 -.0361049561829105
gr_edit .plotregion1.added_markers_new = 1
gr_edit .plotregion1.added_markers_rec = 1
gr_edit .plotregion1.added_markers[1].style.editstyle marker( ///
    symbol(circle) ///
    linestyle(width(sztype(relative) val(.2) allow_pct(1)) color(white) ///
              pattern(solid) align(inside)) ///
    fillcolor(white) ///
    size(sztype(relative) val(`=`csize'*0.93') allow_pct(1)) ///
    angle(stdarrow) symangle(zero) ///
    backsymbol(none) ///
    backline(width(sztype(relative) val(.2) allow_pct(1)) color(black) ///
             pattern(solid) align(inside)) ///
    backcolor(black) ///
    backsize(sztype(relative) val(0) allow_pct(1)) ///
    backangle(stdarrow) backsymangle(zero)) ///
    line(width(sztype(relative) val(.2) allow_pct(1)) color(black) ///
         pattern(solid) align(inside)) ///
    area(linestyle(width(sztype(relative) val(.2) allow_pct(1)) ///
                   color(ltbluishgray) pattern(solid) align(inside)) ///
         shadestyle(color(ltbluishgray) intensity(inten100) fill(pattern10))) ///
    label(textstyle(horizontal(center) vertical(middle) angle(default) ///
                    size(sztype(relative) val(2.777) allow_pct(1)) color(black) ///
                    position() margin(gleft(sztype(relative) val(0) allow_pct(1)) ///
                                     gright(sztype(relative) val(0) allow_pct(1)) ///
                                     gtop(sztype(relative) val(0) allow_pct(1)) ///
                                     gbottom(sztype(relative) val(0) allow_pct(1))) ///
                    linestyle(width(sztype(relative) val(.2) allow_pct(1)) ///
                              color(black) pattern(solid) align(inside))) ///
          position(6) ///
          textgap(sztype(relative) val(.6944) allow_pct(1)) format("") ///
          horizontal(default) vertical(default)) ///
    dots(symbol(circle) ///
         linestyle(width(sztype(relative) val(.2) allow_pct(1)) color(black) ///
                   pattern(solid) align(inside)) ///
         fillcolor(black) size(sztype(relative) val(.1) allow_pct(1)) ///
         angle(horizontal) symangle(zero) ///
         backsymbol(none) backline(width(sztype(relative) val(.2) allow_pct(1)) ///
                                   color(black) pattern(solid) align(inside)) ///
         backcolor(black) backsize(sztype(relative) val(1.52778) allow_pct(1)) ///
         backangle(horizontal) backsymangle(zero)) ///
    connect(direct) connect_missings(yes)

* Save donut chart
graph save donut_chart_final, replace
