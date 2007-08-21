% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 022707b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key e \minor
  
  \tempo 4 = 76 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  b''4 b a g |
  % 2
  fis2 e |
  % 3
  b'4 cis d b |
  % 4
  e2 dis |
  % 5
  e8 fis g4 fis4. fis8 |
  % 6
  e1 |
  % 7
  b4 b a g |
  % 8
  fis2 e |
  % 9
  b'4 cis d b |
  % 10
  e2 dis |
  % 11
  e8 fis g4 fis4. fis8 |
  % 12
  e1 |
  % 13
  b4 b c b |
  % 14
  a a g2 |
  % 15
  b4 cis d b |
  % 16
  e d cis2 |
  % 17
  b b4 b |
  % 18
  a g fis2 |
  % 19
  e1 |
  % 20
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s8 g'' b g g fis4 e8 |
  % 2
  e dis16 cis dis4 e8 dis e fis |
  % 3
  g16 fis g8 s8 e a4. g16 fis |
  % 4
  g8 a16 b a4 b s8 c |
  % 5
  b a g b c a fis4 |
  % 6
  b8 gis e a gis2 |
  % 7
  s8 g b g g fis4 e8 |
  % 8
  e dis16 cis dis4 e8 dis e fis |
  % 9
  g16 fis g8 s8 e a4. g16 fis |
  % 10
  g8 a16 b a4 b s8 c |
  % 11
  b a g b c a fis4 |
  % 12
  b8 gis e a gis2 |
  % 13
  g8 a a g g a a g |
  % 14
  g4 fis g8 d e fis |
  % 15
  g d g4 s8 a4 g16 fis |
  % 16
  e8 g fis b b4 ais |
  % 17
  b8 fis b a g8*5 fis4 e8 e d16 cis d4 |
  % 19
  d8 e16 d c b c8 b2 |
  % 20
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s8 b' e b e dis e g, |
  % 2
  c b16 a b8 a g a g fis |
  % 3
  e e s4. fis8 d' a |
  % 4
  b a16 g e' dis e8 fis4 s4. dis8 e4. e8 d2 c16 b c8 b2 |
  % 7
  s8 b e b e dis e g, |
  % 8
  c b16 a b8 a g a g fis |
  % 9
  e e s4. fis8 d' a |
  % 10
  b a16 g e' dis e8 fis4 s4. dis8 e4. e8 d2 c16 b c8 b2 |
  % 13
  e8 fis fis e e d d e |
  % 14
  e4 d8 c c b c a |
  % 15
  g b e a,4 g16 fis d'4. cis8 d e16 fis g8 cis, fis e |
  % 17
  dis4 s8 b e e16 dis e4. dis8 e g, c a fis b |
  % 19
  b gis e a4 gis8 gis4 |
  % 20
  
}

trackD = <<

  \clef bass
  
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s8 e g e c' s4 b8 |
  % 2
  a fis b b, e4 s4. e8 a g fis d g4. fis16 e c'4 b8 c b a |
  % 5
  g fis e g a fis b a |
  % 6
  gis e a a, e'2 |
  % 7
  s8 e g e c' s4 b8 |
  % 8
  a fis b b, e4 s4. e8 a g fis d g4. fis16 e c'4 b8 c b a |
  % 11
  g fis e g a fis b a |
  % 12
  gis e a a, e'2 |
  % 13
  e8 dis dis e e fis g e |
  % 14
  c cis d4 g,2 |
  % 15
  s8 g'4 fis16 e fis8 d g fis |
  % 16
  gis ais b g e f fis4 |
  % 17
  b,2 s8 e g e |
  % 18
  c' s4 b8 a fis b a |
  % 19
  gis e a a, e'2 |
  % 20
  
}

trackE = <<

  \clef bass
  
  \context Voice = channelA \trackEchannelA
  \context Voice = channelB \trackEchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
  >>
}
