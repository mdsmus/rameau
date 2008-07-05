

\header {

  texidoc= "Rehearsal marks in letter style: the I is skipped, and
after Z, double letters are used.  The mark may be set with
@code{\mark NUMBER}, or with @code{Score.rehearsalMark}."

}

\version "2.10.0"
\paper { ragged-right = ##t } 

\relative c'' {
  c1  \mark \default
  c1  \mark #7
  c1  \mark \default
  c1  \mark \default
  c1  \mark \default
  \set Score.rehearsalMark = #24
  c1  \mark \default
  c1  \mark \default
  c1  \mark \default
  c1  \mark \default
}
