<<
  \new Staff <<
    \new Voice \relative c'' {
      \voiceOne
      c4 b c
    }
    \new Voice \relative c' {
      \voiceTwo
      e d e
    }
  >>
  \new Staff <<
    \clef bass
    \new Voice \relative c' {
      \voiceOne
      g g g
    }
    \new Voice \relative c {
      \voiceTwo
      c g c
    }
  >>
>>