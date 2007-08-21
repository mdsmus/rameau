% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 028300b_.mid
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
  e''4 e e e |
  % 2
  d c b2 |
  % 3
  a4 gis a b8 c |
  % 4
  d4 c b2 |
  % 5
  a4 b c8 b a4 |
  % 6
  a8 g f4 e2 |
  % 7
  d4 cis d e8 f |
  % 8
  g4 f e2 |
  % 9
  a4 a a g |
  % 10
  f e d2 |
  % 11
  g4 a b c |
  % 12
  d e d c |
  % 13
  b2 a4 b |
  % 14
  c8 b a4 a8 g f4 |
  % 15
  e2 d4 cis |
  % 16
  d e8 f g4 a |
  % 17
  g f e2 |
  % 18
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  gis''8 a b gis a4 a |
  % 2
  a8 e e4 e2 |
  % 3
  c8 d e4. fis8 gis a |
  % 4
  b4. a8 a4 gis |
  % 5
  a8 g f4 g4. f8 |
  % 6
  e4. d8 cis2 |
  % 7
  d8 g, a4 a8 b cis d |
  % 8
  e4. d8 cis2 |
  % 9
  c4 f4. e16 d e4. d4 cis8 d2 |
  % 11
  b8 e4 d8 d4 e |
  % 12
  f8 g4 a g8 g4 |
  % 13
  g2 e8 fis g4 |
  % 14
  g a8 g f e d4 |
  % 15
  d cis d8 a ais g |
  % 16
  a b c d e4 f4. e4 d16 c b2 |
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
  b'4 e8 d c d e c4 b a8 a4 gis |
  % 3
  a b c d8 e |
  % 4
  f e e4 e2 |
  % 5
  c4 d c4. d8 |
  % 6
  a4 a a2 |
  % 7
  f8 d e4 f g8 a |
  % 8
  ais a a4 a2 |
  % 9
  a8 ais c4 c4. ais8 |
  % 10
  a4. a16 g f2 |
  % 11
  g8 c4 d16 c b8 d g, c4 b8 c e f4. e8 |
  % 13
  d2 c4 d |
  % 14
  c4. cis8 d4 a |
  % 15
  a2 a4 g8 e |
  % 16
  f4 g c c16*7 ais16 a8 b16 a gis2 |
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
  e8 fis gis e a b c a |
  % 2
  fis gis a a, e'2 |
  % 3
  f4 e8 d c4 b8 a4 gis8 a c e2 |
  % 5
  f8 e d4 e f |
  % 6
  cis d a2 |
  % 7
  ais4 a8 g f4 e8 d4 cis8 e f a2 |
  % 9
  f8 g a ais c4. cis8 |
  % 10
  d4 a d,2 |
  % 11
  e'4 fis g8 f e4 |
  % 12
  d8 g c,4. b8 c e |
  % 13
  g2 a4 g8 f |
  % 14
  e4 f8 e d e f g |
  % 15
  a2 f4 e |
  % 16
  d c4. ais8 a f |
  % 17
  c'4 d e2 |
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
