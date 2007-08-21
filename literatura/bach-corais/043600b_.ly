% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 043600b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key e \major
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. e'4 |
  % 2
  b' gis e b' |
  % 3
  cis cis b b |
  % 4
  cis dis e dis |
  % 5
  cis cis b gis |
  % 6
  cis b a gis |
  % 7
  fis2 e4 e |
  % 8
  b' gis e b' |
  % 9
  cis cis b b |
  % 10
  cis dis e dis |
  % 11
  cis cis b gis |
  % 12
  cis b a gis |
  % 13
  fis2 e4 s4 |
  % 14
  b'2 gis |
  % 15
  b gis |
  % 16
  a4 gis fis gis |
  % 17
  a gis fis gis |
  % 18
  a gis fis2 |
  % 19
  e e'4 dis |
  % 20
  cis b a gis |
  % 21
  fis2 e4*5 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. b'4 |
  % 2
  b b cis dis |
  % 3
  gis fis fis gis |
  % 4
  a a gis fis |
  % 5
  fis8 gis fis e dis4 e |
  % 6
  e dis e8 fis gis e |
  % 7
  e4 dis b b |
  % 8
  b b cis dis |
  % 9
  gis fis fis gis |
  % 10
  a a gis fis |
  % 11
  fis8 gis fis e dis4 e |
  % 12
  e dis e8 fis gis e |
  % 13
  e4 dis b s4 |
  % 14
  fis'2 e |
  % 15
  fis e |
  % 16
  fis4 e dis e |
  % 17
  fis e dis e |
  % 18
  fis e8 dis cis dis16 e dis4 |
  % 19
  b2 gis'4 g |
  % 20
  gis gis8 fis e4 e |
  % 21
  e dis b4*5 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. gis'4 |
  % 2
  fis e8 fis gis ais b4 |
  % 3
  b ais dis e |
  % 4
  e fis b, b |
  % 5
  b ais b b |
  % 6
  a8 gis fis4 cis' b |
  % 7
  b4. a8 gis4 gis |
  % 8
  fis e8 fis gis ais b4 |
  % 9
  b ais dis e |
  % 10
  e fis b, b |
  % 11
  b ais b b |
  % 12
  a8 gis fis4 cis' b |
  % 13
  b4. a8 gis4 s4 |
  % 14
  b2 b |
  % 15
  dis cis |
  % 16
  cis4 b b b |
  % 17
  b b b b |
  % 18
  cis8 dis e4. cis8 b a |
  % 19
  gis2 cis8 b ais4 |
  % 20
  gis dis' cis b |
  % 21
  cis b8 a gis4*5 
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
  dis e cis gis' |
  % 3
  e fis b, e |
  % 4
  a gis8 fis gis ais b4 |
  % 5
  fis fis, b e |
  % 6
  a, b cis8 dis e4 |
  % 7
  b2 e4 e |
  % 8
  dis e cis gis' |
  % 9
  e fis b, e |
  % 10
  a gis8 fis gis ais b4 |
  % 11
  fis fis, b e |
  % 12
  a, b cis8 dis e4 |
  % 13
  b2 e4 s4 |
  % 14
  dis2 e |
  % 15
  b cis |
  % 16
  fis4 gis a8 gis fis e |
  % 17
  dis4 e b8 b' a gis |
  % 18
  fis4 cis8 b a4 b |
  % 19
  e2 cis4 dis |
  % 20
  f8 g gis4 cis,8 dis e4 |
  % 21
  ais, b e4*5 
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
