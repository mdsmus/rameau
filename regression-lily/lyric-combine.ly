
\version "2.10.0"

\header{

    texidoc= "Lyrics can be set to a melody automatically.  Excess
lyrics will be discarded.  Lyrics will not be set over rests.  You can
have melismata either by setting a property melismaBusy, or by setting
automaticMelismas (which will set melismas during slurs and ties).  If
you want a different order than first Music, then Lyrics, you must
precook a chord of staves/lyrics and label those.  Of course, the
lyrics ignores any other rhythms in the piece."

}

\layout { ragged-right= ##t }



m = \relative c'' {
    \autoBeamOff
    g8( a)  r8 \times 2/3 { g'8( f e) } r8 \grace {  d16[ c b] } e4
    \emptyText
    d8.^"melisma" 	\melisma c16
    \melismaEnd
    b
}

noise = \repeat unfold 6  \relative c'' { g16 g g g }

textI = \lyricmode {
    la2 __ la -- la __ la la la la la
}

textII = \lyricmode {
    da -- da __ da -- da da da da da
}


<< \context Staff = SA \noise
   \context Lyrics = LA { s1 }
   \context Staff = SB { s1 }
   \context Lyrics = LB { s1 }
   \context Staff = SC \noise
   
   \context Staff = SB  \context Voice = "middle" \m 
   \context Lyrics = LA \lyricsto "middle" \textI
   \context Lyrics = LB \lyricsto "middle" \textII 
>>


