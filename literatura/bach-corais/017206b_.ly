% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 017206b_.mid
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
  s2. f'4 |
  % 2
  c'8 ais a g f4 c' |
  % 3
  d d c4*1229/1024 s4*819/1024 |
  % 4
  d4 e f e |
  % 5
  d d c4*1229/1024 s4*819/1024 |
  % 6
  d4 c ais a |
  % 7
  g2 f4*1229/1024 s4*819/1024 |
  % 8
  c'8 ais a g f4 c' |
  % 9
  d d c4*1229/1024 s4*819/1024 |
  % 10
  d4 e f e |
  % 11
  d d c4*1229/1024 s4*819/1024 |
  % 12
  d4 c ais a |
  % 13
  g2 f4*1229/1024 s4*819/1024 |
  % 14
  c'2 a |
  % 15
  c a4*2458/1024 s4*614/1024 a4 g g |
  % 17
  a a g g |
  % 18
  a a g2 |
  % 19
  f4*2458/1024 s4*614/1024 e'4 |
  % 20
  d c ais a |
  % 21
  g2 f4*1229/1024 
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
  c c d8 e f4 |
  % 3
  f f f4*1229/1024 s4*819/1024 |
  % 4
  a4 g f8 g g4 |
  % 5
  f f e4*1229/1024 s4*819/1024 |
  % 6
  f4 e f8 g f4 |
  % 7
  f e f4*1434/1024 s4*614/1024 |
  % 8
  c4 c d8 e f4 |
  % 9
  f f f4*1229/1024 s4*819/1024 |
  % 10
  a4 g f8 g g4 |
  % 11
  f f e4*1229/1024 s4*819/1024 |
  % 12
  f4 e f8 g f4 |
  % 13
  f e f4*1229/1024 s4*819/1024 |
  % 14
  g2 a |
  % 15
  g f4*2458/1024 s4*614/1024 f4 e8 d c4 |
  % 17
  c c8 d e4 e |
  % 18
  f f f e |
  % 19
  f4*2458/1024 s4*614/1024 g4 |
  % 20
  f e d c |
  % 21
  d c c4*1229/1024 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. a'4 |
  % 2
  g f8 g a ais c4 |
  % 3
  c8 ais16 a ais8 ais a4*1229/1024 s4*819/1024 |
  % 4
  c4 b c8 d e g, |
  % 5
  a d b4 c4*1229/1024 s4*819/1024 |
  % 6
  ais8 a g4 d'8 c c4 |
  % 7
  c2 c4*1229/1024 s4*819/1024 |
  % 8
  g4 f8 g a ais c4 |
  % 9
  c8 ais16 a ais8 ais a4*1229/1024 s4*819/1024 |
  % 10
  c4 b c8 d e g, |
  % 11
  a d b4 c4*1229/1024 s4*819/1024 |
  % 12
  ais8 a g4 d'8 c c4 |
  % 13
  c2 c4*1229/1024 s4*819/1024 |
  % 14
  c2 c |
  % 15
  c c4*2458/1024 s4*614/1024 c4 c c8 ais |
  % 17
  a ais c4 c c |
  % 18
  c d d c8 ais |
  % 19
  a4*2458/1024 s4*102/1024 c8 ais4 |
  % 20
  ais8 a g4 f8 g a c |
  % 21
  ais8. a16 g4 a4*1229/1024 
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
  e f8 e d4 a |
  % 3
  ais8 c d e f4*1229/1024 s4*819/1024 |
  % 4
  f4 g a8 b c e, |
  % 5
  f d g4 c,4*1229/1024 s4*819/1024 |
  % 6
  ais4 c d8 e f ais, |
  % 7
  c2 f,4*1229/1024 s4*819/1024 |
  % 8
  e'4 f8 e d4 a |
  % 9
  ais8 c d e f4*1229/1024 s4*819/1024 |
  % 10
  f4 g a8 b c e, |
  % 11
  f d g4 c,4*1229/1024 s4*819/1024 |
  % 12
  ais4 c d8 e f ais, |
  % 13
  c2 f,4*1229/1024 s4*819/1024 |
  % 14
  e'2 f |
  % 15
  c f,4*2458/1024 s4*102/1024 g8 a ais c d e c |
  % 17
  f g a ais c ais a g |
  % 18
  f e d c ais g c4 |
  % 19
  f,4*2458/1024 s4*102/1024 f8 g a |
  % 20
  ais4 c d8 e f a, |
  % 21
  ais g c4 f,4*1229/1024 
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
  s2. f''4 |
  % 2
  g a4. g8 f dis |
  % 3
  d e f g a4*1229/1024 s4*819/1024 |
  % 4
  f4 e4. d4 c8 |
  % 5
  a' f d g4 e8 c f4 g a8 ais, c4 d8 |
  % 7
  g, a ais c a4*1229/1024 s4*819/1024 |
  % 8
  g'4 a4. g8 f dis |
  % 9
  d e f g a4*1229/1024 s4*819/1024 |
  % 10
  f4 e4. d4 c8 |
  % 11
  a' f d g4 e8 c f4 g a8 ais, c4 d8 |
  % 13
  g, a ais c a4*1229/1024 s4*819/1024 |
  % 14
  c8 e g4. f16 e f4. g16 f e f d e f8 g a ais |
  % 16
  c4 c,8 d e f g4. f16 e f a g f e8 d c ais |
  % 18
  a g f e d ais'4 a16 g |
  % 19
  a8 c d e f a, ais c |
  % 20
  d ais'4 a g f g16 a e4 f4*1229/1024 
}

trackF = <<
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
