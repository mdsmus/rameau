% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 012.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key c \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2 a''4 a2 a4 b2 |
  % 3
  b4 c b a |
  % 4
  g2. c2 d4 c2 |
  % 6
  b4 c2 c4 |
  % 7
  c2 c4 b2 a4 a b |
  % 9
  gis a2 a4 |
  % 10
  g2 a4 b2 b4 c2 |
  % 12
  b4 a2 gis4 |
  % 13
  a2 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2 e'4 e2 a4 g2 |
  % 3
  g4 g2 f4 |
  % 4
  e2. g2 gis4 a2 |
  % 6
  g4 g2 g4 |
  % 7
  a2 fis4 g2 g4 g fis |
  % 9
  e e2 d4 |
  % 10
  d e d d2 f4 e f |
  % 12
  g2 fis4 e |
  % 13
  e2 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2 c'4 c2 d4 d2 |
  % 3
  d4 c e c |
  % 4
  c2. e2 e4 e d2 e e4 |
  % 7
  e d d d |
  % 8
  e e d b |
  % 9
  b c2 a4 |
  % 10
  b c a g |
  % 11
  b d c d2 c b4 |
  % 13
  cis2 
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s2 a4 a' |
  % 2
  g fis g d |
  % 3
  f e c f |
  % 4
  c2. c4 |
  % 5
  c' b a fis |
  % 6
  g c,2 c'4 |
  % 7
  a fis d g |
  % 8
  e cis d dis |
  % 9
  e a,2 f'4 |
  % 10
  f e fis g |
  % 11
  fis gis a d, |
  % 12
  e f dis e |
  % 13
  a,2 
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
