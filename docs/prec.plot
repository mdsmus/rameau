set terminal png
set output "prec-tree.png"

set xrange [5:110]
set yrange [0:100]

set grid

set xlabel "Chord type"
set ylabel "Precision (%)"

plot "prec.data" using 1:3:11 title "E-mode-tree" with boxes ls 2 fs solid, \
 "prec.data" using ($1+1):6:11 title "Mode-tree" with boxes ls 5 fs solid, \
 "prec.data" using ($1+2):7:11 title "Chord-tree" with boxes ls 6 fs solid, \
 "prec.data" using ($1+3):10:11 title "E-chord-tree" with boxes ls 9 fs solid 

set output "prec-pardo.png"

plot "prec.data" using 1:4:11 title "incf-pb" with boxes ls 3 fs solid , \
 "prec.data" using ($1+1):9:11 title "Pardo" with  boxes ls 1 fs solid
