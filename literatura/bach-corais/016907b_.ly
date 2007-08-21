% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 016907b_.mid
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
  s2. a''4 |
  % 2
  b b a4. gis8 |
  % 3
  fis4 e fis gis |
  % 4
  a2. cis8 d |
  % 5
  e4 fis e4. d8 |
  % 6
  cis b a gis fis4 gis |
  % 7
  a2 cis4 cis |
  % 8
  cis b cis2 |
  % 9
  a4 a b8 cis d4 |
  % 10
  cis8 b cis4 a2 |
  % 11
  b8 cis d4 cis8 b a gis |
  % 12
  fis4 e a8 b cis4 |
  % 13
  b4. a8 gis4 fis |
  % 14
  e2 fis4 gis |
  % 15
  a2 b |
  % 16
  a1 |
  % 17
  
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
  e e e e |
  % 3
  d e d8 fis e4 |
  % 4
  e2. a4 |
  % 5
  a a b8 a gis4 |
  % 6
  a e d8 cis b4 |
  % 7
  cis2 e8 fis gis4 |
  % 8
  gis8 fis f fis f fis4 f8 |
  % 9
  fis4 fis gis8 fis e4 |
  % 10
  e2 d |
  % 11
  b'8 a gis4 a e |
  % 12
  d8 cis b4 a8 e' e4 |
  % 13
  fis8*5 e4 dis8 |
  % 14
  b2 d4. d8 |
  % 15
  cis d e4 fis e8 d |
  % 16
  cis1 |
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
  s2. cis'4 |
  % 2
  b8 a gis4 a8 b cis4 |
  % 3
  a a a8 d cis b |
  % 4
  cis2. e4 |
  % 5
  e d8 cis b4 e |
  % 6
  e8 d cis b a4 e |
  % 7
  e2 a4 gis |
  % 8
  a b b8 a gis cis |
  % 9
  cis4 d d8 cis b4 |
  % 10
  a8 g fis e fis2 |
  % 11
  e4 b' a2. gis8 fis e gis a gis |
  % 13
  fis4 b b cis8 b |
  % 14
  gis2 b4 b |
  % 15
  a2. gis4 |
  % 16
  e1 |
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
  s2. a'4 |
  % 2
  gis8 fis e d cis b a4 |
  % 3
  d cis b e |
  % 4
  a,2. a'8 b |
  % 5
  cis4 d gis, e |
  % 6
  a cis, d e |
  % 7
  a,2 a'4 f |
  % 8
  fis d cis2 |
  % 9
  fis4 d8 cis b a gis4 |
  % 10
  a2 d |
  % 11
  gis4 fis8 e a4 cis, |
  % 12
  d2. cis4 |
  % 13
  dis8 b cis dis e gis, a b |
  % 14
  e,2 b'4 f |
  % 15
  fis cis' d e |
  % 16
  a,1 |
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
