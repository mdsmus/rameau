% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 039000b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key c \major
  
  \tempo 4 = 110 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2 c''4 c2 b4 a2 |
  % 3
  g4 c d2 |
  % 4
  e e4 e2 e4 e2 |
  % 6
  d4 c8 d d4. c8 |
  % 7
  c2 c4 c2 b4 a2 |
  % 9
  g4 c d2 |
  % 10
  e e4 e2 e4 e2 |
  % 12
  d4 c8 d d4. c8 |
  % 13
  c2 c4 c |
  % 14
  d e d2 |
  % 15
  e4 c b8 a b4 |
  % 16
  a2 a4 d |
  % 17
  c b c a2 g g4 |
  % 19
  c2 c4 d |
  % 20
  e f e d |
  % 21
  e c2 c4 |
  % 22
  f2 f4 e |
  % 23
  d e d2 |
  % 24
  d4 e2 e4 |
  % 25
  f2 f4 g4. f8 e d c2 |
  % 27
  e4 d c b |
  % 28
  c a2 g g4 c2 |
  % 30
  b4 a2 g4 |
  % 31
  d' e4. d8 d2 e4 f e |
  % 33
  d c8 d d4. c8 |
  % 34
  c2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2 g''4 a2 g4 c, d |
  % 3
  e8 f g4 a g |
  % 4
  g2 g4 b |
  % 5
  a gis a e8 f |
  % 6
  g4 g a g |
  % 7
  e2 g4 a2 g4 c, d |
  % 9
  e8 f g4 a g |
  % 10
  g2 g4 b |
  % 11
  a gis a e8 f |
  % 12
  g4 g a g |
  % 13
  e2 e4 f2 e4 gis a |
  % 15
  b a2 gis4 |
  % 16
  a2 f8 e d2 d4 e d |
  % 18
  c b2 e4 |
  % 19
  d2 a'4 g2 g4 g f |
  % 21
  e e2 a4 |
  % 22
  a2 a4 ais |
  % 23
  f g f2 |
  % 24
  g4 g2 a4 |
  % 25
  f a2 g2. a2 |
  % 27
  g4 a2 g4 |
  % 28
  g2 fis4 d2 d4 e f |
  % 30
  g c, d e |
  % 31
  f e8 d e fis g2 g4 f g2 g4 a g |
  % 34
  e2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2 e'4 e |
  % 2
  f g f2 |
  % 3
  e4 c2 b4 |
  % 4
  c2 c4 b |
  % 5
  c d c2 |
  % 6
  b4 c2 b4 |
  % 7
  g2 e'4 e |
  % 8
  f g f2 |
  % 9
  e4 c2 b4 |
  % 10
  c2 c4 b |
  % 11
  c d c2 |
  % 12
  b4 c2 b4 |
  % 13
  g2 g4 a |
  % 14
  b c d8 e f4 |
  % 15
  e e2 d4 |
  % 16
  c2 c4 a2 g4 g fis2 g b4 |
  % 19
  c d e d |
  % 20
  c b c2 |
  % 21
  b4 c2 f4 |
  % 22
  a,2 d4 d2 cis4 a2 |
  % 24
  b4 c2 c4 |
  % 25
  a2 d4 d |
  % 26
  b c c2 |
  % 27
  c8 b a2 d4 |
  % 28
  c e d8 c b2 b4 g d' |
  % 30
  d a b c |
  % 31
  b c a b2 c4 c2 |
  % 33
  b4 c2 b4 |
  % 34
  g2. 
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
  s2 c'4 a2 e4 f2 |
  % 3
  c4 e f g |
  % 4
  c,2 c'4 gis |
  % 5
  fis e a g |
  % 6
  f e f g |
  % 7
  c,2 c'4 a2 e4 f2 |
  % 9
  c4 e f g |
  % 10
  c,2 c'4 gis |
  % 11
  fis e a g |
  % 12
  f e f g |
  % 13
  c,2 c4 f2 c'4 b a |
  % 15
  gis a e2 |
  % 16
  f f4 fis2 g4 c, d2 g, e'4 |
  % 19
  a b c b |
  % 20
  a g c2 |
  % 21
  gis4 a2 f4 |
  % 22
  d e f g |
  % 23
  a2 d, |
  % 24
  g4 c, b a |
  % 25
  d c b e |
  % 26
  d c f2 |
  % 27
  c'4 fis,2 g4 |
  % 28
  e c d g,2 g'8 f e4 d |
  % 30
  c f2 e4 |
  % 31
  d c2 g' c4 a g |
  % 33
  f e f g |
  % 34
  c,2. 
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
