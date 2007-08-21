% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 025700b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 90 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. c''4 |
  % 2
  c8 b a b c d e4 |
  % 3
  d d c c |
  % 4
  b a8 b c4 d |
  % 5
  b2 a4 c |
  % 6
  c8 b a b c d e4 |
  % 7
  d d c c |
  % 8
  b a8 b c4 d |
  % 9
  b2 a4 d |
  % 10
  e e b8 c d4 |
  % 11
  c c b c |
  % 12
  d a8 b c4 b |
  % 13
  a a g c |
  % 14
  b a8 b c4 d8 c |
  % 15
  b2 a |
  % 16
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. a''4 |
  % 2
  g f e8 d c4 |
  % 3
  d8 e f4 e fis |
  % 4
  g fis8 gis a4 a8 g |
  % 5
  f4 e8 d c4 a' |
  % 6
  g f e8 d c4 |
  % 7
  d8 e f4 e fis |
  % 8
  g fis8 gis a4 a8 g |
  % 9
  f4 e8 d c4 g' |
  % 10
  g g d4. e8 |
  % 11
  fis gis a4 gis a |
  % 12
  a8 g fis4 e d8 e |
  % 13
  f4 f e a |
  % 14
  g a gis8 b a g |
  % 15
  f4 e8 d cis2 |
  % 16
  
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
  e8 d c4 c8 b a g |
  % 3
  a4 b c c |
  % 4
  d d e a, |
  % 5
  a gis a c |
  % 6
  e8 d c4 c8 b a g |
  % 7
  a4 b c c |
  % 8
  d d e a, |
  % 9
  a gis a g |
  % 10
  c g8 a b4 a8 b |
  % 11
  c d e4 e e |
  % 12
  d d g,8 a b4 |
  % 13
  c8 b c d e4 dis |
  % 14
  d d e a, |
  % 15
  a gis e2 |
  % 16
  
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
  s2. a'4 |
  % 2
  e f8 g a b c4 |
  % 3
  f, g c, a' |
  % 4
  g d' a8 g f e |
  % 5
  d4 e a, a' |
  % 6
  e f8 g a b c4 |
  % 7
  f, g c, a' |
  % 8
  g d' a8 g f e |
  % 9
  d4 e a, b |
  % 10
  c8 d e f g4 fis8 gis |
  % 11
  a b c d e4 a,8 g |
  % 12
  fis e d4 e8 fis g4 |
  % 13
  a8 g a b c4 fis, |
  % 14
  g f e8 c f e |
  % 15
  d b e4 a,2 |
  % 16
  
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
