\header {

  texidoc = "Pedals.  Run @code{timidity -idvvv file.midi |grep Midi}
  to see midi events."

}

\version  "2.11.10"

\score {
  \relative {
    {
      { c16 e g c }
      
      { c,16\sustainDown e g c\sustainUp }
      { c,16\unaCorda e g c\treCorde }
      { c,16\sostenutoDown e g c\sostenutoUp }
    }
  }
  \midi {}
  \layout{}
}
