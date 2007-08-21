% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 022602b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key bes \major
  
  \tempo 4 = 92 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. f''4 |
  % 2
  g f8 dis d dis f4 |
  % 3
  c2 d4 e |
  % 4
  f2 s4 f |
  % 5
  g f c8 d dis4 |
  % 6
  d c ais ais |
  % 7
  c8 d dis4 d8 dis f2 c4 ais8 a g4 |
  % 9
  f2 s4 f |
  % 10
  ais c d8 dis f2 dis4 d c |
  % 12
  d2 s4 d8 dis |
  % 13
  f4 g f c |
  % 14
  d e f f |
  % 15
  g f c8 d dis4 |
  % 16
  d c ais ais |
  % 17
  c8 d dis4 d8 dis f2 c4 ais8 a g4 |
  % 19
  f2 s4 f |
  % 20
  ais c d8 dis f2 dis4 d c |
  % 22
  g a ais c |
  % 23
  d ais g2 |
  % 24
  f4 c'8 d16 dis d2 |
  % 25
  c ais |
  % 26
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. ais''4 |
  % 2
  ais a ais f8 g |
  % 3
  a2 ais4 ais |
  % 4
  a2 s4 ais |
  % 5
  ais a8 g f4 g8 a |
  % 6
  ais4 a f f |
  % 7
  f g f8 g a4. ais8 a g f d e4 |
  % 9
  c2 s4 c |
  % 10
  f8 g a4 ais4. c8 |
  % 11
  d4. c8 ais a g4 |
  % 12
  fis2 s4 ais |
  % 13
  a8 b c4 c8 ais a g |
  % 14
  f4 g a ais8 a |
  % 15
  g a ais4 a g |
  % 16
  f8 g a4 f g |
  % 17
  g g8 a ais2. a4 ais8 f4 e8 |
  % 19
  c2 s4 f8 dis |
  % 20
  d g f dis d4. dis16 f |
  % 21
  g4 g g g8 f |
  % 22
  dis2 d4 f |
  % 23
  f8*5 d8 dis4 |
  % 24
  d f2 g f8 dis d2 |
  % 26
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. d'4 |
  % 2
  dis8 d c4 ais ais |
  % 3
  f'2 f4 ais, |
  % 4
  c2 s4 ais |
  % 5
  dis8 d c ais a ais dis,4 |
  % 6
  f f'8 dis d4 d |
  % 7
  c ais8 c d4 c8 ais |
  % 8
  c4 f f c8 ais |
  % 9
  a2 s4 a |
  % 10
  ais dis f8 dis d c |
  % 11
  b a g4 fis g |
  % 12
  a2 s4 ais8 c |
  % 13
  d4 e f4. dis8 |
  % 14
  d c ais4 c d |
  % 15
  dis f f ais,8 c |
  % 16
  d ais f' dis d4 dis |
  % 17
  dis8 d c4 d8 c ais c |
  % 18
  d e f2 c8 ais |
  % 19
  a2 s4 a |
  % 20
  ais8 dis d c ais4. c8 |
  % 21
  d4. c8 ais a g4 |
  % 22
  c2 ais4 a |
  % 23
  ais2. ais8 a |
  % 24
  ais4 c2 ais a16 g a8 f2 |
  % 26
  
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
  s2. ais'4 |
  % 2
  dis, f g d8 dis |
  % 3
  f2 ais8 a g4 |
  % 4
  f2 s4 d |
  % 5
  dis f dis8 d c4 |
  % 6
  d8 dis f4 ais, ais' |
  % 7
  a g8 a ais4 a8 g |
  % 8
  a g f e d ais c4 |
  % 9
  f2 s4 f8 dis |
  % 10
  d dis d c ais4 ais'8 gis |
  % 11
  g4 c, d dis |
  % 12
  d2 s4 g |
  % 13
  d' c8 ais a g f4 |
  % 14
  ais8 a g4 f ais |
  % 15
  dis, d8 dis f4 g8 a |
  % 16
  ais dis, f4 ais, dis8 d |
  % 17
  c4 c' g d8 dis |
  % 18
  f g a f d' ais c4 |
  % 19
  f,2 s4 d |
  % 20
  g a ais8 c d c |
  % 21
  b g c4 g8 f dis d |
  % 22
  dis c f4 ais, f' |
  % 23
  ais,8 c d4 dis2 |
  % 24
  ais'4 a ais8 a g f |
  % 25
  dis c f4 ais,2 |
  % 26
  
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
