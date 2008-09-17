\version "2.10.0"

upper = \relative c'' {
        \clef treble
        \key f \major
        \hideNotes 
\override TextScript #'extra-offset = #'( 0.0 . -1.0 )
\fatText 	a1_\markup {Fá maior} \bar "||"
	\unHideNotes
        \key bes \major
        \hideNotes 
\fatText 	a1_\markup {Si \flat maior}  \bar "||"
	\unHideNotes
        \key ees \major
        \hideNotes 
\fatText 	a1_\markup {Mi \flat maior}  \bar "||"
	\unHideNotes
        \key aes \major
        \hideNotes 
\fatText 	a1_\markup {Lá \flat maior}   \bar "||"
	\unHideNotes
        \key des \major
        \hideNotes 
\fatText 	a1_\markup {Ré \flat maior}   \bar "||"
	\unHideNotes
        \key ges \major
        \hideNotes 
\fatText 	a1_\markup {Sol \flat maior}   \bar "||"
	\unHideNotes
        \key ces \major
        \hideNotes 
\fatText 	a1_\markup {Dó \flat maior}  \bar "||"
	\unHideNotes
     }


lower = \relative c {
        \clef bass
        \key f \major
\override TextScript #'extra-offset = #'( 0.0 . -1.0 )
        \hideNotes 
\fatText 	a1_\markup {1 bemol}  \bar "||"
	\unHideNotes
        \key bes \major
        \hideNotes 
\fatText 	a1_\markup {2 bemóis}  \bar "||"
	\unHideNotes
        \key ees \major
        \hideNotes 
\fatText	a1_\markup {3 bemóis}  \bar "||"
	\unHideNotes
        \key aes \major
        \hideNotes 
\fatText	a1_\markup {4 bemóis} \bar "||"
	\unHideNotes
        \key des \major
        \hideNotes 
\fatText 	a1_\markup {5 bemóis} \bar "||"
	\unHideNotes
        \key ges \major
        \hideNotes 
\fatText 	a1_\markup {6 bemóis} \bar "||"
	\unHideNotes
        \key ces \major
        \hideNotes 
\fatText 	a1_\markup {7 bemóis} \bar "||"
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