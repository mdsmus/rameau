% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 174.mid
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
  g''4 f f g |
  % 2
  a g f e |
  % 3
  d2 s4 f |
  % 4
  g a g fis |
  % 5
  g2 s4 c |
  % 6
  g8 a ais4 a g |
  % 7
  a2 s4 g |
  % 8
  f g a g |
  % 9
  f e d f |
  % 10
  g a g fis |
  % 11
  g1 |
  % 12
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  d'4 d d4. c8 |
  % 2
  c f4 e8 d4. cis8 |
  % 3
  a2 s4 d |
  % 4
  d dis8 d d4 d |
  % 5
  d2 s4 g8 f |
  % 6
  dis4 d8 g4 fis8 g g, |
  % 7
  d'2 s4 d8 cis |
  % 8
  d f4 e8 f4 e4. d4 cis8 a4 d |
  % 10
  d dis d d |
  % 11
  d1 |
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
  ais'4 ais a8 ais g4 |
  % 2
  f8 a ais4 b e,8 a16 g |
  % 3
  f2 s4 a |
  % 4
  ais8 g c4. ais8 a4 |
  % 5
  ais2 s4 c |
  % 6
  c d d4. c8 |
  % 7
  fis,2 s4 ais |
  % 8
  a c c ais |
  % 9
  a16*7 g16 f4 a |
  % 10
  ais c4. ais8 a c |
  % 11
  b1 |
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
  g8 a ais c d4 e |
  % 2
  f g gis a8 a, |
  % 3
  d2 s4 d8 c |
  % 4
  ais4 fis g d' |
  % 5
  g,2 s4 dis'8 d |
  % 6
  c4 g d' dis |
  % 7
  d2 s4 g, |
  % 8
  d' c f8 e d cis |
  % 9
  d4 a d, d'8 c |
  % 10
  ais a g fis g4 d |
  % 11
  g1 |
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
