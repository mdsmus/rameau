\header {

    texidoc = "Stem lengths for grace notes should be shorter than
normal notes, if possible. They should never be longer, even if that
would lead to beam quanting program. "
	 
    }
\version "2.10.0"

\layout {
    ragged-right = ##t

%    "debug-beam-quanting" = ##t 
}
\relative c'' {
    << {  d8.\noBeam d16 } \\ >>   \grace { d16 } c8.[ b16]
    << {  c16[ b] } \\ >>
    
    \grace { c16[ b] } d4
%    \override Beam #'inspect-quants =#'(2.8 . 2.5)
%    \grace { c16[ b] } d4

	    }

