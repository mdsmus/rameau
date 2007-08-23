% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 225.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \minor
  
  \tempo 4 = 92 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d''4 |
  % 2
  g, a8 ais c4 ais |
  % 3
  a a g c |
  % 4
  c c d c |
  % 5
  d e f d |
  % 6
  c ais a g |
  % 7
  a2 g4 d' |
  % 8
  g, a8 ais c4 ais |
  % 9
  a a g c |
  % 10
  c c d c |
  % 11
  d e f d |
  % 12
  c ais a g |
  % 13
  a2 g4 a |
  % 14
  ais c d dis |
  % 15
  d c ais d |
  % 16
  f dis d g,8 a |
  % 17
  ais4 a g2 |
  % 18
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. g''4 |
  % 2
  g fis8 g a4. g4 fis16 e fis4 d g |
  % 4
  f8 e f4 f f |
  % 5
  ais8 d4 cis8 d4 ais |
  % 6
  a d,8 e fis4 g |
  % 7
  g fis d g |
  % 8
  g fis8 g a4. g4 fis16 e fis4 d g |
  % 10
  f8 e f4 f f |
  % 11
  ais8 d4 cis8 d4 ais |
  % 12
  a d,8 e fis4 g |
  % 13
  g fis d f |
  % 14
  f8 ais4 a8 ais4 c4. ais4 a8 f4 f |
  % 16
  f8 a g f f4 dis |
  % 17
  d8 g4 fis8 d2 |
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
  s2. ais'8 c |
  % 2
  d4 c8 d dis d d4 |
  % 3
  dis8 c a d16 c ais4 c8 ais |
  % 4
  a ais c a ais4 c |
  % 5
  ais8 a g4 a g'4. fis8 g4 d8 c ais4 |
  % 7
  dis8 c a d16 c ais4 ais8 c |
  % 8
  d4 c8 d dis d d4 |
  % 9
  dis8 c a d16 c ais4 c8 ais |
  % 10
  a ais c a ais4 c |
  % 11
  ais8 a g4 a g'4. fis8 g4 d8 c ais4 |
  % 13
  dis8 c a d16 c ais4 c |
  % 14
  d dis f f |
  % 15
  f g8 f16 dis d4 d |
  % 16
  c8 d ais c d4 c8 fis, |
  % 17
  g d' d8. c16 b2 |
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
  s2. g8 a |
  % 2
  ais4 a8 g fis4 g |
  % 3
  c8 a d4 g, e |
  % 4
  f8 g a f ais ais'4 a8 |
  % 5
  g f e4 d g, |
  % 6
  a ais8 c d4 dis8 d |
  % 7
  c4 d g, g8 a |
  % 8
  ais4 a8 g fis4 g |
  % 9
  c8 a d4 g, e |
  % 10
  f8 g a f ais ais'4 a8 |
  % 11
  g f e4 d g, |
  % 12
  a ais8 c d4 dis8 d |
  % 13
  c4 d g, f'8 dis |
  % 14
  d4 c ais8 ais'4 a8 |
  % 15
  ais d, dis f ais,4 ais |
  % 16
  a8 f g a ais4 c |
  % 17
  ais8 g d'4 g,2 |
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
