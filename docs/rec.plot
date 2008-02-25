set terminal png
set output "rec-tree.png"

set xrange [-5:110]
set yrange [0:100]

set grid

set xlabel "Chord type"
set ylabel "Recall (%)"


set label "maior" at first 0, first -1
set label "maior7" at first 10, first -1
set label "maior7+" at first 20, first -1
set label "menor" at first 30, first -1
set label "menor7" at first 40, first -1
set label "dim" at first 50, first -1
set label "dim7" at first 60, first -1
set label "hdim" at first 70, first -1
set label "aug" at first 80, first -1
set label "mel" at first 90, first -1
set label "inc" at first 100, first -1


plot "rec.data" using 1:2:(0.5) title "E-mode-tree" with boxes ls 2 fs solid, \
 "rec.data" using ($1+1):5:(0.5) title "Mode-tree" with boxes ls 5 fs solid, \
 "rec.data" using ($1+2):6:(0.5) title "Chord-tree" with boxes ls 6 fs solid, \
 "rec.data" using ($1+3):9:(0.5) title "E-chord-tree" with boxes ls 9 fs solid 

set output "rec-pardo.png"

plot "rec.data" using 1:3:(0.5) title "incf-pb" with boxes ls 3 fs solid , \
 "rec.data" using ($1+1):8:(0.5) title "Pardo" with  boxes ls 1 fs solid
