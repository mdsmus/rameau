% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 088.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 84 
  
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
  c d e c |
  % 13
  d4. c8 b4 b |
  % 14
  c d e c |
  % 15
  d4. c8 b4 e |
  % 16
  c8 b a4 b b |
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
  e e e d |
  % 3
  d g8 fis g4 e |
  % 4
  e a a gis |
  % 5
  e2. e4 |
  % 6
  e e e d |
  % 7
  d g8 fis g4 e |
  % 8
  e a2 gis4 |
  % 9
  e2. a4 |
  % 10
  a8 gis a4 a8 gis a a, |
  % 11
  e'2. gis4 |
  % 12
  a g g a |
  % 13
  a g8 fis g4 g |
  % 14
  g f e a |
  % 15
  a8 g fis e d4 e |
  % 16
  e a a gis |
  % 17
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
  s2. c'4 |
  % 2
  c b a a |
  % 3
  g8 fis g a b4 b |
  % 4
  a8 b c4 f e8 d |
  % 5
  c2. c4 |
  % 6
  c b a a |
  % 7
  g8 fis g a b4 b |
  % 8
  a8 b c4 f e8 d |
  % 9
  c2. c4 |
  % 10
  d e f8 e e d |
  % 11
  gis,2. e'4 |
  % 12
  e d c8 d e4 |
  % 13
  a, d d d |
  % 14
  g, a8 b c d e4 |
  % 15
  d a b b |
  % 16
  a8 b c4 f e8 d |
  % 17
  cis2. 
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
  g2 g,4 gis' |
  % 4
  a8 g f e d4 e |
  % 5
  a2. a,4 |
  % 6
  a' gis a fis |
  % 7
  g2 g,4 gis' |
  % 8
  a8 g f e d4 e |
  % 9
  a2. a,4 |
  % 10
  b c d8 e f4 |
  % 11
  e2. e4 |
  % 12
  a b c8 b a g |
  % 13
  fis e d4 g f |
  % 14
  e d c b8 a |
  % 15
  b c d4 g, gis' |
  % 16
  a8 g f e d4 e |
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
