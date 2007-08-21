% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 001805b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. g''4 |
  % 2
  g g f g |
  % 3
  dis d c g'8 a |
  % 4
  ais4 c g a |
  % 5
  ais a g g |
  % 6
  g g f g |
  % 7
  dis d c g'8 a |
  % 8
  ais4 c g a |
  % 9
  ais a g ais |
  % 10
  ais ais8 gis g f dis f |
  % 11
  g4 f dis g |
  % 12
  g g f dis8 d |
  % 13
  d2 c4 g' |
  % 14
  g f g a |
  % 15
  ais8 a g4 f c' |
  % 16
  d c g8 a ais4 |
  % 17
  a g a2 |
  % 18
  g2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. d'4 |
  % 2
  dis dis dis d |
  % 3
  d8 c c b c4 dis |
  % 4
  d c8 d dis4 dis |
  % 5
  d c b d |
  % 6
  dis dis dis d |
  % 7
  d8 c c b c4 dis |
  % 8
  d c8 d dis4 dis |
  % 9
  d c b g' |
  % 10
  f8 dis d c ais4 c8 d |
  % 11
  dis4 d dis ais8 c |
  % 12
  d4 c c c |
  % 13
  c b c d |
  % 14
  dis dis8 d dis g f dis |
  % 15
  d c ais4 a f' |
  % 16
  f dis8 d c4 d |
  % 17
  d8 c ais4 dis d8 c |
  % 18
  b2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. g'4 |
  % 2
  c c c g |
  % 3
  g g8 f dis4 c' |
  % 4
  ais8 a g4 c c |
  % 5
  fis,8 g4 fis8 g4 g |
  % 6
  c c c g |
  % 7
  g g8 f dis4 c' |
  % 8
  ais8 a g4 c c |
  % 9
  fis,8 g4 fis8 g4 d' |
  % 10
  ais f g g8 gis |
  % 11
  ais4. gis8 g4 g |
  % 12
  g8 f dis4 f8 g gis4 |
  % 13
  g4. f8 dis4 g |
  % 14
  c8 ais gis4 ais c |
  % 15
  f,4. e8 f4 a |
  % 16
  ais8 a g fis g4 g |
  % 17
  fis g2 fis4 |
  % 18
  g2. 
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
  s2. b4 |
  % 2
  c8 d dis4 a b |
  % 3
  c g c c |
  % 4
  g'8 f dis d c ais a g |
  % 5
  d'2 g,4 b |
  % 6
  c8 d dis4 a b |
  % 7
  c g c c |
  % 8
  g'8 f dis d c ais a g |
  % 9
  d'2 g,4 g' |
  % 10
  d8 c ais4 dis8 d c4 |
  % 11
  g8 gis ais4 dis, dis' |
  % 12
  b c8 ais gis g f4 |
  % 13
  g2 c4 b |
  % 14
  c f dis8 d c4 |
  % 15
  ais c f, f' |
  % 16
  ais, c8 d dis4 ais8 c |
  % 17
  d4 dis8 d c4 d |
  % 18
  g,2. 
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
