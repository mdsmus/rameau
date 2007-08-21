% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 039300b_.mid
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
  s2. cis''4 |
  % 2
  a b cis8 d e4 |
  % 3
  d2 cis4 cis8 d |
  % 4
  e4 e b cis |
  % 5
  a2 gis4 e |
  % 6
  a b cis8 d16 e d8 cis |
  % 7
  b2. cis4 |
  % 8
  a b cis8 d e4 |
  % 9
  d2 cis4 cis8 d |
  % 10
  e4 e b cis |
  % 11
  a2 gis4 e |
  % 12
  a b cis d |
  % 13
  cis b a2 |
  % 14
  
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
  fis e e e |
  % 3
  fis e e a |
  % 4
  a8 gis a4 gis8 fis4 e8 |
  % 5
  e4 dis e e8 d |
  % 6
  cis4 e e a |
  % 7
  gis2. gis4. fis4 e8 e4 fis |
  % 9
  fis2 fis4 e |
  % 10
  e8 fis gis4 fis e |
  % 11
  fis2 e4 gis |
  % 12
  a4. gis8 a4 a |
  % 13
  a4. gis8 e2 |
  % 14
  
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
  cis b a a |
  % 3
  a gis a e' |
  % 4
  e e e gis, |
  % 5
  fis8 gis a4 b gis |
  % 6
  cis b a fis' |
  % 7
  b,2. gis4 |
  % 8
  cis b a8 b cis4 |
  % 9
  cis b ais a |
  % 10
  b b b8 a gis4 |
  % 11
  cis b b b |
  % 12
  e d e d |
  % 13
  e8 fis b,16 cis d8 cis2 |
  % 14
  
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
  s2. f4 |
  % 2
  fis gis a cis, |
  % 3
  b e a, a' |
  % 4
  cis, cis8 d e4 cis |
  % 5
  fis2 e4 e |
  % 6
  fis gis a d, |
  % 7
  e2. f4 |
  % 8
  fis gis a ais |
  % 9
  b2 fis4 a |
  % 10
  gis fis8 e dis4 e |
  % 11
  e dis e e8 d |
  % 12
  cis4 b a8 g'4 fis8 |
  % 13
  e dis e4 a,2 |
  % 14
  
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
