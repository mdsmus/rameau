
\header {
  texidoc = "@code{TupletNumber} grobs are always inside slurs.
This may not work if the slur starts after the tuplet.  "
  
}

\version "2.10.0"

\paper {
  ragged-right = ##t
%  #(define debug-slur-scoring #t)
}

\relative {
  \slurUp
  \override TupletBracket #'bracket-visibility = ##f
  \override Slur #'details #'region-size  = #6
  
  \times 2/3
  {
    c(  g'  c,)
  }
}
