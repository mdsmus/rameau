% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 033100b_.mid
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
  a''4 e a b |
  % 2
  c d b2 |
  % 3
  a c4 b |
  % 4
  a b c d |
  % 5
  e1 |
  % 6
  a,4 e a b |
  % 7
  c d b2 |
  % 8
  a c4 b |
  % 9
  a b c d |
  % 10
  e1 |
  % 11
  e4 f g c, |
  % 12
  f e d2 |
  % 13
  c d4 d |
  % 14
  e a, d c |
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
  e'4 e e d |
  % 2
  e a a gis |
  % 3
  e2 a4 gis |
  % 4
  a e e a |
  % 5
  gis1 |
  % 6
  e4 e e d |
  % 7
  e a a gis |
  % 8
  e2 a4 gis |
  % 9
  a e e a |
  % 10
  gis1 |
  % 11
  a4 a g a |
  % 12
  a8 gis g4 g4. f8 |
  % 13
  e2 g4 g |
  % 14
  g fis8 e fis gis a4 |
  % 15
  a gis e2 |
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
  c'4 c c8 a4 b16 a |
  % 2
  gis4 a e'4. d8 |
  % 3
  c2 e4 d |
  % 4
  e e8 d c b a4 |
  % 5
  b1 |
  % 6
  c4 c c8 a4 b16 a |
  % 7
  gis4 a e'4. d8 |
  % 8
  c2 e4 d |
  % 9
  e e8 d c b a4 |
  % 10
  b1 |
  % 11
  c4 d d8 c c4 |
  % 12
  c8 b c4 c b |
  % 13
  g2 b4 b |
  % 14
  c8 g d'4 d e |
  % 15
  e4. d8 cis2 |
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
  a4 a'8 g fis4 f |
  % 2
  e f8 d e2 |
  % 3
  a, a'4 b |
  % 4
  c gis a8 g f4 |
  % 5
  e1 |
  % 6
  a,4 a'8 g fis4 f |
  % 7
  e f8 d e2 |
  % 8
  a, a'4 b |
  % 9
  c gis a8 g f4 |
  % 10
  e1 |
  % 11
  a4 g8 f e4 f8 e |
  % 12
  d4 e8 f g2 |
  % 13
  c, g'8 f e d |
  % 14
  c e d c b4 a |
  % 15
  e'2 a, |
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
