\version "2.10.0"

\header {
  texidoc = "
  Instrument names (aligned on axis group spanners) ignore dynamic and
  pedal line spanners."
}

\paper {
  line-width = 3\cm
  indent = 0\cm
}

\relative {
  \set Staff.shortInstrumentName = "foo"
  f1 | f1 | f1 |
  f1\< | f1 | f1\! |
}

% EOF
