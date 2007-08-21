% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 004008b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key c \minor
  
  \tempo 4 = 80 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  c''4 c ais gis |
  % 2
  g4. f8 f4 f |
  % 3
  gis4. ais8 c4 c |
  % 4
  ais4. gis8 gis2 |
  % 5
  gis4 ais ais gis |
  % 6
  g4. f8 f2 |
  % 7
  c'4 c cis cis |
  % 8
  ais ais c c |
  % 9
  gis gis cis cis |
  % 10
  c c ais2 |
  % 11
  g4 gis ais gis |
  % 12
  g g f2 |
  % 13
  f'4 f dis dis |
  % 14
  d d c c |
  % 15
  c c cis c |
  % 16
  ais4. gis8 gis4 gis |
  % 17
  gis gis cis cis |
  % 18
  ais ais dis dis |
  % 19
  c c f f |
  % 20
  e e f f2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  f'4 f f8 e f4 |
  % 2
  f8 g e4 f c |
  % 3
  f4. g8 gis4 gis |
  % 4
  gis8 f g4 dis2 |
  % 5
  f4 g e f |
  % 6
  f e c2 |
  % 7
  f4 f f f |
  % 8
  g8 gis ais g gis4 gis |
  % 9
  f f ais ais |
  % 10
  ais a f2 |
  % 11
  e4 f f8 e f4 |
  % 12
  f e c2 |
  % 13
  gis'4 gis g g |
  % 14
  g8 gis g f e4 e |
  % 15
  f f f8 g gis4 |
  % 16
  gis8 f g4 dis dis |
  % 17
  f f ais ais |
  % 18
  g g c c |
  % 19
  gis8 g gis ais c4 ais8 gis |
  % 20
  g4 g a a2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  gis'4 a ais c |
  % 2
  cis c8 ais gis4 gis |
  % 3
  c4. ais8 dis4 dis |
  % 4
  f dis8 cis c2 |
  % 5
  cis4 cis g f8 gis |
  % 6
  cis4 c8 ais gis2 |
  % 7
  a8 ais c a ais4 ais |
  % 8
  ais dis dis dis |
  % 9
  cis cis f f |
  % 10
  fis f8 dis cis2 |
  % 11
  c4 c ais c |
  % 12
  cis c8 ais gis2 |
  % 13
  c4 c c c |
  % 14
  c b c g |
  % 15
  a a ais dis, |
  % 16
  dis'4. cis8 c4 c |
  % 17
  cis cis f f |
  % 18
  dis dis g g |
  % 19
  f f c f, |
  % 20
  c' c c c2. 
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
  f4 dis cis c |
  % 2
  ais c f, f |
  % 3
  f' dis8 cis c ais gis4 |
  % 4
  cis dis gis,2 |
  % 5
  cis4 c8 ais c4 cis |
  % 6
  ais c f,2 |
  % 7
  f'8 g a f ais, c cis ais |
  % 8
  dis f g dis gis4 gis |
  % 9
  cis,8 dis f cis ais c cis ais |
  % 10
  dis c f4 ais,2 |
  % 11
  ais'4 gis g f |
  % 12
  ais, c f,2 |
  % 13
  f8 g gis ais c d dis f |
  % 14
  g4 g, c c |
  % 15
  f8 dis cis c ais4 c8 cis |
  % 16
  dis4 dis gis, gis |
  % 17
  cis8 dis cis c ais c cis ais |
  % 18
  dis f dis cis c cis dis c |
  % 19
  f e f g gis g gis ais |
  % 20
  c4 c, f f2. 
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
