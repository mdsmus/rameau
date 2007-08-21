% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 035700b_.mid
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
  g''4. c8 b4 c |
  % 2
  d dis8 d d2 |
  % 3
  dis4 c f dis |
  % 4
  d d8. dis16 c4 c |
  % 5
  g g c ais |
  % 6
  gis g8 f f2 |
  % 7
  ais4 g c8 d dis4 |
  % 8
  g, f8 dis dis4 dis |
  % 9
  g4. a8 b4 b |
  % 10
  c d b b |
  % 11
  c d dis c |
  % 12
  f dis d d |
  % 13
  c g gis g |
  % 14
  g4. f8 g2 |
  % 15
  c4 g gis8 g f dis16 d |
  % 16
  dis4 d8 c c2 |
  % 17
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  dis'4 g f g |
  % 2
  g g g2 |
  % 3
  g4 g f8 g gis4. d8 g f dis4 dis |
  % 5
  dis8 f g4 c,8 d dis4 |
  % 6
  f dis d2 |
  % 7
  f4. dis8 dis f g f |
  % 8
  dis4 d ais ais |
  % 9
  dis dis f g |
  % 10
  g gis g g |
  % 11
  g g g g |
  % 12
  f g g g |
  % 13
  g g4. f4 dis8 |
  % 14
  dis d c4 d2 |
  % 15
  g8 f g dis f4 c |
  % 16
  c b g2 |
  % 17
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  c'4 c d dis |
  % 2
  d c c b |
  % 3
  c dis8 d c4 c |
  % 4
  c b g g |
  % 5
  c d dis ais |
  % 6
  ais ais ais2 |
  % 7
  ais4 ais c8 ais4 c8 |
  % 8
  ais4 ais8. gis16 g4 g |
  % 9
  ais c8 dis d4 d |
  % 10
  dis f d d |
  % 11
  dis d c8 d dis d |
  % 12
  c4 c c b |
  % 13
  c dis c b |
  % 14
  c8 b c4 b2 |
  % 15
  c4 c c gis |
  % 16
  g g8. f16 e2 |
  % 17
  
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
  c4 dis d c |
  % 2
  b c g2 |
  % 3
  c4 c'8 ais gis4. g8 |
  % 4
  f4 g c,2 |
  % 5
  c'4 ais gis g8 f |
  % 6
  dis d dis4 ais2 |
  % 7
  d8 ais dis4 gis, g8 gis |
  % 8
  ais gis ais4 dis,2 |
  % 9
  dis'8 d dis c d gis g f |
  % 10
  dis c f, f' g g, g' f |
  % 11
  dis d c b c g' c ais |
  % 12
  gis4 g8 f g4 g, |
  % 13
  dis' c f g |
  % 14
  gis2 g |
  % 15
  dis8 d dis c f g gis f |
  % 16
  g4 g, c2 |
  % 17
  
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
