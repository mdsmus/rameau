% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 001606b_.mid
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
  a b c d |
  % 3
  b4. c8 d4 e |
  % 4
  c a b b |
  % 5
  a2. a4 |
  % 6
  a b c d |
  % 7
  b4. c8 d4 e |
  % 8
  c a b b |
  % 9
  a2. e'4 |
  % 10
  d c b a |
  % 11
  b2. b4 |
  % 12
  c d e e |
  % 13
  d2 b4 b |
  % 14
  c d e e |
  % 15
  d4. c8 b4 e |
  % 16
  d8 c b a b4 b |
  % 17
  a2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. e'4 |
  % 2
  f f g a |
  % 3
  g2 a4 e |
  % 4
  e a a gis |
  % 5
  e2. e4 |
  % 6
  f f g a |
  % 7
  g2 a4 e |
  % 8
  e a a gis |
  % 9
  e2. e8 fis |
  % 10
  gis4 a8 g f4 e8 fis |
  % 11
  gis2. gis4 |
  % 12
  a b c8 b a g |
  % 13
  a g fis4 g g |
  % 14
  g g8 f e f g4 |
  % 15
  f8 g a4 gis b |
  % 16
  a e f e8 d |
  % 17
  cis2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. c'4 |
  % 2
  c d g, d' |
  % 3
  d e d b |
  % 4
  c8 d e4 f e8 d |
  % 5
  c2. c4 |
  % 6
  c d g, d' |
  % 7
  d e d b |
  % 8
  c8 d e4 f e8 d |
  % 9
  c2. g8 a |
  % 10
  b4 e8 c d b c4 |
  % 11
  b2. e4 |
  % 12
  e f g c,8 b |
  % 13
  a4 d d d |
  % 14
  g, a ais a8 g |
  % 15
  a2 e'4 e |
  % 16
  e, a a gis |
  % 17
  e2. 
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
  s2. a'8 g |
  % 2
  f4 e8 d e4 fis |
  % 3
  g fis8 e fis4 gis |
  % 4
  a8 b c a d,4 e |
  % 5
  a,2. a'8 g |
  % 6
  f4 e8 d e4 fis |
  % 7
  g fis8 e fis4 gis |
  % 8
  a8 b c a d,4 e |
  % 9
  a,2. c'4 |
  % 10
  b a gis a |
  % 11
  e2. e4 |
  % 12
  a g8 f c'4 e, |
  % 13
  fis e8 d g4 g8 f |
  % 14
  e4 d cis d8 e |
  % 15
  f4 e8 d e4 gis |
  % 16
  a c, d e |
  % 17
  a,2. 
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
