% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 026.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key f \major
  
  \tempo 4 = 80 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. f'8 g |
  % 2
  a4 ais c c |
  % 3
  d e f f,8 g |
  % 4
  a4 ais c c |
  % 5
  ais a g a |
  % 6
  f f ais a |
  % 7
  g2 f4 f8 g |
  % 8
  a4 ais c c |
  % 9
  d e f f,8 g |
  % 10
  a4 ais c c |
  % 11
  ais a g a |
  % 12
  f f ais a |
  % 13
  g2 f4 c' |
  % 14
  g a ais ais |
  % 15
  a a g c |
  % 16
  d e f a, |
  % 17
  g g f 
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
  f e f a |
  % 3
  ais8 a g4 a c, |
  % 4
  f g g f |
  % 5
  f8 e f4 e e |
  % 6
  e d d8 e f4 |
  % 7
  f e c c |
  % 8
  f e f a |
  % 9
  ais8 a g4 a c, |
  % 10
  f g g f |
  % 11
  f8 e f4 e e |
  % 12
  e d d8 e f4 |
  % 13
  f e c f |
  % 14
  g g fis g |
  % 15
  g fis d f |
  % 16
  f c'8 ais a g f4 |
  % 17
  f e c 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. a'8 ais |
  % 2
  c4 ais a8 c f4 |
  % 3
  f c c a |
  % 4
  d d c8 ais a4 |
  % 5
  ais c c a |
  % 6
  a a g a |
  % 7
  d c8 ais a4 a8 ais |
  % 8
  c4 ais a8 c f4 |
  % 9
  f c c a |
  % 10
  d d c8 ais a4 |
  % 11
  ais c c a |
  % 12
  a a g a |
  % 13
  d c8 ais a4 a |
  % 14
  ais c d e |
  % 15
  a,8 ais c4 ais c |
  % 16
  ais8 a g4 f8 g a ais |
  % 17
  c g c ais a4 
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
  s2. f4 |
  % 2
  f g a f |
  % 3
  ais c f, f8 e |
  % 4
  d4 c8 ais a4 d |
  % 5
  g, a8 ais c4 cis |
  % 6
  d8 e f d g4 d8 c |
  % 7
  ais4 c f, f' |
  % 8
  f g a f |
  % 9
  ais c f, f8 e |
  % 10
  d4 c8 ais a4 d |
  % 11
  g, a8 ais c4 cis |
  % 12
  d8 e f d g4 d8 c |
  % 13
  ais4 c f, f' |
  % 14
  e dis d cis |
  % 15
  d d g, a |
  % 16
  ais c d8 e f4 |
  % 17
  c c f, 
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
