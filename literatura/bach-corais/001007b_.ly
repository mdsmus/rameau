% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 001007b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \minor
  
  \tempo 4 = 94 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  d''2 f |
  % 2
  d4 d d d |
  % 3
  dis2 d |
  % 4
  c c |
  % 5
  ais1 |
  % 6
  d2 f |
  % 7
  c4 c c g |
  % 8
  ais2 a |
  % 9
  g1 |
  % 10
  d'2 f |
  % 11
  d4 d d d |
  % 12
  dis2 d |
  % 13
  c c |
  % 14
  ais1 |
  % 15
  d2 f |
  % 16
  c4 c c c |
  % 17
  c2 g4 a |
  % 18
  ais2 a |
  % 19
  g1*3 g1 |
  % 23
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  g''2 f |
  % 2
  f4 fis g a |
  % 3
  g f2 g4 |
  % 4
  g2 f |
  % 5
  f1 |
  % 6
  f |
  % 7
  f4 f dis g |
  % 8
  g2 fis |
  % 9
  d1 |
  % 10
  g2 a |
  % 11
  f2. fis4 |
  % 12
  g a ais2. ais4 ais a |
  % 14
  f1 |
  % 15
  s1 |
  % 16
  f4 g a ais |
  % 17
  c2 c, |
  % 18
  d d4 c |
  % 19
  b d g f |
  % 20
  dis1. d4 c |
  % 22
  d1 |
  % 23
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  ais'2 c |
  % 2
  d4 c ais a |
  % 3
  ais c2 ais4 |
  % 4
  ais2 a |
  % 5
  d1 |
  % 6
  ais |
  % 7
  a4 c g c |
  % 8
  d2. c4 |
  % 9
  ais1 |
  % 10
  ais2 c |
  % 11
  d4 c ais a |
  % 12
  ais c f, f' |
  % 13
  g2 f4 c |
  % 14
  d1 |
  % 15
  s2 f,4 g |
  % 16
  a ais c2. d4 e fis |
  % 18
  g2 f4 dis |
  % 19
  d b c d2 g,4 c1 b4 a |
  % 22
  b1 |
  % 23
  
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
  g'2 a |
  % 2
  ais4 a g fis |
  % 3
  g a ais g |
  % 4
  dis c f2 |
  % 5
  ais,1 |
  % 6
  ais'2 ais, |
  % 7
  f'4 a c dis, |
  % 8
  d c d2 |
  % 9
  g,1 |
  % 10
  g'2 f |
  % 11
  ais4 c d2. c4 ais d, |
  % 13
  dis c f2 |
  % 14
  ais,1 |
  % 15
  ais4 c d dis |
  % 16
  f2. g4 |
  % 17
  a ais c2 |
  % 18
  ais,4 c d dis |
  % 19
  f2 dis4 d |
  % 20
  c d dis f |
  % 21
  g1 |
  % 22
  g, |
  % 23
  
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
