% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 000907b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key e \major
  
  \tempo 4 = 92 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. b''4 |
  % 2
  b b b8 cis d4 |
  % 3
  cis b a b8 a |
  % 4
  gis fis e fis gis4 ais |
  % 5
  b cis b b |
  % 6
  b b b8 cis d4 |
  % 7
  cis b a b8 a |
  % 8
  gis fis e fis gis4 ais |
  % 9
  b cis b b |
  % 10
  e dis cis dis |
  % 11
  e8 dis cis4 b b |
  % 12
  e b cis gis8 a |
  % 13
  b4 a gis gis |
  % 14
  fis8 gis a4 gis fis |
  % 15
  cis dis e 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. gis''4 |
  % 2
  fis8 gis a4 gis8 a b4 |
  % 3
  b8 a d, e fis4 fis |
  % 4
  e b e cis |
  % 5
  fis4. e8 dis4 gis |
  % 6
  fis8 gis a4 gis8 a b4 |
  % 7
  b8 a d, e fis4 fis |
  % 8
  e b e cis |
  % 9
  fis4. e8 dis4 e8 fis |
  % 10
  gis ais b4 ais8 gis fis4 |
  % 11
  b8 gis ais4 fis gis8 a |
  % 12
  b a gis fis f fis gis cis, |
  % 13
  cis gis' gis fis fis f f4 |
  % 14
  fis8 e dis cis b cis dis4 |
  % 15
  e b b 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. e'4 |
  % 2
  b fis' e e |
  % 3
  e8 fis g4 d b |
  % 4
  b8 a gis4 cis fis, |
  % 5
  fis8 b ais4 fis e' |
  % 6
  b fis' e e |
  % 7
  e8 fis g4 d b |
  % 8
  b8 a gis4 cis fis, |
  % 9
  fis8 b ais4 fis gis |
  % 10
  cis dis8 e fis4 b, |
  % 11
  b fis'8 e dis4 e |
  % 12
  b8 cis d4 cis8 dis f fis |
  % 13
  gis cis, cis4 cis cis |
  % 14
  cis8 b a4 e' b8 a |
  % 15
  g4 fis8 a gis4 
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
  e dis e gis, |
  % 3
  a b8 cis d4 dis |
  % 4
  e4. dis8 cis dis e fis |
  % 5
  dis b fis'4 b, e |
  % 6
  e dis e gis, |
  % 7
  a b8 cis d4 dis |
  % 8
  e4. dis8 cis dis e fis |
  % 9
  dis b fis'4 b, e8 dis |
  % 10
  cis4 b fis'8 gis a fis |
  % 11
  gis e fis4 b, e8 fis |
  % 12
  gis a b4 b8 a gis fis |
  % 13
  f4 fis cis cis'8 b |
  % 14
  a gis fis4 gis8 a b4 |
  % 15
  b8 ais b4 e, 
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
