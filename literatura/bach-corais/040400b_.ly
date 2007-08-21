% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 040400b_.mid
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
  s2. e''4 |
  % 2
  c8 b c4 b gis |
  % 3
  a a gis e' |
  % 4
  e e f e8 d |
  % 5
  d2 c |
  % 6
  b4 c d e |
  % 7
  d c b2 |
  % 8
  a4 b c d8 c |
  % 9
  b2 a |
  % 10
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. gis''4 |
  % 2
  e e8 dis e4 e |
  % 3
  e d e gis |
  % 4
  a b a g |
  % 5
  a g8 f e2 |
  % 6
  g4 f8 e d d' c4 |
  % 7
  b a gis2 |
  % 8
  e4 e e a8 g |
  % 9
  f4 e8 d c2 |
  % 10
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. b'4 |
  % 2
  a8 gis fis4 gis b |
  % 3
  c b8 a b4 b |
  % 4
  c b c8 d e c |
  % 5
  c4 b c2 |
  % 6
  d4 c g' g,8 a |
  % 7
  b e, e'4 e2 |
  % 8
  e8 d4 c b8 a4 |
  % 9
  a gis e2 |
  % 10
  
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
  a a, e' d |
  % 3
  c f e e |
  % 4
  a gis a8 b c4 |
  % 5
  fis, g c,2 |
  % 6
  g4 a b c |
  % 7
  gis' a e2 |
  % 8
  fis4 gis a8 g f e |
  % 9
  d4 e a,2 |
  % 10
  
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
