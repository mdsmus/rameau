% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 015606b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key c \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. c''4 |
  % 2
  b c d d |
  % 3
  c d e f |
  % 4
  e d c b8 a |
  % 5
  b4 c d2 |
  % 6
  c2. c4 |
  % 7
  b c d d |
  % 8
  c d e f |
  % 9
  e d c b8 a |
  % 10
  b4 c d2 |
  % 11
  c2. c4 |
  % 12
  d8 e f4 e8 d c4 |
  % 13
  d8 c b4 a b |
  % 14
  g g d' e |
  % 15
  f8 e d4 c g' |
  % 16
  e f8 e d4. c8 |
  % 17
  b4 c d2 |
  % 18
  c1 |
  % 19
  
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
  g4. fis8 g4 gis |
  % 3
  e8 c g'4 g g |
  % 4
  g g8 f e4 f8 e |
  % 5
  d4 g a g8 f |
  % 6
  e2. g4 |
  % 7
  g4. fis8 g4 gis |
  % 8
  e8 c g'4 g g |
  % 9
  g g8 f e4 f8 e |
  % 10
  d4 g a g8 f |
  % 11
  e2. g4 |
  % 12
  g a b a |
  % 13
  a4. g8 fis4 fis |
  % 14
  e e8 fis g4 e |
  % 15
  d e e g |
  % 16
  g f8 g a f g a |
  % 17
  g4 g g4. f8 |
  % 18
  e1 |
  % 19
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. e'4 |
  % 2
  d c b b |
  % 3
  c8 f b,4 c d |
  % 4
  c b c8 e d4 |
  % 5
  g c,2 b4 |
  % 6
  g2. e'4 |
  % 7
  d c b b |
  % 8
  c8 f b,4 c d |
  % 9
  c b c8 e d4 |
  % 10
  g c,2 b4 |
  % 11
  g2. e'4 |
  % 12
  d c b e |
  % 13
  d d d b |
  % 14
  b b8 c d4 a |
  % 15
  a b a d |
  % 16
  c c8 b a4 e' |
  % 17
  d c c b |
  % 18
  g1 |
  % 19
  
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
  s2. c4 |
  % 2
  g' a g8 f e4 |
  % 3
  a g c b |
  % 4
  c g a8 g f2 e4 fis g |
  % 6
  c,2. c4 |
  % 7
  g' a g8 f e4 |
  % 8
  a g c b |
  % 9
  c g a8 g f2 e4 fis g |
  % 11
  c,2. c'4 |
  % 12
  b a gis a8 g |
  % 13
  fis4 g d dis |
  % 14
  e8 fis g a b4 cis |
  % 15
  d g, a b |
  % 16
  c8 b a g f d e f |
  % 17
  g f e c g2 |
  % 18
  c1 |
  % 19
  
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
