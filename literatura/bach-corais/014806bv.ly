% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 014806bv.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key c \minor
  
  \tempo 4 = 100 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. f'4 |
  % 2
  f g gis ais |
  % 3
  c2 s4 c |
  % 4
  c4. ais8 gis4 ais |
  % 5
  g2 s4 g |
  % 6
  gis ais c c |
  % 7
  ais2 c4 c |
  % 8
  gis ais c cis8 dis |
  % 9
  c4 ais8 gis gis4 c |
  % 10
  dis c c c |
  % 11
  ais2 ais4 ais |
  % 12
  c4. ais8 gis4 ais8 gis |
  % 13
  g2 f |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. c'4 |
  % 2
  c d8 e f e f g |
  % 3
  e2 s4 dis4. f8 g4 g8 f e f |
  % 5
  e2 s4 e |
  % 6
  f dis dis f |
  % 7
  f dis dis dis |
  % 8
  f f8 g gis4 gis |
  % 9
  gis g dis gis |
  % 10
  ais gis gis gis |
  % 11
  gis g8 f g4 g |
  % 12
  g8 f e4 f f2 e4 c2 |
  % 14
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. gis'8 ais |
  % 2
  c4 ais c cis |
  % 3
  g2 s4 gis |
  % 4
  gis g c cis |
  % 5
  c2 s4 c |
  % 6
  c8 cis c ais gis4 gis2 g4 gis gis |
  % 8
  gis cis c f |
  % 9
  dis cis8 c c4 dis |
  % 10
  dis dis f dis |
  % 11
  f8 dis d4 dis dis8 cis |
  % 12
  c4 c c ais8 c |
  % 13
  cis4 c8 ais a2 |
  % 14
  
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
  s2. f8 g |
  % 2
  gis4 g f cis |
  % 3
  c2 s4 gis8 ais |
  % 4
  c cis dis e f4 ais, |
  % 5
  c2 s4 c |
  % 6
  f g gis8 g f dis |
  % 7
  cis4 dis gis, gis |
  % 8
  cis8 c ais4 f'8 dis cis4 |
  % 9
  dis2 gis,4 gis' |
  % 10
  g gis8 g f dis d c |
  % 11
  dis4 ais dis g8 f |
  % 12
  e d c4 f8 dis cis c |
  % 13
  ais4 c f,2 |
  % 14
  
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
