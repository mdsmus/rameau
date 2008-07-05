\header
{

    texidoc = "With @code{\\quote}, fragments of previously entered
music may be quoted. @code{quotedEventTypes} will determines what
things are quoted. In this example, a 16th rests is not quoted, since
@code{rest-event} is not in @code{quotedEventTypes}."

}
\version "2.11.10"
\layout {
    ragged-right = ##t
}


quoteMe = \relative c' { fis4 r16  a8.-> b4-\ff c }

\addQuote quoteMe \quoteMe 
original = \relative c'' { c8 d s2 es8 gis8 }

<<
    \new Staff {
	\set Staff.instrumentName = "quoteMe"
	\quoteMe
    }
    \new Staff {
	\set Staff.instrumentName = "orig"
	\original
    }
    \new Staff \relative c'' <<
	\set Staff.instrumentName = "orig+quote"	
	\set Staff.quotedEventTypes = #'(note-event articulation-event)
	\original
	\new Voice {
	    s4
	    \set fontSize = #-4
	    \override Stem #'length-fraction = #(magstep -4)
	    \quoteDuring #"quoteMe" { \skip 2. }
	}
    >>
>>
