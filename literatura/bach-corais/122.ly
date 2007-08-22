% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 122.mid
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
  c b c d8 dis |
  % 3
  ais4. gis8 g4 g |
  % 4
  f ais g c |
  % 5
  b4. c8 d4 dis |
  % 6
  d8 c ais gis g4 gis8 ais |
  % 7
  f2 dis4 dis' |
  % 8
  d c8 ais ais4 c |
  % 9
  ais gis8 g g4 f |
  % 10
  ais4. gis8 g4 dis'8 d |
  % 11
  b4. c8 d4 dis |
  % 12
  f8 dis d c b4 c8 d |
  % 13
  d4. c8 c4 dis |
  % 14
  dis8 d c b g'4 c,8 a |
  % 15
  b4. c8 c2 |
  % 16
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. dis'8 f |
  % 2
  g4 g g f8 dis |
  % 3
  f4 d dis dis |
  % 4
  c ais8 f' dis d c g' |
  % 5
  f dis dis g16 fis g4 g |
  % 6
  f4. d8 dis4 dis |
  % 7
  dis d ais g' |
  % 8
  f dis8 f g4 gis8 g |
  % 9
  f dis f d dis4 d |
  % 10
  e f d g |
  % 11
  f8 d dis g16 fis g4 g |
  % 12
  f8 g gis4 gis g8 gis |
  % 13
  g4 f8 dis dis4 gis |
  % 14
  gis gis8 g g4 g8 f |
  % 15
  d dis16 f g4 g2 |
  % 16
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. c'4 |
  % 2
  c d dis g, |
  % 3
  f ais ais ais |
  % 4
  gis8 g f ais ais g' f dis |
  % 5
  d4 g,8 a b4 c8 ais |
  % 6
  gis f ais4 ais gis8 g |
  % 7
  c4 ais8 gis g4 ais |
  % 8
  gis8 ais c d dis4 gis, |
  % 9
  ais8 c d4 ais ais |
  % 10
  ais c b c |
  % 11
  d g,8 a b4 c |
  % 12
  c f f dis8 c |
  % 13
  c a b4 c c |
  % 14
  c8 f dis d c b c d |
  % 15
  g,4 d' e2 |
  % 16
  
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
  s2. c4 |
  % 2
  dis g c c, |
  % 3
  d ais dis dis |
  % 4
  dis d dis gis |
  % 5
  d c g' c |
  % 6
  f,8 dis d ais dis d c ais |
  % 7
  gis4 ais dis dis |
  % 8
  f8 g gis4 g f8 dis |
  % 9
  d c ais4 dis ais'8 gis |
  % 10
  g4 f f dis |
  % 11
  d c g' c8 ais |
  % 12
  gis g f dis d4 dis8 f |
  % 13
  g4 g, gis gis'8 g |
  % 14
  f4 f dis8 d dis f |
  % 15
  g4 g, c2 |
  % 16
  
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
