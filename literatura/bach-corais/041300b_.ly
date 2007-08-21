% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 041300b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key d \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  d'4. e8 f g a2 d4 d e |
  % 3
  cis d2 d4 |
  % 4
  f2 e4 d2 c4 d8 c ais2 a2. |
  % 7
  d,4. e8 f g a2 d4 d e |
  % 9
  cis d2 d4 |
  % 10
  f2 e4 d2 c4 d8 c ais2 a2. |
  % 13
  a2 a8 ais c2 f,4 ais2 |
  % 15
  a4 g2 g4 |
  % 16
  g2 a4 ais2 c4 ais a |
  % 18
  ais g2. |
  % 19
  a2 a8 ais c2 a4 ais a2 g2. |
  % 22
  f2 f4 f |
  % 23
  e f g f |
  % 24
  g a2 a4 |
  % 25
  a2 g4 a2 g4 a b2 c2. |
  % 28
  d2 e4 f4. e8 d4 d e |
  % 30
  cis d2. |
  % 31
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  a'4 d8 cis d e f e |
  % 2
  f g a2 ais4 |
  % 3
  a a2 a4 |
  % 4
  a2 a4 f2 f4 f f8 g |
  % 6
  f e f2. |
  % 7
  a,4 d8 cis d e f e |
  % 8
  f g a2 ais4 |
  % 9
  a a2 a4 |
  % 10
  a2 a4 f2 f4 f f8 g |
  % 12
  f e f2. |
  % 13
  f2 f4. g8 |
  % 14
  f e f4 f2 |
  % 15
  f e8 d e4 |
  % 16
  e d d d |
  % 17
  g8 fis g4 g g |
  % 18
  fis d2. |
  % 19
  f8 e f g d f g e |
  % 20
  f g a g f2 |
  % 21
  f e |
  % 22
  f4 c2 d4 |
  % 23
  e d8 c d4 c8 d |
  % 24
  e4 f2 f4 |
  % 25
  f2 g4 g |
  % 26
  f e f2 |
  % 27
  g4 g2. |
  % 28
  g4 a2 a4. g8 f2 e4 |
  % 30
  e8 g fis2. |
  % 31
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  f4. g8 a2 |
  % 2
  d4. e8 f4 g |
  % 3
  e8 g4. f8 e f4 |
  % 4
  d2 c |
  % 5
  ais4. a8 ais c d4 |
  % 6
  c c2. |
  % 7
  f,4. g8 a2 |
  % 8
  d4. e8 f4 g |
  % 9
  e8 g4. f8 e f4 |
  % 10
  d2 c |
  % 11
  ais4. a8 ais c d4 |
  % 12
  c c2. |
  % 13
  d2 d4 c2 a4 d c2 c c4 |
  % 16
  c d a2 |
  % 17
  g4 c8 d dis d dis c |
  % 18
  a d ais2. |
  % 19
  d4 d d c2 c4 d c2 c2. |
  % 22
  c4. ais8 a g a2 a4 g a |
  % 24
  ais c2 c4 |
  % 25
  c2 c4 c2 c4 c d2 e2. |
  % 28
  ais,4 f' e2 |
  % 29
  d8 cis d c ais4 ais |
  % 30
  a a2. |
  % 31
  
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
  d4 d, d' d8 cis |
  % 2
  d e f g a4 g |
  % 3
  a d,2 d,4 |
  % 4
  d'8 e f g a a, ais c |
  % 5
  d e f f, ais a g4 |
  % 6
  c f,2. |
  % 7
  d'4 d, d' d8 cis |
  % 8
  d e f g a4 g |
  % 9
  a d,2 d,4 |
  % 10
  d'8 e f g a a, ais c |
  % 11
  d e f f, ais a g4 |
  % 12
  c f,2. |
  % 13
  d'4 d' c8 ais a a, |
  % 14
  ais c d c d e f g |
  % 15
  a ais c2 c,4 |
  % 16
  c' ais8 a g fis g f |
  % 17
  dis d dis d c ais c4 |
  % 18
  d g,2. |
  % 19
  d'8 cis d e f d e c |
  % 20
  d e f e d e f g |
  % 21
  a ais c2. |
  % 22
  a8 ais a g f e d e |
  % 23
  d c ais a g a f ais |
  % 24
  a g f2 f4 |
  % 25
  f8 a c f4 e8 f g |
  % 26
  a ais c c, f e d g |
  % 27
  f g c,2. |
  % 28
  g8 g' f e d cis d f |
  % 29
  g a ais a g f g e |
  % 30
  a a, d2. |
  % 31
  
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
