% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 084.mid
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
  b b a gis8 fis |
  % 3
  e4 fis8 gis a4 b |
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
  cis4. b8 a2 |
  % 11
  b8 cis d4 cis8 b a gis |
  % 12
  fis4 gis8 a b4. a8 |
  % 13
  gis4 fis e2 |
  % 14
  fis4 gis a2. gis4 a2 |
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
  b cis a d cis4 fis8 e |
  % 4
  e2. a4 |
  % 5
  b8 cis d cis b a gis fis |
  % 6
  gis f cis4 d d |
  % 7
  cis2 e4 e |
  % 8
  e8 fis gis fis f fis4 f8 |
  % 9
  fis4 fis gis8 a b4 |
  % 10
  b a8 g fis2 |
  % 11
  fis8 gis a b a gis fis e |
  % 12
  dis4 e8 fis gis4. fis4 e dis8 b2 |
  % 14
  d4 e e8 cis fis4 |
  % 15
  e2 e |
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
  b8 a gis4 a b8 a |
  % 3
  gis a fis b e, a4 gis8 |
  % 4
  cis2. e4 |
  % 5
  e a, b8 cis d4 |
  % 6
  gis, a a b |
  % 7
  e,2 a4 a |
  % 8
  gis8 a b4 b8 a gis cis |
  % 9
  cis4 cis b8 a4 gis16 fis |
  % 10
  e4 a a2 |
  % 11
  d8 cis4 b8 cis dis e4 |
  % 12
  b b b8 cis16 dis e8 b |
  % 13
  b4. a8 gis2 |
  % 14
  a4 b8 d cis4 c |
  % 15
  b8 a b d cis2 |
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
  gis8 fis e d cis a d4. cis8 d b cis fis d e |
  % 4
  a,2. a'4 |
  % 5
  a8 gis fis4 gis8 a b4 |
  % 6
  f8 cis fis e d cis b4 |
  % 7
  a2 a8 b cis d |
  % 8
  e4. d8 cis2 |
  % 9
  fis4 fis8 e d cis b e |
  % 10
  a, b cis4 d2 |
  % 11
  d8 e fis gis a b cis a |
  % 12
  b a gis fis e dis cis dis |
  % 13
  e gis b b, e2 |
  % 14
  d8 cis d b cis fis e dis |
  % 15
  e4 e, a2 |
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
