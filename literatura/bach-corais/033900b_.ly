% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 033900b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s4 a'' gis a |
  % 2
  b b a b |
  % 3
  cis2 s4 d |
  % 4
  cis b a gis8 a |
  % 5
  b2 a |
  % 6
  s4 a gis a |
  % 7
  b b a b |
  % 8
  cis2 s4 d |
  % 9
  cis b a gis8 a |
  % 10
  b2 a |
  % 11
  s4 a b8 cis d4 |
  % 12
  cis8 b a4 b8 a gis4 |
  % 13
  fis2 s4 gis |
  % 14
  e e b' cis |
  % 15
  d8 cis b4 a2 |
  % 16
  s4 e' cis cis |
  % 17
  b a gis a |
  % 18
  b2 a |
  % 19
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s4 e' d e |
  % 2
  fis cis cis fis |
  % 3
  f2 s4 fis |
  % 4
  e8 cis dis f fis4 e |
  % 5
  fis e8 d cis2 |
  % 6
  s4 e d e |
  % 7
  fis cis cis fis |
  % 8
  f2 s4 fis |
  % 9
  e8 cis dis f fis4 e |
  % 10
  fis e8 d cis2 |
  % 11
  s4 e fis f8 fis |
  % 12
  gis4 cis, fis4. f8 |
  % 13
  cis2 s4 dis |
  % 14
  e8 d4 cis8 dis e e4 |
  % 15
  d8 fis g2 fis4 |
  % 16
  s4 b4. a16 gis a4. gis16 fis e4 e e |
  % 18
  e4. d8 cis2 |
  % 19
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s4 cis' b a2 gis4 a gis8 fis |
  % 3
  gis2 s4 a |
  % 4
  a b cis b8 a |
  % 5
  a4 gis e2 |
  % 6
  s4 cis' b a2 gis4 a gis8 fis |
  % 8
  gis2 s4 a |
  % 9
  a b cis b8 a |
  % 10
  a4 gis e2 |
  % 11
  s4 cis' d8 cis b a |
  % 12
  gis4 a8 gis fis4 cis'8 b |
  % 13
  a2 s4 gis |
  % 14
  gis a fis8 gis g fis |
  % 15
  fis d d'4 d2 |
  % 16
  s4 e e cis8 d16 e |
  % 17
  fis8 e a,4 d8 b a2 gis4 e2 |
  % 19
  
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
  s4 a b cis |
  % 2
  dis f fis8 e d4 |
  % 3
  cis2 s4 fis8 gis |
  % 4
  a4. gis8 fis e d cis |
  % 5
  d b e4 a,2 |
  % 6
  s4 a b cis |
  % 7
  dis f fis8 e d4 |
  % 8
  cis2 s4 fis8 gis |
  % 9
  a4. gis8 fis e d cis |
  % 10
  d b e4 a,2 |
  % 11
  s4 a'2 gis8 fis |
  % 12
  f4 fis8 e d b cis4 |
  % 13
  fis,2 s4 c' |
  % 14
  cis8 b a4. gis8 ais4 |
  % 15
  b4. cis8 d2 |
  % 16
  s4 gis, a8 cis fis e |
  % 17
  d4. cis8 b e cis a |
  % 18
  e'4 e, a2 |
  % 19
  
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
