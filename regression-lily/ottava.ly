
\header
{
  texidoc = "Ottava brackets are supported, through the
use of the scheme function @code{set-octavation}.

The spanner should go below a staff for 8va bassa, and the ottavation
string can be tuned with @code{Staff.ottavation}.

"

}
\version "2.10.0"

%% . There must be a minimum distance between the octavation line and the
%%   topmost staff line, taking into account the height of the closing
%%   vertical dashed line.
				%
%% . Octavation lines broken across staves must always start with `8va'
%%   (or something similar).
				%
%% . The `8va' should be slightl offset to the left.
				%
%% . The final vertical dashed line of the octavation line should be offset
%%   to the right.
				%
%% . Octavation lines for `8va bassa' must be below the staff, not above.
				%
%% . The `8va bassa' string is far too long for short octavation lines.
%%   LilyPond should select between `8va bassa', `8ba', and `8', depending
%%   on the available horizontal space (and the octavation style selected
%%   by the user).  The same holds for `8va' and `15ma'.


\layout { ragged-right = ##t} 

\relative c'''  {
  a b c a
  #(set-octavation 1)
  a b c a
  #(set-octavation 0)
  #(set-octavation 2)
  a b c a
  #(set-octavation 0)
  #(set-octavation -1)
  a b c a 
  #(set-octavation 0)
  \break
  a, 
  #(set-octavation 1)
  \set Staff.ottavation = #"8"
  b
  #(set-octavation 0)
  c a 
  #(set-octavation -1) b a g 
  #(set-octavation 0)
  c 
  #(set-octavation -1)
  \set Staff.ottavation = #"8"
  c,,16
  #(set-octavation 0)
  c'16
  #(set-octavation -1)
  \set Staff.ottavation = #"8"
  g,,16
}


