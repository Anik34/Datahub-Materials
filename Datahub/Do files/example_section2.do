set scheme white_tableau

clear all
input quest str25 q      a1 a2 a3 a4 a5 a6
1 "Question 1"           0  2  37 45 12 4
1 "Benchmark Q1"         2  5  25 47 17 4
2 "Question 2"           1  37  2 40 17 3
2 "Benchmark Q2"         2  5  25 47  4 17
3 "Question 3"           1  2  40 37 17 3
3 "Benchmark Q3"         2  5  25 47 17 4
4 "Question 4"           1  2  37  17 3 40
4 "Benchmark Q4"         2  5  47 25 17 4
end

graph hbar a1-a6 if quest==1, percent over(quest, gap(1)) over(q, gap(10)) stack legend(off) blabel(bar, pos(center) format(%3.0f) size(medium) color(black)) yscale(off) yline(20 40 60 80) name(a, replace)

graph hbar a1-a6 if quest==2, percent over(quest, gap(1)) over(q, gap(10)) stack legend(off) yscale(off) yline(20 40 60 80) name(b, replace)

graph hbar a1-a6 if quest==3, percent over(quest, gap(1)) over(q, gap(10)) stack legend(off) yscale(off) yline(20 40 60 80) name(c, replace)

graph hbar a1-a6 if quest==4, percent over(quest, gap(1)) over(q, gap(20)) stack legend(position(6) rows(1) label(1 "Missing") label(2 "Never") label(3 "Rarely") label(4 "Occasionly") label(5 "Mostly") label(6 "Always")) yline(20 40 60 80) name(d, replace)

grc1leg a b c d, cols(1) imargin(0 0 0 0) ycommon xcommon legend(d)