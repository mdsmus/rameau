\version "2.12.0"
\header {
  title = "Symphony 9"
  composer = "Dvorák"
}
vla = \relative c' { \time 4/8  \clef alto  \key g \major
                     g4( fis8 f)
                     e4( ees8 d)
                     cis8( c)
                     << \relative c' { g16 r fis r g r} \\ \relative c {e16 s e s e s} >>
                   }

vcl = \relative c' { \clef bass \time 4/8   \key g \major
                     \clef tenor e8( ~ e32 d16 e32 b4)
                     c8( ~ c32 b16 c32 g4)
                     a8( ~ a32 g16 a32) b16 r c r
                     b r
                     
                   }


bass = \relative c' { \time 4/8 \clef bass \key g \major
                      e4( d)
                      c( b)
                      a e16 r a r
                      e r
                    }

\new ChoirStaff { <<
  \new Staff { \vla }
  \new Staff { \vcl }
  \new Staff { \bass }
>> }