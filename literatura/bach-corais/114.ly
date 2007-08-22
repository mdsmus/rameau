% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 114.mid
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
  b4. a8 g4 g |
  % 4
  a a b b |
  % 5
  e,2. a4 |
  % 6
  a b c d |
  % 7
  b4. a8 g4 g |
  % 8
  a a b b |
  % 9
  e,2. e'4 |
  % 10
  d c b a |
  % 11
  b2. b4 |
  % 12
  c d e e |
  % 13
  d2 b4 d |
  % 14
  c b a a |
  % 15
  b4. a8 g4 f |
  % 16
  e a8 b c4 b |
  % 17
  a1 |
  % 18
  
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
  g fis e e |
  % 4
  e d8 e f4 e8 d4 c16 b c2 e4 |
  % 6
  f f g a |
  % 7
  g fis e e |
  % 8
  e d8 e f4 e8 d4 c16 b c2 e8 fis |
  % 10
  gis4 a8 g f4 e8 fis |
  % 11
  gis2. gis4 |
  % 12
  a b c8 b a g |
  % 13
  a g fis4 g f |
  % 14
  e8 a4 g8 g f16 e f4 |
  % 15
  fis8 dis e fis b,4 b |
  % 16
  c c8 d e4 e8 d |
  % 17
  c1 |
  % 18
  
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
  d8 e fis4 b, b |
  % 4
  a a a gis |
  % 5
  a2. c4 |
  % 6
  c d g, d' |
  % 7
  d8 e fis4 b, b |
  % 8
  a a a gis |
  % 9
  a2. g8 a |
  % 10
  b4 e8 c d b c4 |
  % 11
  b2. e4 |
  % 12
  e f g c,8 b |
  % 13
  a4 d d b |
  % 14
  a8 e' e4 e8 d16 cis d8 c |
  % 15
  b a g fis e4 f |
  % 16
  g a a gis |
  % 17
  a1 |
  % 18
  
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
  g dis e e8 d |
  % 4
  c4 f8 e d4 e |
  % 5
  a2. a8 g |
  % 6
  f4 e8 d e4 fis |
  % 7
  g dis e e8 d |
  % 8
  c4 f8 e d4 e |
  % 9
  a2. c,4 |
  % 10
  b8 b' a4 gis a |
  % 11
  e2. e4 |
  % 12
  a g8 f c'4 e, |
  % 13
  fis e8 d g4 gis |
  % 14
  a e f4. e8 |
  % 15
  dis b cis dis e4 d |
  % 16
  c f e8 d e4 |
  % 17
  a,1 |
  % 18
  
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
