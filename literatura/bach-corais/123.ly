% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 123.mid
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
  b8 c4 b16 c d4 e |
  % 4
  d8 c b a c4 b8 a |
  % 5
  a2. a4 |
  % 6
  a b c d |
  % 7
  b8 c4 b16 c d4 e |
  % 8
  d8 c b a c4 b8 a |
  % 9
  a2. e'4 |
  % 10
  d c b a |
  % 11
  b2. b4 |
  % 12
  c d e e |
  % 13
  d8 c b c b4 b |
  % 14
  c d e e |
  % 15
  d8 c b c b4 e |
  % 16
  d8 c b a c4 b8 a |
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
  s2. e'8 d |
  % 2
  e f e d c e a fis |
  % 3
  d g e a gis4 b8 gis |
  % 4
  e4. a8 a b gis4 |
  % 5
  e2. e8 d |
  % 6
  e f e d c e a fis |
  % 7
  d g e a gis4 b8 gis |
  % 8
  e4. a8 a b gis4 |
  % 9
  e2. a8 g |
  % 10
  fis gis a4 a8 gis a d |
  % 11
  gis,2. gis4 |
  % 12
  a g g c8 b |
  % 13
  a g fis4 g b |
  % 14
  a g g g |
  % 15
  fis8 gis a4 gis c8 b |
  % 16
  a4 gis8 a a fis gis4 |
  % 17
  e1 |
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
  s2. c'8 b |
  % 2
  c d c b a c b a |
  % 3
  b e c f e d b4 |
  % 4
  a8 b c d e f b, d |
  % 5
  c2. c8 b |
  % 6
  c d c b a c b a |
  % 7
  b e c f e d b4 |
  % 8
  a8 b c d e f b, d |
  % 9
  c2. c4 |
  % 10
  c8 b e f b, e e a, |
  % 11
  e'2. e4 |
  % 12
  e d c8 d e4 |
  % 13
  a, d d e |
  % 14
  e b c b |
  % 15
  a8 e' d a e'4 a, |
  % 16
  d8 e f d e4 d8 cis |
  % 17
  cis1 |
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
  s2. a4 |
  % 2
  a' gis a fis |
  % 3
  g8 a4 g16 a b4 gis |
  % 4
  a f e8 d e4 |
  % 5
  a,2. a4 |
  % 6
  a' gis a fis |
  % 7
  g8 a4 g16 a b4 gis |
  % 8
  a f e8 d e4 |
  % 9
  a,2. a4 |
  % 10
  b c8 d e4 f |
  % 11
  e2. e4 |
  % 12
  a8 b c b c b a g |
  % 13
  fis e d4 g gis |
  % 14
  a8 g f g f e d c |
  % 15
  d e f d e4 c |
  % 16
  f8 e d f e d e4 |
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
