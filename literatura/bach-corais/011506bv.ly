% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 011506bv.mid
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
  g''4 gis ais ais |
  % 2
  dis, f g2 |
  % 3
  c4 d dis g, |
  % 4
  f2 dis |
  % 5
  g4 gis ais ais |
  % 6
  dis, f g2 |
  % 7
  c4 d dis g, |
  % 8
  f2 dis |
  % 9
  ais'4 f g2 |
  % 10
  c4. ais8 a2 |
  % 11
  ais4 f g8 a ais4 |
  % 12
  ais a ais2 |
  % 13
  c4 d dis g, |
  % 14
  f2 dis |
  % 15
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  dis'4 dis f8 dis d4 |
  % 2
  dis dis8 d dis2 |
  % 3
  dis4 f dis8 d dis4 |
  % 4
  dis d ais2 |
  % 5
  dis4 dis f8 dis d4 |
  % 6
  dis dis8 d dis2 |
  % 7
  dis4 f dis8 d dis4 |
  % 8
  dis d ais2 |
  % 9
  f'8 dis d f dis2 |
  % 10
  c4 c c2 |
  % 11
  f4 f4. dis8 d4 |
  % 12
  c2 d |
  % 13
  f4 f dis dis |
  % 14
  dis d ais2 |
  % 15
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  ais'4 c f, g |
  % 2
  g c8 ais ais2 |
  % 3
  gis4 gis ais ais |
  % 4
  c ais8 gis g2 |
  % 5
  ais4 c f, g |
  % 6
  g c8 ais ais2 |
  % 7
  gis4 gis ais ais |
  % 8
  c ais8 gis g2 |
  % 9
  ais4 ais ais2 |
  % 10
  g8 f e g f2 |
  % 11
  ais8 c d4 d8 c ais a |
  % 12
  g4 f f2 |
  % 13
  gis4 ais ais ais |
  % 14
  c8 ais16 gis ais8 f g2 |
  % 15
  
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
  dis8 d c dis d c ais d |
  % 2
  c ais gis ais dis,2 |
  % 3
  gis8 g f gis g f dis g |
  % 4
  gis f ais4 dis,2 |
  % 5
  dis'8 d c dis d c ais d |
  % 6
  c ais gis ais dis,2 |
  % 7
  gis8 g f gis g f dis g |
  % 8
  gis f ais4 dis,2 |
  % 9
  d'8 c ais d dis2 |
  % 10
  e8 d c e f2 |
  % 11
  d8 c ais d dis f g f |
  % 12
  dis c f4 ais,2 |
  % 13
  f8 g gis f g gis ais g |
  % 14
  gis f ais4 dis,2 |
  % 15
  
}

trackE = <<

  \clef bass
  
  \context Voice = channelA \trackEchannelA
  \context Voice = channelB \trackEchannelB
>>


trackFchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 5
  
}

trackFchannelB = \relative c {
  dis8 d c dis d c ais d |
  % 2
  c ais gis ais dis,2 |
  % 3
  gis8 g f gis g f dis g |
  % 4
  gis f ais ais, dis2 |
  % 5
  dis'8 d c dis d c ais d |
  % 6
  c ais gis ais dis,2 |
  % 7
  gis8 g f gis g f dis g |
  % 8
  gis f ais ais, dis2 |
  % 9
  d'8 c ais d dis2 |
  % 10
  e8 d c e f2 |
  % 11
  d8 c ais d dis f g f |
  % 12
  dis c f f, ais2 |
  % 13
  f8 g gis f g gis ais g |
  % 14
  gis f ais ais, dis2 |
  % 15
  
}

trackF = <<

  \clef bass
  
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
    \context Staff=trackF \trackF
  >>
}
