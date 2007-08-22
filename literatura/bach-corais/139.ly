% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 139.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  g''4 g a g |
  % 2
  a8 b c4 c b |
  % 3
  c2 d4 e |
  % 4
  c2 b8 c d4 |
  % 5
  a2 d4 d |
  % 6
  c b8 a a2 |
  % 7
  g g4 g |
  % 8
  a g a8 b c4 |
  % 9
  c b c2 |
  % 10
  d4 e c2 |
  % 11
  b8 c d4 a2 |
  % 12
  d4 d c b8 a |
  % 13
  a2 g |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  d'4 e d d |
  % 2
  e f g2 |
  % 3
  g b8 a b4 |
  % 4
  a2 g4 g |
  % 5
  fis2 fis4 g |
  % 6
  g g g fis |
  % 7
  d2 e4 b8 cis |
  % 8
  d c b4 c8 d c d |
  % 9
  e4 d c2 |
  % 10
  fis4 gis e2 |
  % 11
  g4 fis8 g a2 |
  % 12
  g4 g8 fis g a d, e |
  % 13
  fis g4 fis8 d2 |
  % 14
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  b'4 c fis, g |
  % 2
  c c8 d e4 d |
  % 3
  e2 g8 f e4 |
  % 4
  e2 e4 d |
  % 5
  d2 a4 b |
  % 6
  c d e d8 c |
  % 7
  b2 c4 g |
  % 8
  fis g g8 f g a |
  % 9
  g4 e' e2 |
  % 10
  d8 c b4 a2 |
  % 11
  g8 a b g d'2 |
  % 12
  b8 c d4 e8 fis g4 |
  % 13
  d8 c16 b c4 b2 |
  % 14
  
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
  g'4 c,2 b4 |
  % 2
  a gis g2 |
  % 3
  c g'4 gis |
  % 4
  a2 e4 b8 c |
  % 5
  d2 d4 g8 fis |
  % 6
  e4 d c d |
  % 7
  g,2 c8 d e4 |
  % 8
  d8 e f4 e8 d e fis |
  % 9
  g4 gis a2 |
  % 10
  b4 e, a2 |
  % 11
  e4 d8 e fis2 |
  % 12
  g8 a b4. a8 b c |
  % 13
  d4 d, g2 |
  % 14
  
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
