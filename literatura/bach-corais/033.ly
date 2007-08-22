% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 033.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 80 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  a''4 e8 fis gis4 a |
  % 2
  b8 c16 d c8 b b4 a |
  % 3
  c b a b |
  % 4
  c d e2 |
  % 5
  a,4 e8 fis gis4 a |
  % 6
  b8 c16 d c8 b b4 a |
  % 7
  c b a b |
  % 8
  c d e2 |
  % 9
  e4 f g c, |
  % 10
  f e d c |
  % 11
  d d e a, |
  % 12
  d c8 b b2 |
  % 13
  a2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  e'8 d c4 b a |
  % 2
  e' e8 f e4 e |
  % 3
  a8 g f e e a4 gis8 |
  % 4
  a e a b16 a gis2 |
  % 5
  e8 d c4 b a |
  % 6
  e' e8 f e4 e |
  % 7
  a8 g f e e a4 gis8 |
  % 8
  a e a b16 a gis2 |
  % 9
  a4 a g a8 g |
  % 10
  a d g,4. g16 f e4 |
  % 11
  g8 a b4. gis8 a g |
  % 12
  f e e f e4. d8 |
  % 13
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
  c'8 b a4 e8 e' d c |
  % 2
  b gis a4. gis8 c4 |
  % 3
  e d c f,8 e |
  % 4
  e a4 gis16 a b2 |
  % 5
  c8 b a4 e8 e' d c |
  % 6
  b gis a4. gis8 c4 |
  % 7
  e d c f,8 e |
  % 8
  e a4 gis16 a b2 |
  % 9
  c4 d4. c8 c4 |
  % 10
  c8 b c4. b8 g4 |
  % 11
  b8 d g f e4. d8 |
  % 12
  c b a4 a gis |
  % 13
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
  a8 b c d e4 fis |
  % 2
  gis8 e a d, e e, a4 |
  % 3
  a8 a'4 gis8 a f d e |
  % 4
  a, g f4 e2 |
  % 5
  a8 b c d e4 fis |
  % 6
  gis8 e a d, e e, a4 |
  % 7
  a8 a'4 gis8 a f d e |
  % 8
  a, g f4 e2 |
  % 9
  a8 a' g f e4 f8 e |
  % 10
  d4 e8 f g g, c4 |
  % 11
  g'8 f e d c d c b |
  % 12
  a gis a d e4 e, |
  % 13
  a2. 
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
