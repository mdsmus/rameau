\version "2.10.0"
\header { texidoc = "
A voicelet (a very short voice to get polyphonic chords correct)
should not confuse the spacing engine."
}

\layout { ragged-right = ##t }


{  \context Staff \relative c' {
  c4
  <<
    { r4 dis'4 } \\
    { r4 fis,4 } \\
    { r bis } \\
    { s gis }
  >>
  c4
}}




