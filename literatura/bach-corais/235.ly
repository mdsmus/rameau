% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 235.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key f \major
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  c''4 a g2 |
  % 2
  f c'4 d |
  % 3
  c2 f4 f |
  % 4
  e e d4. c8 |
  % 5
  c2 c4 d |
  % 6
  c ais a2 |
  % 7
  s4 g a8 b c4 |
  % 8
  c b c2 |
  % 9
  c4 d ais ais |
  % 10
  a ais a g |
  % 11
  f2 s4 a |
  % 12
  g2 f4 c' |
  % 13
  c b c f |
  % 14
  f e d2 |
  % 15
  c c4 d8 c |
  % 16
  ais4 ais a ais8 a |
  % 17
  g2 f |
  % 18
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  f'4 f4. e16 d e4 |
  % 2
  c2 g'4 g |
  % 3
  g2 f4 g |
  % 4
  g e8 f16 g a4. g16 f |
  % 5
  e2 f4 f |
  % 6
  e d8 c c2 |
  % 7
  s4 e8 g f4 e |
  % 8
  a8 g16 f g4 g2 |
  % 9
  a4 a4. g16 f g4. f16 e f4. e16 d e4 |
  % 11
  c2 s4 f |
  % 12
  f e d g |
  % 13
  a g8 f e4 f |
  % 14
  g g a g8 f |
  % 15
  e2 f4 f8 e |
  % 16
  d4 c c8 d16 e f4. e16 d e4 c2 |
  % 18
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  a'8 ais c4. g8 c ais |
  % 2
  a2 c4. b8 |
  % 3
  e2 a,4 d4. c16 b c4. b16 a b4 |
  % 5
  g2 a4 ais8 a |
  % 6
  g4 f8 g a2 |
  % 7
  s4 c c c |
  % 8
  d4. e16 f e2 |
  % 9
  f4 f d c |
  % 10
  c ais8 d c4. ais8 |
  % 11
  a2 s4 c |
  % 12
  c4. ais8 a4 g |
  % 13
  d' d c c |
  % 14
  d4. c4 b16 a b4 |
  % 15
  g2 a4 a |
  % 16
  ais8 a g4 f8 a d4. ais8 g c a2 |
  % 18
  
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
  f,8 g a ais c2 |
  % 2
  f, e'8 c g' g, |
  % 3
  c2 d8 c b g |
  % 4
  c e a g f d g g, |
  % 5
  c2 f4 ais, |
  % 6
  c d8 e f2 |
  % 7
  s4 c8 e f g a g |
  % 8
  f d g g, c2 |
  % 9
  f8 e d f g f e c |
  % 10
  f e d ais c4 c, |
  % 11
  f2 s4 f' |
  % 12
  c2 d4 e |
  % 13
  f g a a |
  % 14
  b c f, g |
  % 15
  c,2 f8 e d f |
  % 16
  g f e c f e d c |
  % 17
  ais g c4 f,2 |
  % 18
  
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
