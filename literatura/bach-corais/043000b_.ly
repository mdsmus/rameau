% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 043000b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \major
  
  \tempo 4 = 92 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  e fis gis a |
  % 3
  b cis a cis8 d |
  % 4
  e4 e cis8 d e4 |
  % 5
  d2 cis4 cis |
  % 6
  d cis b a8 b |
  % 7
  cis4 cis a cis8 d |
  % 8
  e4 e cis8 d e4 |
  % 9
  d2 cis4 cis |
  % 10
  d cis b a8 b |
  % 11
  cis4 cis a b |
  % 12
  cis cis fis, gis |
  % 13
  a8 gis fis4 e e |
  % 14
  a b cis4. b16 cis |
  % 15
  d4 cis b2 |
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
  s2. cis'8 d |
  % 2
  e4 b b a |
  % 3
  e' e d e |
  % 4
  e e e fis |
  % 5
  fis8 f fis gis a4 a |
  % 6
  b a gis fis |
  % 7
  fis4. f8 cis4 fis |
  % 8
  e8 fis gis4 a4. a8 |
  % 9
  a gis16 fis gis4 a a |
  % 10
  a8 gis a4 e4. fis16 gis |
  % 11
  a4 g fis e |
  % 12
  e8 gis fis e dis4 e |
  % 13
  fis8 e4 dis8 e4 b |
  % 14
  e e e8 d16 e fis4. gis8 a4. gis16 fis gis4 |
  % 16
  e1 |
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
  s2. e4 |
  % 2
  a gis8 fis cis'4 cis |
  % 3
  b a8 g fis4 a |
  % 4
  gis8 a b4 a8 b cis4 |
  % 5
  b8 cis d e fis4 e |
  % 6
  fis8 e4 d cis8 cis b |
  % 7
  a4 gis fis a |
  % 8
  b8 a b e e4. e8 |
  % 9
  fis d b e e4 e |
  % 10
  fis8 b, cis d e4. d8 |
  % 11
  e4 e d b |
  % 12
  a8 gis a cis b4 b |
  % 13
  b cis8 fis, gis4 gis8 a16 b |
  % 14
  e,4 b' a4. gis16 a |
  % 15
  b8 b cis d16 e fis8 d b e |
  % 16
  cis1 |
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
  s2. a8 b |
  % 2
  cis4 dis f fis |
  % 3
  gis a d, a'8 b |
  % 4
  cis b a gis a4 ais |
  % 5
  b b, fis' a4. gis4 fis f8 fis d |
  % 7
  a b cis4 fis, fis' |
  % 8
  gis8 fis e4 a cis, |
  % 9
  b e a, a'8*7 gis8 cis b |
  % 11
  a a,4 b16 cis d4 gis, |
  % 12
  a8 e' a4. gis8 fis e |
  % 13
  dis e a b e,4 e8 d |
  % 14
  cis b a gis a b16 cis d4. cis16 b fis'8 e d b e4 |
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
