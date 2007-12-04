\version "2.10.33"

\header {
  title = "1 - Aus meines Herzens Grunde"
  composer = "J. S. Bach"
}


global = {
  \time 3/4
  \key g \major
}


soprano = \relative c'' {
  g2 
}

alto = \relative c' {
  d2 
}

tenor = \relative c' {
  b2 
}

baixo = \relative c {
  g,2 
}


texto = { c2 }

gabarito = \lyricmode {
  \set stanza = "gabarito:"
  "G" 
}

pardo = \lyricmode {
  \set stanza = "pardo:"
  G 
}

particoes = \lyricmode {
  \set stanza = "particoes:"
  "80" 
}

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
        \new Devnull= "nowhere" \texto
        \new Voice = "tenor" {\voiceOne \tenor }
        \new Voice = "baixo" { \voiceTwo \baixo \bar "|."}
      >>
    }
    \new Lyrics \lyricsto "soprano" \particoes
    \new Lyrics \lyricsto "soprano" \pardo
    \new Lyrics \lyricsto "soprano" \gabarito

  >>

  \layout {
    \context {
      \Lyrics
      \override LyricSpace #'minimum-distance = #1.0
      \override LyricText #'font-size = #-1
                                %\override LyricText #'font-name = #"Bitstream Vera Serif"
    }
  }
  \midi {}
}

