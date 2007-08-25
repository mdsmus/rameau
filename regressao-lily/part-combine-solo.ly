
\header { texidoc =

	  "A solo string can only be printed when a note
    starts. Hence, in this example, there is no Solo-2 although the
    2nd voice has a dotted quarter, while the first voice has a rest.

A Solo indication is only printed once; (shared) rests do not require
reprinting a solo indication.

Solo 1/2 can not be used when a spanner is active, so there is no solo
 over any of the tied notes.

"
    }

vone =  \relative a' { d4 r8 d8 d8 r8 d8 r8 d2 ~ d2 ~ d4 }
vtwo =  \relative g' { g4.   g8 r2          g4 r4 r2  g4 } 

\version "2.10.0"

\paper { ragged-right = ##t } 

    
<< \set Score.skipBars = ##t
   \partcombine \vone \vtwo
>>
 
