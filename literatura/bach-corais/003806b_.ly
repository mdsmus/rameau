% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 003806b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  b''2 e,4 b' |
  % 2
  c b8 a g4 a |
  % 3
  b2 b |
  % 4
  c4 d c8 b a4 |
  % 5
  g f e2 |
  % 6
  b' e,4 b' |
  % 7
  c b8 a g4 a |
  % 8
  b2 b |
  % 9
  c4 d c8 b a4 |
  % 10
  g f e2 |
  % 11
  a g4 c |
  % 12
  b a d8 c b4 |
  % 13
  a2 c |
  % 14
  b4 c d g, |
  % 15
  b a g2 |
  % 16
  g c4 b |
  % 17
  a e g f |
  % 18
  e1 |
  % 19
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  e'2 e4 gis |
  % 2
  a g8 fis e4 fis |
  % 3
  gis2 gis |
  % 4
  a4 b c f, |
  % 5
  e d8 c b2 |
  % 6
  e e4 gis |
  % 7
  a g8 fis e4 fis |
  % 8
  gis2 gis |
  % 9
  a4 b c f, |
  % 10
  e d8 c b2 |
  % 11
  e d4 e8 fis |
  % 12
  g4 a b8 a gis4 |
  % 13
  e2 a |
  % 14
  g4 g g8 f e4 |
  % 15
  d c b2 |
  % 16
  e e4 e8 d |
  % 17
  c4 c d2. c4 b2 |
  % 19
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  gis'2 a4 d |
  % 2
  e d e8 d c4 |
  % 3
  b2 e |
  % 4
  e4 f g c, |
  % 5
  c8 b a4 gis2 |
  % 6
  gis a4 d |
  % 7
  e d e8 d c4 |
  % 8
  b2 e |
  % 9
  e4 f g c, |
  % 10
  c8 b a4 gis2 |
  % 11
  a b4 c |
  % 12
  d d8 e f4 b, |
  % 13
  c2 e |
  % 14
  e4 e d c |
  % 15
  fis,8 g4 fis8 g2 |
  % 16
  g a4 gis |
  % 17
  a g g a |
  % 18
  b a gis2 |
  % 19
  
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
  d2 c4 b |
  % 2
  a b c8 b a4 |
  % 3
  e'2 e |
  % 4
  a4 g8 f e4 f |
  % 5
  c d e2 |
  % 6
  d c4 b |
  % 7
  a b c8 b a4 |
  % 8
  e'2 e |
  % 9
  a4 g8 f e4 f |
  % 10
  c d e2 |
  % 11
  c' b4 a |
  % 12
  g f8 e d4 e |
  % 13
  a,2 a' |
  % 14
  e4 d8 c b4 c |
  % 15
  d d g,2 |
  % 16
  c a4 e' |
  % 17
  f c ais a |
  % 18
  gis a e2 |
  % 19
  
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
