% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 001707b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key a \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2 a''4 a2 gis4 fis2 |
  % 3
  e4 a b2 |
  % 4
  cis cis4 cis |
  % 5
  b cis cis2 |
  % 6
  b4 a b2 |
  % 7
  a a4 a2 gis4 fis2 |
  % 9
  e4 a b2 |
  % 10
  cis cis4 cis |
  % 11
  b cis cis2 |
  % 12
  b4 a b2 |
  % 13
  a a4 a |
  % 14
  b cis b2 |
  % 15
  cis4 a gis2 |
  % 16
  fis b4 b |
  % 17
  a gis a fis2 e e4 |
  % 19
  a2 a4 b2 b4 cis4. b8 |
  % 21
  cis4 a2 a4 |
  % 22
  d2 d4 cis |
  % 23
  b cis b2 |
  % 24
  b4 cis2 cis4 |
  % 25
  d2 d4 e2. a,2 |
  % 27
  cis4 b a gis |
  % 28
  a fis2 e e4 a2 |
  % 30
  gis4 fis2 e4 |
  % 31
  b' cis2 b cis4 d2 |
  % 33
  cis4 b a8 gis a b |
  % 34
  cis4 b2 a 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2 e'4 fis2 e4 d cis |
  % 3
  b e fis e |
  % 4
  e2 e8 fis gis2 f4 fis2 |
  % 6
  gis4 a2 gis4 |
  % 7
  e2 e4 fis2 e4 d cis |
  % 9
  b e fis e |
  % 10
  e2 e8 fis gis2 f4 fis2 |
  % 12
  gis4 a2 gis4 |
  % 13
  e2 e4 fis |
  % 14
  gis a b a |
  % 15
  gis fis2 f4 |
  % 16
  cis2 fis4 e2 e4 e2 |
  % 18
  dis4 b2 cis4 |
  % 19
  cis2 fis4 e |
  % 20
  fis gis a2 |
  % 21
  g4 fis2 a4 |
  % 22
  b2 b8 a g ais |
  % 23
  b4 e, dis2 |
  % 24
  e4 e2 fis4 |
  % 25
  fis2 g4 g |
  % 26
  fis e d2 |
  % 27
  e4 fis2 e4 |
  % 28
  e2 dis4 b2 cis4 cis dis |
  % 30
  e dis2 e4 |
  % 31
  fis4. gis8 a4 e2 gis4 a b |
  % 33
  a gis a2 |
  % 34
  a4 gis2 e 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2 cis'4 cis2 cis4 a2 |
  % 3
  gis4 a2 gis4 |
  % 4
  a2 cis4 cis2 b4 a2 |
  % 6
  e'4 e fis e |
  % 7
  cis2 cis4 cis2 cis4 a2 |
  % 9
  gis4 a2 gis4 |
  % 10
  a2 cis4 cis2 b4 a2 |
  % 12
  e'4 e fis e |
  % 13
  cis2 cis4 d2 e4 f fis |
  % 15
  gis cis, d cis |
  % 16
  a2 a4 gis |
  % 17
  a b cis2 |
  % 18
  b8 a gis2 gis4 |
  % 19
  a2 d4 b2 e4 e2. d2 e4 |
  % 22
  fis2 b,4 e |
  % 23
  d8 cis b ais b2 |
  % 24
  gis4 a2 a4 |
  % 25
  b2 b4 b |
  % 26
  a g fis2 |
  % 27
  a4 fis2 b4 |
  % 28
  cis b a gis2 gis4 a2 |
  % 30
  b4 b a gis |
  % 31
  d' a2 gis cis4 fis e |
  % 33
  e e8 d cis4 fis |
  % 34
  e2 d4 cis2 
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
  s2 a'4 fis2 cis4 d2 |
  % 3
  d4 cis d e |
  % 4
  a,2 a'4 f2 cis4 fis e |
  % 6
  d cis d e |
  % 7
  a,2 a'4 fis2 cis4 d2 |
  % 9
  d4 cis d e |
  % 10
  a,2 a'4 f2 cis4 fis e |
  % 12
  d cis d e |
  % 13
  a,2 a4 d2 a'4 gis fis |
  % 15
  f fis b, cis |
  % 16
  fis,2 dis'4 e2 d4 cis a |
  % 18
  b e2 cis4 |
  % 19
  fis e fis gis |
  % 20
  fis e a2 |
  % 21
  a,4 d2 cis4 |
  % 22
  b b'8 a g fis e fis |
  % 23
  g4 fis b,2 |
  % 24
  e4 a gis fis |
  % 25
  b a g cis,2. d2 |
  % 27
  a'4 dis,2 e4 |
  % 28
  a, b2 e cis4 fis2 |
  % 30
  e4 b2 cis4 |
  % 31
  d2 dis4 e2 f4 fis gis |
  % 33
  a e fis d |
  % 34
  e2. a,2 
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
