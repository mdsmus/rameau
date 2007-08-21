% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 030100b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  d''4 a d d |
  % 2
  e c b2 |
  % 3
  a f4 a |
  % 4
  g f e4. d8 |
  % 5
  d1 |
  % 6
  d'4 a d d |
  % 7
  e c b2 |
  % 8
  a f4 a |
  % 9
  g f e4. d8 |
  % 10
  d1 |
  % 11
  f4 g a a |
  % 12
  ais a g2 |
  % 13
  f f4 g |
  % 14
  a a ais a |
  % 15
  g2 f |
  % 16
  a4 b c a |
  % 17
  d d cis2 |
  % 18
  d8 e f4 e d |
  % 19
  d cis d2 |
  % 20
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  f'4 a a gis8 a |
  % 2
  b e, e4 f e8 d |
  % 3
  cis2 d4 d8 cis |
  % 4
  d e4 d8 d4 cis |
  % 5
  a1 |
  % 6
  f'4 a a gis8 a |
  % 7
  b e, e4 f e8 d |
  % 8
  cis2 d4 d8 cis |
  % 9
  d e4 d8 d4 cis |
  % 10
  a1 |
  % 11
  d4 e f f |
  % 12
  f8 g4 f8 f4 e |
  % 13
  c2 d4. c4 f8 a4. g4 f e16 d e4 c2 |
  % 16
  f4 f g4. f8 |
  % 17
  f4 f8 e e2 |
  % 18
  f8 g a4 g f |
  % 19
  e e fis2 |
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
  a'4 f'8 e d c b8*5 a8 a4 gis |
  % 3
  e2 a4 a |
  % 4
  d,8 a' a4 ais a8. g16 |
  % 5
  f1 |
  % 6
  a4 f'8 e d c b8*5 a8 a4 gis |
  % 8
  e2 a4 a |
  % 9
  d,8 a' a4 ais a8. g16 |
  % 10
  f1 |
  % 11
  a4 c c c |
  % 12
  d8 c c4 d8 ais g c16 ais |
  % 13
  a2 a4 g |
  % 14
  f8 a d dis d4 c |
  % 15
  d c8 ais a2 |
  % 16
  c4 d c c |
  % 17
  d8 c b4 a2 |
  % 18
  a4 d8 c ais4 a |
  % 19
  ais a a2 |
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
  d4. c8 b4. a8 |
  % 2
  gis4 a d e |
  % 3
  a,2 d8 e f4 |
  % 4
  b,8 cis d4 g, a |
  % 5
  d1 |
  % 6
  d4. c8 b4. a8 |
  % 7
  gis4 a d e |
  % 8
  a,2 d8 e f4 |
  % 9
  b,8 cis d4 g, a |
  % 10
  d1 |
  % 11
  d4 c8 ais a g f e |
  % 12
  d e f4 ais c |
  % 13
  f,2 d'4 e |
  % 14
  f fis g a |
  % 15
  ais c f,2 |
  % 16
  f8 e d4 e8 c f4 |
  % 17
  ais8 a gis4 a2 |
  % 18
  f8 e d4. cis8 d f |
  % 19
  g e a4 d,2 |
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
