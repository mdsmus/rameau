% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 175.mid
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
  g''4 e a b |
  % 2
  c c b2 |
  % 3
  a8 b c4 g e |
  % 4
  f e d2 |
  % 5
  c1 |
  % 6
  g'4 e a b |
  % 7
  c c b2 |
  % 8
  a8 b c4 g e |
  % 9
  f e d2 |
  % 10
  c1 |
  % 11
  e4 fis gis a |
  % 12
  b b a2 |
  % 13
  b4 c d e |
  % 14
  d4. c8 c2 |
  % 15
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  e'4 c8 d e4 e |
  % 2
  e a2 gis4 |
  % 3
  a g8 e d4. g,8 |
  % 4
  c d4 c8 c4 b |
  % 5
  g1 |
  % 6
  e'4 c8 d e4 e |
  % 7
  e a2 gis4 |
  % 8
  a g8 e d4. g,8 |
  % 9
  c d4 c8 c4 b |
  % 10
  g1 |
  % 11
  c4 d4. f8 e c |
  % 12
  f d b e16 d c2 |
  % 13
  g'4 g g g |
  % 14
  a8 f d g16 f e2 |
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
  c'4 g c b |
  % 2
  a e' e2 |
  % 3
  c4. g4 b8 g e |
  % 4
  a g g4 a g8 f |
  % 5
  e1 |
  % 6
  c'4 g c b |
  % 7
  a e' e2 |
  % 8
  c4. g4 b8 g e |
  % 9
  a g g4 a g8 f |
  % 10
  e1 |
  % 11
  g4 a b8 d c a |
  % 12
  a4. gis8 a2 |
  % 13
  d4 e d c |
  % 14
  c b g2 |
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
  c4 c8 b a4 gis |
  % 2
  a8 b c d e2 |
  % 3
  f4 e b8 g c4 |
  % 4
  a8 b c4 f, g |
  % 5
  c,1 |
  % 6
  c'4 c8 b a4 gis |
  % 7
  a8 b c d e2 |
  % 8
  f4 e b8 g c4 |
  % 9
  a8 b c4 f, g |
  % 10
  c,1 |
  % 11
  c'8 c, c'4 b c8 f |
  % 12
  d b e4 a,2 |
  % 13
  g'8 f e d c b c e |
  % 14
  f d g4 c,2 |
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
