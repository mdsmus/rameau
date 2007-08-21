% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 004705b_.mid
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
  g8 a ais4 a d8 d |
  % 3
  c4 ais a ais8 a |
  % 4
  g4 d' c d |
  % 5
  g,8 a b4 c ais |
  % 6
  a d c ais |
  % 7
  a2 s4 g8 a |
  % 8
  ais4 ais c c |
  % 9
  d d ais d |
  % 10
  c ais a g8 a |
  % 11
  ais4 a g2 |
  % 12
  
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
  dis d8 e fis4 g8 g |
  % 3
  a4 g fis g |
  % 4
  g f8 g a4 b |
  % 5
  c g8 g g4 g |
  % 6
  fis g a d, |
  % 7
  d2 s4 d |
  % 8
  g g8 f dis4 f8 g |
  % 9
  gis4 g8 f g4 g |
  % 10
  g8 fis g4 fis g |
  % 11
  g fis d2 |
  % 12
  
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
  c ais8 c d4 d8 d |
  % 3
  d4 d d d8 c |
  % 4
  ais c d dis f4 f |
  % 5
  g d8 d dis4 d |
  % 6
  d d fis, g |
  % 7
  fis2 s4 ais8 c |
  % 8
  d4 cis c8 ais gis g |
  % 9
  f4 f' dis f |
  % 10
  dis e a,8 ais c4 |
  % 11
  d8 e a, c b2 |
  % 12
  
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
  c8 c g4 d' ais'8 ais |
  % 3
  fis4 g d g, |
  % 4
  g'8 a ais4 f d |
  % 5
  dis8 f g4 c, g' |
  % 6
  d8 c ais4 a g |
  % 7
  d'2 s4 g, |
  % 8
  g'8 f dis4 gis8 g f4 |
  % 9
  ais, ais dis b |
  % 10
  c cis d dis |
  % 11
  d8 cis d4 g,2 |
  % 12
  
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
