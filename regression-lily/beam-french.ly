\version "2.10.0"

\header {
    texidoc = "In french style beaming, the stems do not go between beams."
}

\layout { ragged-right= ##t }

\relative c'
{
    \override Stem  #'french-beaming = ##t
    c16[ c c c]
    c8[ c16 e16 f16 g16 g8]
}


