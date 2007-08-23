% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 300.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  a8 b c4 b e |
  % 3
  d c b c8 b |
  % 4
  a4 e' d e |
  % 5
  a,8 b cis4 d c |
  % 6
  b e d c |
  % 7
  b2. a8 b |
  % 8
  c4 c d d |
  % 9
  e e c e |
  % 10
  d c b a8 b |
  % 11
  c4 b a2 |
  % 12
  
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
  e4. a8 a gis g4 |
  % 3
  f fis b, e |
  % 4
  f g g g |
  % 5
  f e f e |
  % 6
  e e8 fis gis4 a |
  % 7
  gis2. a8 gis |
  % 8
  a4 a8 g f4 ais |
  % 9
  ais a8 g a4 c |
  % 10
  b a8 g fis gis a4 |
  % 11
  a gis e2 |
  % 12
  
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
  e4 a, b ais |
  % 3
  a a gis a |
  % 4
  a c c8 b16 a b8 cis |
  % 5
  d4 a a a |
  % 6
  gis a b c8 d |
  % 7
  e2. e8 d |
  % 8
  c4 dis d g |
  % 9
  g f8 e f4 g |
  % 10
  g8 f e4 d c8 d |
  % 11
  e4. d8 cis2 |
  % 12
  
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
  s2. a8 b |
  % 2
  c4 g e' cis |
  % 3
  d dis e a, |
  % 4
  d c g' e |
  % 5
  f8 g a4 d, a' |
  % 6
  e c b a |
  % 7
  e'2. c'8 b |
  % 8
  a g f4 ais8 a g4 |
  % 9
  c c, f c' |
  % 10
  g a d,8 e f4 |
  % 11
  c8 d e4 a,2 |
  % 12
  
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
