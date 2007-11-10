\version "2.10.33"

\header {
  title = "80 - Herzlich tut mich verlangen"
  composer = "J. S. Bach"
}


global = {
  \time 4/4
  \key d \major
}


soprano = \relative c' {
  \repeat volta 2 {
    \partial 4 fis4 
    b4 a4 g4 fis4 
    e2 fis4 cis'4 
    d4 d4 cis8 b8 cis4 
    b2. } d4 
  cis8 b8 a4 b4 cis4   %5
  d2 d4 a4 
  b4 a4 g4 g4 
  fis2. d'4 
  cis8 d8 e4 d4 cis4 
  b2 cis4 fis,4   %10
  g4 fis4 e4 a4 
  fis1 
  
}

alto = \relative c' {
  \repeat volta 2 {
    \partial 4 d4 
    d4 d4 d8 e8 e8 d8 
    d4 cis4 d4 e4 
    d8 e8 fis4 fis4. e8 
    d2. } fis4 
  e8 g8 fis8 e8 d4 g4   %5
  g4 fis8 e8 fis4 fis4 
  g4 fis4 fis4 e4 
  dis2. e4 
  e4 e4 fis8 gis8 a4 
  a4 gis4 a4 d,8 cis8   %10
  b8 cis8 d4 d8 b8 cis4 
  d1 
  
}

tenor = \relative c' {
  \repeat volta 2 {
    \partial 4 a4 
    g4 a4 b8 a8 a4 
    b4 a4 a4 ais4 
    b4 b4 b4 ais4 
    b2. } b8 a8 
  g8 b8 d8 cis8 b8 a8 g8 a8   %5
  b4 a8 g8 a4 d4 
  d4 c4 b4 b4 
  b2. b4 
  a4 b4 a8 b8 cis8 a8 
  fis'4 e4 e4 a,4   %10
  g4 a4 a4 a4 
  a1 
  
}

baixo = \relative c {
  \repeat volta 2 {
    \partial 4 d4 
    g4 fis4 b,8 cis8 d4 
    g,4 a4 d4 cis4 
    b8 cis8 d8 e8 fis4 fis,4 
    b2. } b4 
  e4 fis4 g8 fis8 e4   %5
  d2 d4 d4 
  g8 fis8 e8 dis8 e8 fis8 g8 a8 
  b2. gis4 
  a4 gis4 fis4 e4 
  dis4 e4 a,4 d4   %10
  e4 fis8 g8 a4 a,4 
  d1 
  
}

