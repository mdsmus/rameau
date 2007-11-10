\version "2.10.33"

\header {
  title = "360 - Wir Christenleut"
  composer = "J. S. Bach"
}


global = {
  \time 4/4
  \key fis \minor
}


soprano = \relative c' {
  \partial 4 fis8  gis8 
    a4 gis4 fis4 fis8 gis8 
  a4 gis4 fis4 cis'4 
  b4 a4 gis4 gis4 
  a4 a4 b4 b4 
  cis4 cis4 b4 a4   %5
  gis2 fis4 cis'4 
  b4 a8 gis8 gis4 cis4 
  b4 a4 gis4 gis4 
  a4 a4 b4 b4 
  cis4 cis4 b4 a8 gis8   %10
  gis2 fis2 
  
}

alto = \relative c' {
  \partial 4 cis4 
    fis4 f4 fis4 fis4 
  fis4 f4 cis4 fis4 
  fis8 f8 fis4 f4 f4 
  fis4 fis4 fis8 gis16 a16 gis4 
  gis8 fis8 f8 fis8 gis4. fis8   %5
  fis4 f4 cis4 fis4 
  fis8 f8 fis4 f4 fis8 e8 
  dis8 e8 fis8 dis8 e4 gis8 f8 
  fis4 a8 fis8 d4 b'8 gis8 
  a8 g8 fis4. f8 fis4~   %10
  fis8 f16 dis16 f4 cis2 
  
}

tenor = \relative c' {
  \partial 4 a8  b8 
    cis4 cis8 b8 a4 b4 
  cis4 cis8 b8 a4 a4 
  b4 cis4 cis4 cis4 
  cis4 d4 d8 e16 fis16 e8 d8 
  cis4 b8 a8 d8 cis8 cis8 d8   %5
  d8 b8 gis8 cis8 a4 a4 
  b8 cis8 dis4 cis4 cis4 
  fis,4 b4 b4 cis4 
  cis8 a8 d4 d8 b8 e4 
  e8 cis8 fis8 e8 d8 cis8 dis4   %10
  cis8 gis8 cis8 b8 a2 
  
}

baixo = \relative c {
  \partial 4 fis4 
    fis16 gis16 a16 b16 cis8 cis,8 d4 d4 
  cis8 b8 cis4 fis,4 fis'4 
  gis4 a8 b8 cis4 cis,4 
  fis8 e8 d8 cis8 d8 b8 e4 
  a,8 a'8 gis8 fis4 f8 fis8 d8   %5
  b8 gis8 cis4 fis,4 fis'8 e8 
  d8 cis8 c4 cis4 a4 
  b8 cis8 dis8 b8 e4 f8 cis8 
  fis4 fis8 d8 g4 gis8 e8 
  a4 ais8 fis8 b4 c8 gis8   %10
  cis4 cis,4 fis2 
  
}

