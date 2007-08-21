% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 035600b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key g \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  g''2 a4 ais |
  % 2
  c d c2 |
  % 3
  ais4 a2 g4 |
  % 4
  d' dis f ais, |
  % 5
  c d c2 |
  % 6
  c4 ais2. |
  % 7
  g2 a4 ais |
  % 8
  c d c2 |
  % 9
  ais4 a2 g4 |
  % 10
  d' dis f ais, |
  % 11
  c d c2 |
  % 12
  c4 ais2. |
  % 13
  a2 g4 a |
  % 14
  ais c ais2 |
  % 15
  a4 g2 f4 |
  % 16
  ais2 a4 ais |
  % 17
  c d d2 |
  % 18
  c4 d2. |
  % 19
  a2 d4 g, |
  % 20
  a ais a2 |
  % 21
  a4 g2. |
  % 22
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  d'2 a'4. g8 |
  % 2
  f dis d4 g a4. g8 g4 fis d |
  % 4
  ais' a8 g f4 g |
  % 5
  f8 dis d4 g dis8 g |
  % 6
  f dis d2. |
  % 7
  d2 a'4. g8 |
  % 8
  f dis d4 g a4. g8 g4 fis d |
  % 10
  ais' a8 g f4 g |
  % 11
  f8 dis d4 g dis8 g |
  % 12
  f dis d2. |
  % 13
  f2 g4. f8 |
  % 14
  e d c4 f g4. f e4 c |
  % 16
  f g d4. g8 |
  % 17
  f dis d4 g8 fis g ais |
  % 18
  a g fis2. |
  % 19
  fis2 fis4 g |
  % 20
  d d dis c |
  % 21
  d8 c b2. |
  % 22
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  ais'2 d4 d |
  % 2
  c ais2 a4 |
  % 3
  ais8 d dis a d c ais4 |
  % 4
  f' dis d2 |
  % 5
  c4 ais2 a8 g |
  % 6
  a4 ais2. |
  % 7
  ais2 d4 d |
  % 8
  c ais2 a4 |
  % 9
  ais8 d dis a d c ais4 |
  % 10
  f' dis d2 |
  % 11
  c4 ais2 a8 g |
  % 12
  a4 ais2. |
  % 13
  c2 c4 c |
  % 14
  ais a2 g4 |
  % 15
  a8 c d g, c ais a4 |
  % 16
  d c2 ais8 dis |
  % 17
  d c ais4. a8 ais4 |
  % 18
  dis a2. |
  % 19
  d2 d4 d |
  % 20
  a g g2 |
  % 21
  fis4 d2. |
  % 22
  
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
  g4 g' fis g |
  % 2
  a ais e fis |
  % 3
  g c, d g, |
  % 4
  ais c d g, |
  % 5
  a ais dis c |
  % 6
  f ais,2. |
  % 7
  g4 g' fis g |
  % 8
  a ais e fis |
  % 9
  g c, d g, |
  % 10
  ais c d g, |
  % 11
  a ais dis c |
  % 12
  f ais,2. |
  % 13
  f4 f' e f |
  % 14
  g a d, e |
  % 15
  f ais, c f, |
  % 16
  d' e fis g |
  % 17
  a ais dis,2. d |
  % 19
  d8 d, d' c ais a ais a |
  % 20
  g fis g4 c a |
  % 21
  d g,2. |
  % 22
  
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
