\version "2.10.0"

upper = \relative c'' {
        \clef treble
        \key g \major
        \hideNotes 
\override TextScript #'extra-offset = #'( 0.0 . -1.0 )
\fatText 	a1_\markup {Sol maior} \bar "||"
	\unHideNotes
        \key d \major
        \hideNotes 
\fatText 	a1_\markup {Ré maior}  \bar "||"
	\unHideNotes
        \key a \major
        \hideNotes 
\fatText 	a1_\markup {Lá maior}  \bar "||"
	\unHideNotes
        \key e \major
        \hideNotes 
\fatText 	a1_\markup {Mi maior}  \bar "||"
	\unHideNotes
        \key b \major
        \hideNotes 
\fatText 	a1_\markup {Si maior}  \bar "||"
	\unHideNotes
        \key fis \major
        \hideNotes 
\fatText 	a1_\markup {Fá \sharp maior}  \bar "||"
	\unHideNotes
        \key cis \major
        \hideNotes 
\fatText 	a1_\markup {Dó \sharp maior}  \bar "||"
	\unHideNotes
     }


lower = \relative c {
        \clef bass
        \key g \major
        \hideNotes 
\override TextScript #'extra-offset = #'( 0.0 . -1.0 )
\fatText 	a1_\markup {1 sustenido} \bar "||"
	\unHideNotes
        \key d \major
        \hideNotes 
\fatText 	a1_\markup {2 sustenidos}  \bar "||"
	\unHideNotes
        \key a \major
        \hideNotes 
\fatText 	a1_\markup {3 sustenidos}  \bar "||"
	\unHideNotes
        \key e \major
        \hideNotes 
\fatText 	a1_\markup {4 sustenidos}  \bar "||"
	\unHideNotes
        \key b \major
        \hideNotes 
\fatText 	a1_\markup {5 sustenidos}  \bar "||"
	\unHideNotes
        \key fis \major
        \hideNotes 
\fatText 	a1_\markup {6 sustenidos}  \bar "||"
	\unHideNotes
        \key cis \major
        \hideNotes 
\fatText 	a1_\markup {7 sustenidos}  \bar "||"
	\unHideNotes
     }

\score {
    \context GrandStaff <<
         \context Staff = upper { \upper }
         \context Staff = lower { \lower }
	 >>
 	\layout {
        	\context {	\GrandStaff \remove "Time_signature_engraver"
		}
	}
}