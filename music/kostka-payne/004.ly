\version "2.10.0"
\header {
  title = "Sonata Op 2, III, Trio"
  composer = "Beethoven"
}
\score {
  \context PianoStaff <<
    \new Staff =  "up" {
      \clef treble
      \time 3/4
      <<
        \relative c'' {
          \mark \markup {\tiny{"13"}}
          f4( e d
          c! b a
          \override TextScript #'extra-offset = #'( 0.0 . 1.0 )
          gis^\markup{ 6 }
          \override TextScript #'extra-offset = #'( 0.0 . 1.0 )
          f^\markup{ 7 }
          e
          d c b)
          <c c'>\fp( b' a)
          <<
            { f'4\sf( e d) }
            \\
            { gis,2. }
          >>
        }
      >>
    }
    \new Staff =  "down" {
      \clef treble
      d'8 a' c'! a' b gis'
      \clef bass
      a a' g! g'! f f'
      e e' d d' c c'
      b, b a, a gis, gis
      <a, a> e' b e' c' e'
      <<
        { d'8 e' c' e' b e' }
        \\
        { e2.\sf }
      >>
    }
  >>
  \layout {
    ragged-right = ##t 
    \context {
      \Staff
      \consists Horizontal_bracket_engraver
    }
  }
}
