\version "2.10.33"

\header {
  title = "141 - Seelenbräutigam, Jesu, Gottes Lamm"
  composer = "J. S. Bach"
}


global = {
  \time 4/4
  \key a \major
}


soprano = \relative c'' {
  a4 a4 gis4 a4 
  b2 a4 b4 
  cis4 b4 a2 
  cis4 d4 e4 d4 
  cis4 b4 cis2   %5
  b2 a4 b4 
  cis4 b4 a4 gis4 
  a4. gis8 gis2 
  a4 a4 gis4 a4 
  b2 a4 b4   %10
  cis4 b8 a8 a2 
  
}

alto = \relative c' {
  e4 e4 e4 e8 fis8 
  gis2 fis4 e4 
  e4 e4 e2 
  a4 a4 a4. b8~ 
  b8 a8 gis8 b4 a16 gis16 a4   %5
  gis2 fis4. e8 
  e8 a8 fis8 gis4 fis4 f8 
  fis8 f8 fis2 e4 
  fis4 e4 e4 e4 
  e2 cis8 fis8 e4~   %10
  e8 a8 gis4 e2 
  
}

tenor = \relative c' {
  cis4 cis4 b4 cis4 
  e2 cis8 d8 cis8 b8~ 
  b8 a4 gis8 cis2 
  e4 fis4 e4 fis8 e8 
  e4 e4 e2   %5
  e2 cis4 b4 
  a4. gis8 cis8 c16 cis16 dis8 cis8 
  cis1 
  cis4 cis4 b4 a4~ 
  a4 gis4 a8 d8 cis8 b8   %10
  a8 e'8 e8. d16 cis2 
  
}

baixo = \relative c {
  a8 b8 cis8 d8 e4 a,4 
  e'2 fis4 gis4 
  a4 e4 a,2 
  a'8 gis8 fis4 cis4 fis8 gis8 
  a4 e8 gis8 a4 a,4   %5
  e'2 fis4 gis4 
  a8 fis8 dis8 f8 fis8 dis8 c8 cis8 
  fis,8 gis8 a8 b8 cis2 
  fis4 cis8 d8 e4 cis8 a8 
  e'2 fis4 gis4   %10
  a4 e4 a,2 
  
}

