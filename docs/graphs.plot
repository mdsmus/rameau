set terminal png

set xrange [-5:115]
set yrange [0:100]

set xtics 0

set grid

set xlabel "Chord type"
set ylabel "Precision (%)"

set label "maior" at first -3, first -1
set label "maior7" at first 7, first -1
set label "maior7+" at first 17, first -1
set label "menor" at first 27, first -1
set label "menor7" at first 37, first -1
set label "dim" at first 47, first -1
set label "dim7" at first 57, first -1
set label "hdim" at first 67, first -1
set label "aug" at first 77, first -1
set label "mel" at first 87, first -1
set label "inc" at first 97, first -1


# Ordem:
#   EC-Knn    EC-net    ES-Knn  ES-Pardo    ES-net   ES-tree  S-Pardo-     S-net    S-tree
# 1  2        3         4       5           6        7        8            9        10

## Precision

set output "prec-tree.png"

plot "prec.data" using 1:10:(0.5) title "S-tree" with boxes ls 2 fs solid, \
     "prec.data" using ($1+1):7:(0.5) title "ES-tree" with boxes ls 5 fs solid

set output "prec-pardo.png"

plot "prec.data" using 1:5:(0.5) title "ES-Pardo" with boxes ls 3 fs solid , \
 "prec.data" using ($1+1):8:(0.5) title "S-Pardo" with  boxes ls 1 fs solid

set output "prec-net.png"

plot "prec.data" using 1:9:(0.5) title "S-net" with boxes ls 2 fs solid, \
     "prec.data" using ($1+1):6:(0.5) title "ES-net" with boxes ls 5 fs solid, \
     "prec.data" using ($1+2):3:(0.5) title "EC-net" with boxes ls 3 fs solid  

set output "prec-knn.png"

plot "prec.data" using 1:4:(0.5) title "ES-knn" with boxes ls 2 fs solid, \
     "prec.data" using ($1+1):2:(0.5) title "EC-knn" with boxes ls 5 fs solid

set output "prec-geral.png"

plot \
     "prec.data" using ($1-3):2:(0.5) title "EC-knn" with boxes ls 9 fs solid, \
     "prec.data" using ($1-2):4:(0.5) title "ES-knn" with boxes ls 8 fs solid, \
     "prec.data" using ($1-1):3:(0.5) title "EC-net" with boxes ls 7 fs solid, \
     "prec.data" using 1:10:(0.5) title "S-tree" with boxes ls 2 fs solid, \
     "prec.data" using ($1+1):7:(0.5) title "ES-tree" with boxes ls 5 fs solid, \
     "prec.data" using ($1+2):5:(0.5) title "ES-Pardo" with boxes ls 3 fs solid , \
     "prec.data" using ($1+3):8:(0.5) title "S-Pardo" with  boxes ls 1 fs solid, \
     "prec.data" using ($1+4):9:(0.5) title "S-net" with boxes ls 4 fs solid, \
     "prec.data" using ($1+5):6:(0.5) title "ES-net" with boxes ls 6 fs solid

## Recall
set ylabel "Recall (%)"

set output "rec-tree.png"

plot "rec.data" using 1:10:(0.5) title "S-tree" with boxes ls 2 fs solid, \
     "rec.data" using ($1+1):7:(0.5) title "ES-tree" with boxes ls 5 fs solid

set output "rec-pardo.png"

plot "rec.data" using 1:5:(0.5) title "ES-Pardo" with boxes ls 3 fs solid , \
 "rec.data" using ($1+1):8:(0.5) title "S-Pardo" with  boxes ls 1 fs solid

set output "rec-net.png"

plot "rec.data" using 1:9:(0.5) title "S-net" with boxes ls 2 fs solid, \
     "rec.data" using ($1+1):6:(0.5) title "ES-net" with boxes ls 5 fs solid, \
     "rec.data" using ($1+2):3:(0.5) title "EC-net" with boxes ls 3 fs solid  

set output "rec-knn.png"

plot "rec.data" using 1:4:(0.5) title "ES-knn" with boxes ls 2 fs solid, \
     "rec.data" using ($1+1):2:(0.5) title "EC-knn" with boxes ls 5 fs solid

set output "rec-geral.png"

plot \
     "rec.data" using ($1-3):2:(0.5) title "EC-knn" with boxes ls 9 fs solid, \
     "rec.data" using ($1-2):4:(0.5) title "ES-knn" with boxes ls 8 fs solid, \
     "rec.data" using ($1-1):3:(0.5) title "EC-net" with boxes ls 7 fs solid, \
     "rec.data" using 1:10:(0.5) title "S-tree" with boxes ls 2 fs solid, \
     "rec.data" using ($1+1):7:(0.5) title "ES-tree" with boxes ls 5 fs solid, \
     "rec.data" using ($1+2):5:(0.5) title "ES-Pardo" with boxes ls 3 fs solid , \
     "rec.data" using ($1+3):8:(0.5) title "S-Pardo" with  boxes ls 1 fs solid, \
     "rec.data" using ($1+4):9:(0.5) title "S-net" with boxes ls 4 fs solid, \
     "rec.data" using ($1+5):6:(0.5) title "ES-net" with boxes ls 6 fs solid
