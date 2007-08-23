% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 272.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key bes \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. ais''4 |
  % 2
  ais ais ais c |
  % 3
  gis g f c' |
  % 4
  d c ais a8 g |
  % 5
  a4 g f ais |
  % 6
  ais ais ais c |
  % 7
  gis g f c' |
  % 8
  d c ais a8 g |
  % 9
  a4 g f f' |
  % 10
  dis d c ais |
  % 11
  ais8 c d4 c d |
  % 12
  dis d c b |
  % 13
  c2. f,4 |
  % 14
  ais c d dis |
  % 15
  f dis8 d c4 dis |
  % 16
  d c f ais,8 c |
  % 17
  d4 c ais2 |
  % 18
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. f'4 |
  % 2
  g gis g g |
  % 3
  g8 f4 e8 f4 f |
  % 4
  f e f c4. f4 e8 c4 f |
  % 6
  g f g g |
  % 7
  g8 f4 e8 f4 f |
  % 8
  f e f c4. f4 e8 c4 ais'8 a |
  % 10
  g4 f8 g a4 ais8 gis |
  % 11
  g4 f f f |
  % 12
  dis gis8 g4 f8 g4 |
  % 13
  g2. c,4 |
  % 14
  f g8 a ais4 a8 g |
  % 15
  f4 g a ais |
  % 16
  gis g f f8 g |
  % 17
  f dis4 d8 d2 |
  % 18
  
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
  d8 dis f4 dis8 d c4 |
  % 3
  c ais a c |
  % 4
  ais8 a g4 f c' |
  % 5
  c ais a ais |
  % 6
  ais8 c d4 dis8 d c4 |
  % 7
  c ais a c |
  % 8
  ais8 a g4 f c' |
  % 9
  c ais a d8 c |
  % 10
  ais c d dis f4 f |
  % 11
  ais,2 a4 b |
  % 12
  c4. b8 c4 d |
  % 13
  dis2. a4 |
  % 14
  ais dis, f8 f' dis4. d8 c ais f'4 ais, |
  % 16
  ais4. c8 a4 ais |
  % 17
  ais a f2 |
  % 18
  
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
  s2. ais'8 a |
  % 2
  g4 d dis e |
  % 3
  f c f, a |
  % 4
  ais c d e |
  % 5
  f c f, d' |
  % 6
  dis ais dis e |
  % 7
  f c f, a |
  % 8
  ais c d e |
  % 9
  f c f, d' |
  % 10
  g ais dis, d |
  % 11
  dis ais f' d |
  % 12
  c f8 g gis4 g |
  % 13
  c,2. dis4 |
  % 14
  d c ais c |
  % 15
  d dis f g |
  % 16
  f dis2 d8 dis |
  % 17
  f4 f, ais2 |
  % 18
  
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
