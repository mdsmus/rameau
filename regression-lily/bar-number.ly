
\version "2.10.0"

\header {

texidoc="Bar number may be set and their padding adjusted individually.  
The counting of bar numbers is started after the anacrusis.

To prevent clashes at the beginning of a line, the padding may have to 
be increased.
"

}

\layout {
  ragged-right = ##t
}

\relative c'' {
  \override Score.BarNumber #'break-visibility = #all-visible
  \partial 4 c4 
  c1 c c
  \set Score.currentBarNumber = #99999
  \override Score.BarNumber  #'padding = #3
  c1 c
}
