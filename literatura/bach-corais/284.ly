% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 284.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key f \major
  
  \tempo 4 = 90 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. f''4 |
  % 2
  f f e c |
  % 3
  d e f f |
  % 4
  e d c ais |
  % 5
  a g a a |
  % 6
  g a8 b c4 d |
  % 7
  c b c c |
  % 8
  d e f e |
  % 9
  d d c c |
  % 10
  ais a d c |
  % 11
  ais a g g |
  % 12
  a b c d |
  % 13
  c b c2 |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. a''4 |
  % 2
  a a g a8 g |
  % 3
  f4 g a a |
  % 4
  g8 f f g g a d, e |
  % 5
  f4 e8 d cis4 d |
  % 6
  d8 c c4 c8 f f4 |
  % 7
  f8 e d4 e f |
  % 8
  f ais a8 g g4 |
  % 9
  fis gis a a |
  % 10
  a8 g g f f dis dis d |
  % 11
  d e f4 e e |
  % 12
  dis8 d d4 dis f |
  % 13
  f8 dis d4 e2 |
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
  s2. c'4 |
  % 2
  c c8 d e4 f8 e |
  % 3
  d c ais4 c d8 c |
  % 4
  ais c d4 e8 d d cis |
  % 5
  d a ais4 e f |
  % 6
  g f e8 a a g |
  % 7
  g4 g g a |
  % 8
  ais ais c8 d e4 |
  % 9
  a,8 b16 c d8 e e4 e |
  % 10
  f8 c c4 ais fis |
  % 11
  g c c c |
  % 12
  c g g gis8 g |
  % 13
  g4 g g2 |
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
  a4 g8 f c' ais a4 |
  % 3
  ais8 a g4 f d |
  % 4
  g8 a ais4 e8 fis g4 |
  % 5
  d8 c ais4 a d |
  % 6
  e f8 g a4 ais |
  % 7
  c g c, f |
  % 8
  ais a8 g a b c4 |
  % 9
  c8 b16 a b8 e, a4 a, |
  % 10
  d8 e f4 ais,8 c d4 |
  % 11
  g, a8 ais c4 c' |
  % 12
  fis, f dis b |
  % 13
  c g c2 |
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
