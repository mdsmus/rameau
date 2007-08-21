% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 036200b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key bes \major
  
  \tempo 4 = 96 
  \skip 1*24 
  \time 3/4 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d''4 |
  % 2
  d ais c d |
  % 3
  dis d8 c c4 c |
  % 4
  c ais ais8 g a4 |
  % 5
  ais2. c4 |
  % 6
  c c c8 d16 dis d8 c |
  % 7
  ais2 ais4 ais |
  % 8
  a8 f ais dis d c c4 |
  % 9
  ais2. d4 |
  % 10
  d ais c d |
  % 11
  dis d8 c c4 c |
  % 12
  c ais ais8 g a4 |
  % 13
  ais2. c4 |
  % 14
  c c c8 d16 dis d8 c |
  % 15
  ais2 ais4 ais |
  % 16
  a8 f ais dis d c c4 |
  % 17
  ais2. a4 |
  % 18
  a a a a |
  % 19
  ais2 ais4 ais |
  % 20
  a a a a |
  % 21
  ais2 ais4 d |
  % 22
  d8 c ais4 c d |
  % 23
  dis2 d4 d |
  % 24
  c8 b c f dis d d4 |
  % 25
  c2 b4 c2 c4 d2 |
  % 27
  d4 dis2. |
  % 28
  d2 d4 c2 c4 c dis8 d |
  % 30
  c b c2 b4 |
  % 31
  c2 c4 d2 d4 dis2. d2 d4 |
  % 34
  c2 ais4 ais |
  % 35
  d8 c ais a ais2. 
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
  g8 fis g4 g8 a ais4 |
  % 3
  ais8 a ais4 a g |
  % 4
  fis d g f |
  % 5
  f2. f8 e |
  % 6
  f g a g a4. fis8 |
  % 7
  d dis f4 dis g |
  % 8
  f8 dis d dis f g f dis |
  % 9
  d2. f4 |
  % 10
  g8 fis g4 g8 a ais4 |
  % 11
  ais8 a ais4 a g |
  % 12
  fis d g f |
  % 13
  f2. f8 e |
  % 14
  f g a g a4. fis8 |
  % 15
  d dis f4 dis g |
  % 16
  f8 dis d dis f g f dis |
  % 17
  d2. c4 |
  % 18
  f f fis8 g a fis |
  % 19
  g dis f4 dis g |
  % 20
  f dis8 d c4 f |
  % 21
  f dis d f8 g |
  % 22
  a4 d, g8 f f4 |
  % 23
  dis8 d c f f4 f |
  % 24
  f8 d dis f g gis g f |
  % 25
  dis2 f4 g2 f8 dis d4 d'8 c |
  % 27
  ais gis g f dis g c ais |
  % 28
  a4 d, g g |
  % 29
  f dis8 f g4 gis |
  % 30
  g g2 g4 |
  % 31
  g f8*5 g8 |
  % 32
  gis4 g g2 |
  % 33
  f4 f2 g4 |
  % 34
  g2 g4 f |
  % 35
  g f f2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. ais'4 |
  % 2
  ais8 c d4 c f |
  % 3
  dis8 c f4 f c |
  % 4
  d8 a ais4 c c |
  % 5
  d2. a8 ais |
  % 6
  c d dis4 d a |
  % 7
  ais gis g c |
  % 8
  c ais ais a |
  % 9
  f2. ais4 |
  % 10
  ais8 c d4 c f |
  % 11
  dis8 c f4 f c |
  % 12
  d8 a ais4 c c |
  % 13
  d2. a8 ais |
  % 14
  c d dis4 d a |
  % 15
  ais gis g c |
  % 16
  c ais ais a |
  % 17
  f2. f8 a |
  % 18
  c4 c d d8 c |
  % 19
  ais4 gis g c |
  % 20
  c c f c |
  % 21
  ais8 gis g4 f ais |
  % 22
  a ais8 a g a ais4 |
  % 23
  ais a ais ais |
  % 24
  c c c b |
  % 25
  g2 d'4 c |
  % 26
  ais gis a2 |
  % 27
  ais4 b c2. ais4 ais ais |
  % 29
  gis8 ais c d dis4 f |
  % 30
  d dis2 d4 |
  % 31
  c f dis d8 dis |
  % 32
  f4 dis8 d c4 ais |
  % 33
  c ais2 ais4 |
  % 34
  c d dis d |
  % 35
  dis c d2. 
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
  g a g f dis f dis d |
  % 3
  c4 d8 dis f4 dis |
  % 4
  d g8 f e4 f |
  % 5
  ais,2. f'8 g |
  % 6
  a ais c4 fis,4. d8 |
  % 7
  g f dis d dis4 e |
  % 8
  f g f8 dis f4 |
  % 9
  ais,2. ais'8 a |
  % 10
  g a g f dis f dis d |
  % 11
  c4 d8 dis f4 dis |
  % 12
  d g8 f e4 f |
  % 13
  ais,2. f'8 g |
  % 14
  a ais c4 fis,4. d8 |
  % 15
  g f dis d dis4 e |
  % 16
  f g f8 dis f4 |
  % 17
  ais,2. f4 |
  % 18
  f'8 g f dis d e fis d |
  % 19
  g f dis d dis4 e |
  % 20
  f c8 d dis g f dis |
  % 21
  d ais dis4 ais ais' |
  % 22
  fis g8 f dis f dis d |
  % 23
  c4 f ais, ais' |
  % 24
  a gis g8 f g4 |
  % 25
  c,2 d4 dis |
  % 26
  e f f fis |
  % 27
  g g gis g |
  % 28
  fis g f e |
  % 29
  f8 g gis4 g f |
  % 30
  g c,2 g'4 |
  % 31
  gis a2 ais4 |
  % 32
  b2 c4 g |
  % 33
  a ais8 c ais a g f |
  % 34
  dis g f dis d c f4 |
  % 35
  dis f ais,2. 
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
