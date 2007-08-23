% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 306.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key ees \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. dis'4 |
  % 2
  dis f g8 f dis4 |
  % 3
  g a ais ais |
  % 4
  gis g f dis8 f |
  % 5
  g4 a ais c |
  % 6
  ais gis g gis |
  % 7
  f2 dis4 dis |
  % 8
  dis f g8 f dis4 |
  % 9
  g a ais ais |
  % 10
  gis g f dis8 f |
  % 11
  g4 a ais c |
  % 12
  ais gis g gis |
  % 13
  f2 dis4 dis' |
  % 14
  dis dis d ais |
  % 15
  c c g dis' |
  % 16
  dis dis d ais |
  % 17
  c c ais g8 gis |
  % 18
  ais4 c ais g |
  % 19
  gis2 g4 f |
  % 20
  g gis ais ais |
  % 21
  gis g f ais |
  % 22
  c d dis d |
  % 23
  c c ais dis, |
  % 24
  f g gis g |
  % 25
  f2 dis |
  % 26
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. ais'4 |
  % 2
  c4. b16 c d4. c16 d |
  % 3
  dis4. d8 d4 g4. f4 dis d8 c d |
  % 5
  dis4 dis d f2 dis16 d dis8 ais dis16 d dis4. d16 c d4 ais ais |
  % 8
  c4. b16 c d4. c16 d |
  % 9
  dis4. d8 d4 g4. f4 dis d8 c d |
  % 11
  dis4 dis d f2 dis16 d dis8 ais dis16 d dis4. d16 c d4 ais ais'8 
  gis |
  % 14
  g4 f f dis |
  % 15
  dis8 cis dis4 dis g |
  % 16
  f f f f |
  % 17
  g f8 dis d4 dis8 f |
  % 18
  g4 gis g g4. f16 dis f8 d dis4 f |
  % 20
  dis dis f g |
  % 21
  c,8 d dis4. d8 f4 |
  % 22
  f f g8 a ais2 a4 g dis |
  % 24
  d dis f8 d ais dis4 d16 c d4 ais2 |
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
  s2. g'4 |
  % 2
  gis gis g g |
  % 3
  c8 ais a4 g d' |
  % 4
  dis8 ais ais4 c8 g g4 |
  % 5
  c8 ais c4 ais gis4. g4 f8 dis4. ais'8 |
  % 7
  c gis f ais g4 g |
  % 8
  gis gis g g |
  % 9
  c8 ais a4 g d' |
  % 10
  dis8 ais ais4 c8 g g4 |
  % 11
  c8 ais c4 ais gis4. g4 f8 dis4. ais'8 |
  % 13
  c gis f ais g4 g8 gis |
  % 14
  ais4 c4. ais16 gis g4 |
  % 15
  gis gis ais c |
  % 16
  c8 ais a4 ais8 a ais4. a16 g a4 ais ais |
  % 18
  dis dis dis8 dis4 c8 |
  % 19
  c4 d8 f c4 gis |
  % 20
  ais c d d,8 e |
  % 21
  f4 ais ais d |
  % 22
  c ais4. c8 d4 |
  % 23
  g, d' d c |
  % 24
  ais ais4. f8 g ais |
  % 25
  c gis f ais16 gis g2 |
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
  s2. dis4 |
  % 2
  gis8 g f4 b, c2 fis,4 g g' |
  % 4
  c,8 d dis4 a8 b c2 f,4 ais f'8 dis |
  % 6
  d ais c d dis d c ais |
  % 7
  gis f ais4 dis, dis' |
  % 8
  gis8 g f4 b, c2 fis,4 g g' |
  % 10
  c,8 d dis4 a8 b c2 f,4 ais f'8 dis |
  % 12
  d ais c d dis d c ais |
  % 13
  gis f ais4 dis, dis8 f |
  % 14
  g4 a ais8 c cis4 |
  % 15
  c8 ais gis4 dis' c8 ais |
  % 16
  a g f4 ais8 c d4 |
  % 17
  c f ais, dis4. cis8 c d dis4 e |
  % 19
  f b, c cis2 c4 ais8 gis g4 |
  % 21
  f g8 gis ais4 ais' |
  % 22
  a gis g4. f8 |
  % 23
  e4 fis g gis4. g8 f dis d ais dis g, |
  % 25
  gis4 ais dis,2 |
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
