% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 227.mid
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
  s2. g''4 |
  % 2
  d g g2 |
  % 3
  a s4 a |
  % 4
  ais8 c d4 cis2 |
  % 5
  d ais4 ais |
  % 6
  c c d2 |
  % 7
  ais s4 d |
  % 8
  c c c a |
  % 9
  d c ais a |
  % 10
  g2 a |
  % 11
  ais4 a g fis |
  % 12
  g2 a |
  % 13
  s4 d ais ais |
  % 14
  ais d c ais |
  % 15
  a g a2 |
  % 16
  g s4 g |
  % 17
  d g g2 |
  % 18
  a s4 a |
  % 19
  ais8 c d4 cis2 |
  % 20
  d1 |
  % 21
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. d'8 c |
  % 2
  ais c d4. c16 ais a8 g |
  % 3
  d'2 s4 fis |
  % 4
  g a a2 |
  % 5
  a g8 a ais4 |
  % 6
  ais a ais4. gis8 |
  % 7
  g2 s4 ais |
  % 8
  a8 g f e f g a g |
  % 9
  a fis g a4 g fis8 |
  % 10
  g8. fis16 g8 g, d'2 |
  % 11
  d8 e f fis g dis d4. c8 d ais d2 |
  % 13
  s4 fis d g |
  % 14
  f4. g16 f e8 fis g4. fis8 g4 g fis |
  % 16
  d2 s4 d |
  % 17
  d d4. c16 ais a8 g |
  % 18
  d'2 s4 fis |
  % 19
  g a8 e e fis g4 |
  % 20
  fis1 |
  % 21
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. ais'8 a |
  % 2
  g a ais4. a16 g c4 |
  % 3
  fis,2 s4 d' |
  % 4
  d8 e f4 e8 d e16 fis g8 |
  % 5
  fis2 d4 f |
  % 6
  g f f f |
  % 7
  f2 s4 f |
  % 8
  f8 ais, a g a ais c4. ais4 a8 ais16 c d8 d8. c16 |
  % 10
  ais8 d4 c8 fis,2 |
  % 11
  g4 c d8 c16 ais a4 |
  % 12
  g8 d g2 fis4 |
  % 13
  s4 a g8 a ais c |
  % 14
  d dis d ais g a ais16 c d8 |
  % 15
  dis d16 c ais8 c16 d dis4 d8. c16 |
  % 16
  ais2 s4 ais8 a |
  % 17
  g a ais a g4. c8 |
  % 18
  fis,2 s4 d' |
  % 19
  d a8 ais a2 |
  % 20
  a1 |
  % 21
  
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
  s2. g8 a |
  % 2
  ais a g4 dis'2 |
  % 3
  d s4 d |
  % 4
  g f8 g a2 |
  % 5
  d, g8 f dis d |
  % 6
  dis c f f, ais c d ais |
  % 7
  dis2 s4 ais |
  % 8
  f'8 g a ais a g f e |
  % 9
  fis d e fis g4 d |
  % 10
  dis2 d |
  % 11
  g,4 a ais8 c d c |
  % 12
  ais a ais g d'2 |
  % 13
  s4 d g8 f dis4 |
  % 14
  d8 c ais4. a8 g ais |
  % 15
  c d dis d c a d4 |
  % 16
  g,2 s4 g8 a |
  % 17
  ais a g f dis2 |
  % 18
  d s4 d' |
  % 19
  g f8 g a4 a, |
  % 20
  d1 |
  % 21
  
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
