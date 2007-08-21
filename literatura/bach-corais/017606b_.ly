% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 017606b_.mid
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
  s2. f'8 g |
  % 2
  gis4 ais c ais |
  % 3
  dis d8 c c4 ais |
  % 4
  dis d c ais |
  % 5
  gis g f f8 g |
  % 6
  gis4 ais c ais |
  % 7
  dis d8 c c4 ais |
  % 8
  dis d c ais |
  % 9
  gis g f f |
  % 10
  ais ais g c |
  % 11
  c b c c |
  % 12
  f f g8 f dis4 |
  % 13
  f8 dis d4 c d |
  % 14
  dis d c ais |
  % 15
  c8 ais gis4 g f8 g |
  % 16
  gis4 ais c8 ais gis4 |
  % 17
  ais8 gis g4 f f' |
  % 18
  f f g f |
  % 19
  dis d c2 |
  % 20
  
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
  c8 d dis4 dis8 f g4 |
  % 3
  g g g g |
  % 4
  g g gis8 g f4 |
  % 5
  c8 f4 e8 c4 c |
  % 6
  f g gis g |
  % 7
  c b g g |
  % 8
  g8 c c ais ais gis g e |
  % 9
  f4 e c c |
  % 10
  f dis8 d dis f g4 |
  % 11
  g g g g |
  % 12
  c ais ais c8 ais |
  % 13
  gis4 d8 dis16 f dis4 g |
  % 14
  g f dis8 f g4 |
  % 15
  c, f e c |
  % 16
  f g g8 e f4 |
  % 17
  g8 f e4 c c' |
  % 18
  ais ais ais c8 f, |
  % 19
  g4. f8 e2 |
  % 20
  
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
  gis g gis dis'8 d |
  % 3
  c4 b dis d |
  % 4
  c d8 e f4 f,8 g |
  % 5
  gis ais c4 gis gis8 g |
  % 6
  f gis cis4 dis dis8 f |
  % 7
  g4 g dis d |
  % 8
  c f,8 g gis4 ais |
  % 9
  c ais8 gis gis4 gis8 g |
  % 10
  f4 ais ais dis |
  % 11
  d8 c d4 dis dis |
  % 12
  dis d dis8 d c4 |
  % 13
  d8 c b4 g b |
  % 14
  c8 ais gis ais c d e f |
  % 15
  g4 c, c gis8 g |
  % 16
  f gis cis4 c cis |
  % 17
  cis g8 gis16 ais gis4 f |
  % 18
  d'8 dis f d dis d c4 |
  % 19
  c b g2 |
  % 20
  
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
  s2. ais4 |
  % 2
  f' dis gis g8 f |
  % 3
  dis f g4 c, g' |
  % 4
  c ais gis d8 e |
  % 5
  f4 c f, f'8 dis |
  % 6
  cis c ais4 gis dis'8 d |
  % 7
  c4 g' c g |
  % 8
  c, d8 e f4 cis |
  % 9
  c8 ais c4 f, f'8 dis |
  % 10
  d c ais4 dis d8 c |
  % 11
  g'4 g, c c'8 ais |
  % 12
  a4 ais dis, gis8 g |
  % 13
  f4 g c, g' |
  % 14
  c, f8 g gis4 g8 f |
  % 15
  e4 f c f8 dis |
  % 16
  cis c ais4 gis cis8 c |
  % 17
  ais4 c f, a' |
  % 18
  ais8 c d ais dis,4 gis |
  % 19
  g8 f g g, c2 |
  % 20
  
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
