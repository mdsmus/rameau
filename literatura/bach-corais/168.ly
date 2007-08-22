% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 168.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \minor
  
  \tempo 4 = 92 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d'4 |
  % 2
  f g a ais |
  % 3
  a g c ais |
  % 4
  a2 s4 d |
  % 5
  c ais a g |
  % 6
  f g f dis |
  % 7
  d2 s4 a' |
  % 8
  ais c d d |
  % 9
  c g8 a ais4 a |
  % 10
  g1 |
  % 11
  
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
  a8 f'4 e8 f4 d8 e |
  % 3
  fis4 g4. a4 g8 |
  % 4
  fis2 s4 ais4. a4 g f dis d8 dis d c ais c a |
  % 7
  ais2 s4 c |
  % 8
  d8 f g a ais4 g8 f |
  % 9
  dis f g4 g4. fis8 |
  % 10
  d1 |
  % 11
  
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
  f8 a d c c4 g |
  % 3
  a16 ais c4 ais16 a g8 d' d4 |
  % 4
  d2 s4 f16*7 dis16 d16*7 c16 ais2 ais4 f2 |
  % 7
  f s4 f |
  % 8
  f' dis f d |
  % 9
  g, c d4. c8 |
  % 10
  b1 |
  % 11
  
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
  s2. g4 |
  % 2
  d' ais8 c f4 g |
  % 3
  d e4. fis8 g4 |
  % 4
  d2 s4 ais |
  % 5
  f' g d dis |
  % 6
  ais8 a g4 a8 g a f |
  % 7
  ais2 s4 f'8 dis |
  % 8
  d4 c ais b |
  % 9
  c8 d dis4 ais8 c d4 |
  % 10
  g,1 |
  % 11
  
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
