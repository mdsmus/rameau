% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 370.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  a a e' d |
  % 3
  e c b a8 b |
  % 4
  c4 b c8 d e4 |
  % 5
  d c b c8 b |
  % 6
  a4 a d8 c b c |
  % 7
  a2 g4 g |
  % 8
  c b c8 d e4 |
  % 9
  d c b a8 b |
  % 10
  c4 b c8 d e4 |
  % 11
  d c b e |
  % 12
  e e d8 c b c |
  % 13
  b gis a b b2 |
  % 14
  a1 |
  % 15
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. e'8 f |
  % 2
  e4 e8 d e4 f |
  % 3
  e e e e |
  % 4
  a gis a g8 a |
  % 5
  b4 a gis a |
  % 6
  d,8 e fis4 fis g |
  % 7
  g fis d e8 f |
  % 8
  g4 d e8 f g4 |
  % 9
  gis a gis e |
  % 10
  d d e8 f g4 |
  % 11
  f8 e e4 e gis |
  % 12
  a g f4. e8 |
  % 13
  f4 e8 f e f e d |
  % 14
  cis1 |
  % 15
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. c'8 d |
  % 2
  c b a4 a8 c b a |
  % 3
  b4 a gis a |
  % 4
  e' e e e |
  % 5
  e e e e |
  % 6
  a, d d e |
  % 7
  d8 c16 b c4 b c |
  % 8
  g8 a b a g4 c |
  % 9
  d e e c8 b |
  % 10
  a4 b8 a g4 c |
  % 11
  c8 b b a gis4 b |
  % 12
  c cis d4. e8 |
  % 13
  d4 c8 a gis a4 gis8 |
  % 14
  e1 |
  % 15
  
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
  s2. a4 |
  % 2
  a' f c d |
  % 3
  gis, a e' c8 b |
  % 4
  a4 e' a8 b c4 |
  % 5
  gis a e a8 g |
  % 6
  fis e d c b4 e8 c |
  % 7
  d2 g,4 c8 d |
  % 8
  e f g f e4 d8 c |
  % 9
  b4 a e' a8 g |
  % 10
  fis d g f e d c b |
  % 11
  a gis a4 e' e |
  % 12
  a8 g f e f e d c |
  % 13
  d b c d e d e4 |
  % 14
  a,1 |
  % 15
  
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
