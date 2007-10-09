% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 345.mid
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
  s2. e'4 |
  % 2
  a g f e |
  % 3
  d2 e4 b' |
  % 4
  c c b8 c16 d b4 |
  % 5
  a2. e4 |
  % 6
  a g f e |
  % 7
  d2 e4 b' |
  % 8
  c c b8 c16 d b4 |
  % 9
  a2. c4 |
  % 10
  b8 a g4 a b |
  % 11
  c2 c4 g |
  % 12
  a g f8 e f4 |
  % 13
  e2. c'4 |
  % 14
  b8 c d4 c b |
  % 15
  a2 b4 e, |
  % 16
  f e d g8 f |
  % 17
  e1 |
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
  c d d e e d d c |
  % 3
  c4 b8 a b4 e |
  % 4
  e a a gis |
  % 5
  e2. e8 d |
  % 6
  c d d e e d d c |
  % 7
  c4 b8 a b4 e |
  % 8
  e a a gis |
  % 9
  e2. a8 g |
  % 10
  f4 e8 d c4 f |
  % 11
  f e8 d e4 e |
  % 12
  f ais,8 a a g a d |
  % 13
  cis2. d4 |
  % 14
  d g g8 fis g4 |
  % 15
  g fis g g |
  % 16
  c,8 d c4 f, d' |
  % 17
  d c b2 |
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
  s2. gis'4 |
  % 2
  a b c8 d g,4 |
  % 3
  a8 gis a4 gis gis |
  % 4
  a8 b c4 f e8 d |
  % 5
  c2. gis4 |
  % 6
  a b c8 d g,4 |
  % 7
  a8 gis a4 gis gis |
  % 8
  a8 b c4 f e8 d |
  % 9
  c2. e4 |
  % 10
  d8 c b4 a8 g f g |
  % 11
  a4 g8 f g4 c |
  % 12
  c8 d e4 d8 cis d gis, |
  % 13
  a2. a4 |
  % 14
  g8 a b4 c8 d e4 |
  % 15
  e d d c |
  % 16
  c8 b b a a4 g8 a |
  % 17
  b4 a gis2 |
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
  s2. e4 |
  % 2
  f g a8 b c4 |
  % 3
  f,2 e4 e |
  % 4
  a8 g f e d b e4 |
  % 5
  a,2. e'4 |
  % 6
  f g a8 b c4 |
  % 7
  f,2 e4 e |
  % 8
  a8 g f e d b e4 |
  % 9
  a,2. a'4 |
  % 10
  d, e f8 e d4 |
  % 11
  a8 b c4 c c |
  % 12
  f8 e d cis d4 d |
  % 13
  a2. fis'4 |
  % 14
  g g8 fis e4. d8 |
  % 15
  c a d4 g, c8 b |
  % 16
  a b c4. b4 a8 |
  % 17
  gis4 a e'2 |
  % 18
  
}

trackE = <<

  \clef bass
  
  \context Voice = channelA \trackEchannelA
  \context Voice = channelB \trackEchannelB
>>


trackFchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 5
  
}

trackFchannelB = \relative c {
  s2. e4 |
  % 2
  f g a,8 b c4 |
  % 3
  f,2 e4 e' |
  % 4
  a8 g f e d b e e, |
  % 5
  a2. e'4 |
  % 6
  f g a,8 b c4 |
  % 7
  f,2 e4 e' |
  % 8
  a8 g f e d b e e, |
  % 9
  a2. a'4 |
  % 10
  d, e f8 e d4 |
  % 11
  a8 b c4 c, c' |
  % 12
  f8 e d cis d4 d, |
  % 13
  a'2. fis4 |
  % 14
  g g'8 fis e4. d8 |
  % 15
  c a d4 g, c8 b |
  % 16
  a b c4. b4 a8 |
  % 17
  gis4 a e2 |
  % 18
  
}

trackF = <<

  \clef bass
  
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
    \context Staff=trackF \trackF
  >>
}
