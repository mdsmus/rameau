% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 036.mid
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
  b b a fis |
  % 3
  e fis8 gis a4 b |
  % 4
  a2. cis8 d |
  % 5
  e4 fis e cis |
  % 6
  a fis8 gis a4 b |
  % 7
  a2 cis4 cis |
  % 8
  cis b cis2 |
  % 9
  a s4 a |
  % 10
  b b cis2 |
  % 11
  a b |
  % 12
  cis8 b a gis fis4 b |
  % 13
  b a8 gis fis2 |
  % 14
  e fis4 gis |
  % 15
  a b a2 |
  % 16
  
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
  e e e d8 cis |
  % 3
  b4 cis8 d e4 e |
  % 4
  e2. a4 |
  % 5
  b8 cis d cis b4 a |
  % 6
  a d, cis fis8 e |
  % 7
  cis2 a'4 b |
  % 8
  a8 gis fis4 fis f |
  % 9
  cis2 s4 fis |
  % 10
  gis gis a8 fis g4 |
  % 11
  fis2 fis4 gis |
  % 12
  a8 gis fis e d4 d |
  % 13
  cis8 gis' fis e e4 dis |
  % 14
  b2 d4 d |
  % 15
  e e8 d cis2 |
  % 16
  
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
  b8 a gis4 a a |
  % 3
  gis a8 b e, a4 gis8 |
  % 4
  cis2. e2 a,4 b cis8 d |
  % 6
  e4 a, a4. gis8 |
  % 7
  e2 e'4 gis |
  % 8
  fis fis,8 gis a4 gis |
  % 9
  fis2 s4 cis' |
  % 10
  e e e2 |
  % 11
  d d8 cis b4 |
  % 12
  a8 cis d e a,4 gis8 fis |
  % 13
  e4 fis8 gis cis4 b8 a |
  % 14
  gis2 a4 b |
  % 15
  e,8 a4 gis8 e2 |
  % 16
  
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
  gis8 fis e d cis4 d2 cis8 b cis a e'4 |
  % 4
  a,2. a'4 |
  % 5
  gis fis gis a |
  % 6
  cis, d8 e fis a d, e |
  % 7
  a,2 a'8 gis fis f |
  % 8
  fis e d4 cis2 |
  % 9
  fis s4 fis |
  % 10
  e8 d cis b a2 |
  % 11
  d b4 e |
  % 12
  a, b8 cis d4 b |
  % 13
  cis dis8 e a,4 b |
  % 14
  e2 d4 cis8 b |
  % 15
  cis a e4 a2 |
  % 16
  
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
