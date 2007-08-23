% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 171.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  g''4 a ais g |
  % 2
  s4 d' c ais |
  % 3
  a g a2 |
  % 4
  ais4 c d ais |
  % 5
  s4 d dis d |
  % 6
  c c ais2 |
  % 7
  d4 c ais g |
  % 8
  s4 c c ais |
  % 9
  a g f2 |
  % 10
  ais4 c d ais |
  % 11
  s4 d c g8 a |
  % 12
  ais4 a g2 |
  % 13
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  d'4 d d d |
  % 2
  s4 g4. fis8 g4. fis8 g g, d'2 |
  % 4
  f4 f f f |
  % 5
  s4 ais4. a8 ais4 |
  % 6
  ais a f2 |
  % 7
  f4. fis8 g4 d |
  % 8
  s4 g4. f16 e f2 e4 c2 |
  % 10
  g'4 a ais8 gis g4 |
  % 11
  s4 g g g2 fis4 d2 |
  % 13
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  ais'4 a g ais |
  % 2
  s4 ais c d |
  % 3
  d4. c8 fis,2 |
  % 4
  d'4 c ais d |
  % 5
  s4 f dis f |
  % 6
  g f8 dis d2 |
  % 7
  ais4 c d ais |
  % 8
  s4 c8 ais a4. g8 |
  % 9
  a ais c ais a2 |
  % 10
  d4 f f dis |
  % 11
  s4 f dis ais8 c |
  % 12
  d4. c8 b2 |
  % 13
  
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
  g'4. fis8 g4 g, |
  % 2
  s4 g a ais8 c |
  % 3
  d4 dis d2 |
  % 4
  d8 ais4 a8 ais4 ais' |
  % 5
  s4 ais8 gis g4 f |
  % 6
  dis f ais,2 |
  % 7
  ais8 ais'4 a8 g4 g, |
  % 8
  s4 e' f d |
  % 9
  c c f,2 |
  % 10
  g'4 f8 dis d ais dis4 |
  % 11
  s4 b c8 d dis4 |
  % 12
  d d, g2 |
  % 13
  
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
