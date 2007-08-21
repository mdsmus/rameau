% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 043400b_.mid
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
  s2. e'4 |
  % 2
  a b c b |
  % 3
  a b gis4. fis8 |
  % 4
  e4 g g f |
  % 5
  e a a8 b gis4 |
  % 6
  a2. e4 |
  % 7
  a b c b |
  % 8
  a b gis4. fis8 |
  % 9
  e4 g g f |
  % 10
  e a a8 b gis4 |
  % 11
  a2. b4 |
  % 12
  c d e e |
  % 13
  d8 e16 f d4 c e |
  % 14
  d c b a8 b |
  % 15
  c b b4 a2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. c'8 d |
  % 2
  e4 e e8 fis gis4 |
  % 3
  a8 g f4 e2 |
  % 4
  b4 e e d |
  % 5
  d8 cis d dis e fis e4 |
  % 6
  e2. c8 d |
  % 7
  e4 e e8 fis gis4 |
  % 8
  a8 g f4 e2 |
  % 9
  b4 e e d |
  % 10
  d8 cis d dis e fis e4 |
  % 11
  e2. gis4 |
  % 12
  a g g a |
  % 13
  a g8 f e4 e |
  % 14
  fis8 gis a4 g8 f e4 |
  % 15
  fis e8 d cis2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. a'8 b |
  % 2
  c b a gis a4 d, |
  % 3
  e8 e' d c b4. a8 |
  % 4
  gis4 b c d8 c |
  % 5
  b a a b c b4 c16 d |
  % 6
  c2. a8 b |
  % 7
  c b a gis a4 d, |
  % 8
  e8 e' d c b4. a8 |
  % 9
  gis4 b c d8 c |
  % 10
  b a a b c b4 c16 d |
  % 11
  c2. e4 |
  % 12
  e d c c |
  % 13
  c b g a |
  % 14
  a8 e' e dis d4 c8 b |
  % 15
  a4 gis e2. 
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
  c, e a, b |
  % 3
  c d e2 |
  % 4
  e4 e a b8 a |
  % 5
  gis g fis f e dis e4 |
  % 6
  a,2. a'4 |
  % 7
  c, e a, b |
  % 8
  c d e2 |
  % 9
  e4 e a b8 a |
  % 10
  gis g fis f e dis e4 |
  % 11
  a,2. e'4 |
  % 12
  a b c8 b a g |
  % 13
  f d g4 c, cis |
  % 14
  d8 e f fis g gis a4 |
  % 15
  dis, e a,2. 
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
