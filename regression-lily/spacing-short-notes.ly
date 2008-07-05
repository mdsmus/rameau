
\version "2.10.0"
\header {
  
  texidoc = "Notes that are shorter than the common shortest note get a
space (i.e. without the space needed for the note) proportional to
their duration. So, the 16th notes get 1/2 of the space of an eigth note.
The total distance for a 16th (which includes note head) is 3/4 of the
eighth note. "

}

\layout { ragged-right = ##t}

\relative c''
{
  \time 2/4 
  c16 c c c c4 c4
  c8 c8 c8 c8
  c8 c8 c4
  c8 c8 c4

}




