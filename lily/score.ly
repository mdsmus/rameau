\score {
  <<
    \new Staff {
      <<
        \global
        \new Voice = "soprano" { \voiceOne \soprano }
        \new Voice = "alto" { \voiceTwo \alto }
      >>
    }
    \new Staff {
      <<
        \global
        \clef "bass"
        \new Voice = "tenor" {\voiceOne \tenor }
        \new Voice = "baixo" { \voiceTwo \baixo \bar "|."}
      >>
    }
  >>

  \layout {}
  \midi {}
}