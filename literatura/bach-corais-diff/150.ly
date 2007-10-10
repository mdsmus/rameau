% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 150.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key f \major
  
  \tempo 4 = 112 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  r2. d''8 d |
  % 2
  f4. f8 dis4 c |
  % 3
  d2 c |
  % 4
  s4 ais8 ais ais a ais c |
  % 5
  d4 c ais2 |
  % 6
  d4 e f d |
  % 7
  c ais a2 |
  % 8
  g4 d'8 d dis2. d4 c4. c8 |
  % 10
  ais1 |
  % 11
  a4 a ais c |
  % 12
  d4. d8 cis2 |
  % 13
  f4 f e d |
  % 14
  e4. e8 d2 |
  % 15
  ais1*2 c1 |
  % 18
  d1*2 f1 |
  % 21
  dis1*2 dis1 |
  % 24
  d1*3 f1*2 f1 |
  % 30
  f1*3 dis1 |
  % 34
  c1. c2 |
  % 36
  ais1*3 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  f'4 f f2. f4 g f |
  % 3
  f2 f4 f8 f |
  % 4
  d2. ais4 |
  % 5
  ais c d2 |
  % 6
  f4 dis d d |
  % 7
  f d d2 |
  % 8
  d g4 g |
  % 9
  f4. f8 f4 f |
  % 10
  f1 |
  % 11
  f4 d d e |
  % 12
  d4. d8 e2 |
  % 13
  f4 f g f |
  % 14
  e4. e8 fis2 |
  % 15
  g1*2 dis1 |
  % 18
  f1*2 f1 |
  % 21
  g |
  % 22
  dis1*2 f1*3 f1*2 f1 |
  % 30
  f1*3 g1 |
  % 34
  f1. f2 |
  % 36
  f1*3 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  d'4 d d2. d4 c c |
  % 3
  ais2 c4 a8 a |
  % 4
  ais2. ais4 |
  % 5
  ais a ais2 |
  % 6
  ais4 g f ais |
  % 7
  c g a2 |
  % 8
  ais2. ais8 ais |
  % 9
  c4 ais c4. c8 |
  % 10
  d1 |
  % 11
  d4 d ais a |
  % 12
  d d, a'2 |
  % 13
  a4 c c a |
  % 14
  a4. a8 a2 |
  % 15
  g1*2 c1 |
  % 18
  f,1*2 f1 |
  % 21
  c'1*2 c1 |
  % 24
  d1*3 d1*2 f1 |
  % 30
  d1*2 d1 |
  % 33
  c1*2 c1 |
  % 36
  d1*3 
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
  ais'4 ais ais2. d,4 dis f |
  % 3
  ais,2 f4 f'8 f |
  % 4
  g2. g4 |
  % 5
  ais f ais,2 |
  % 6
  ais4 c d ais |
  % 7
  f g d'2 |
  % 8
  g,2. g'8 g |
  % 9
  a4 ais f4. f8 |
  % 10
  ais,1 |
  % 11
  d4 d d c |
  % 12
  ais4. ais8 a2 |
  % 13
  f4 f c' d |
  % 14
  a4. a8 d2 |
  % 15
  dis1*2 c1 |
  % 18
  ais1*2 d1 |
  % 21
  c1*2 c1 |
  % 24
  ais1*3 ais'1*2 a1 |
  % 30
  ais1*3 dis,1 |
  % 34
  f1. f2 |
  % 36
  ais,1*3 
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
  s2. ais''8 ais |
  % 2
  d4 ais c a |
  % 3
  ais2 a |
  % 4
  s4 g8 g g4 g |
  % 5
  f4. f8 f2 |
  % 6
  f4 c' a ais |
  % 7
  a g g fis |
  % 8
  g ais8 ais ais2 |
  % 9
  f4 ais2 a4 |
  % 10
  ais1 |
  % 11
  f4 f g a |
  % 12
  a g a2 |
  % 13
  a4 a g d' |
  % 14
  d4. cis8 d2 |
  % 15
  g,1*2 a1 |
  % 18
  ais1*2 ais1 |
  % 21
  ais1*2 a1 |
  % 24
  ais1*3 d1*2 c1 |
  % 30
  ais1*2 ais1 |
  % 33
  ais1*2 a1 |
  % 36
  ais1*3 
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
