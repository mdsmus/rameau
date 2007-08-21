% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 035200b_.mid
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
  e''4 e b c |
  % 2
  d c8 b b4 a |
  % 3
  c c b a |
  % 4
  gis a b2 |
  % 5
  e4 e b c |
  % 6
  d c8 b b4 a |
  % 7
  c c b a |
  % 8
  gis a b2 |
  % 9
  b4 c d8 c b4 |
  % 10
  c b8 a a4 g |
  % 11
  c d e8 d c4 |
  % 12
  f e d c |
  % 13
  b c d e |
  % 14
  d c b2 |
  % 15
  a4 b c8 b d4 |
  % 16
  c b8 a a2 |
  % 17
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  a''8 b c4 b a8 gis |
  % 2
  a b a4. gis8 e4 |
  % 3
  e a8 g f e4 d8 |
  % 4
  d e16 f e8 fis gis2 |
  % 5
  a8 b c4 b a8 gis |
  % 6
  a b a4. gis8 e4 |
  % 7
  e a8 g f e4 d8 |
  % 8
  d e16 f e8 fis gis2 |
  % 9
  gis4 a a g |
  % 10
  g8 fis g4 fis d |
  % 11
  c g' g a8 g |
  % 12
  a b c4 b g |
  % 13
  g f8 e d4 g8 a |
  % 14
  b4 a gis2 |
  % 15
  a8 g f e e f e d |
  % 16
  e16*7 d16 cis2 |
  % 17
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  c'8 b a4 e' e |
  % 2
  d8 b c d e4 c |
  % 3
  c8 b a4. gis8 a4 |
  % 4
  b8 c16 d c8 e16 dis e2 |
  % 5
  c8 b a4 e' e |
  % 6
  d8 b c d e4 c |
  % 7
  c8 b a4. gis8 a4 |
  % 8
  b8 c16 d c8 e16 dis e2 |
  % 9
  e4 e d d |
  % 10
  c8 d e4 d8 c b4 |
  % 11
  e b c8 b a4 |
  % 12
  d g, g'8 f e4 |
  % 13
  d c g'8 f e4 |
  % 14
  f e e2 |
  % 15
  e4 d c8 d gis, a |
  % 16
  a4 gis e2 |
  % 17
  
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
  a4 a' gis fis8 e |
  % 2
  fis gis a4 e a, |
  % 3
  a'8 g f e d e f4 |
  % 4
  b, c8 a e'2 |
  % 5
  a,4 a' gis fis8 e |
  % 6
  fis gis a4 e a, |
  % 7
  a'8 g f e d e f4 |
  % 8
  b, c8 a e'2 |
  % 9
  e4 a8 g fis d g fis |
  % 10
  e4 d8 c d4 g, |
  % 11
  a' g8 f e4 f8 e |
  % 12
  d4 e8 f g4 c, |
  % 13
  g' a b c8 b |
  % 14
  a gis a4 e2 |
  % 15
  c8 b a gis a d e f |
  % 16
  e d e4 a,2 |
  % 17
  
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
