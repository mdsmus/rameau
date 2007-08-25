
\version "2.10.0"
\header { texidoc = "Each clef have own accidental placing rules. " }

#(set-global-staff-size 16)


\relative cis' {

				% \clef french % same as octaviated bass
  \clef violin
  \key cis \major cis1  \key ces \major ces
  \clef soprano
  \key cis \major cis \key ces \major ces \break
  \clef mezzosoprano
  \key cis \major cis \key ces \major ces
  \clef alto
  \key cis \major cis \break \key ces \major ces 
  \clef tenor
  \key cis \major cis \key ces \major ces \break
  \clef baritone
  \key cis \major cis \key ces \major ces
  \clef bass
  \key cis \major cis \key ces \major  ces
}



