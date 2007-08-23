% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 042.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \major
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. cis''4 |
  % 2
  a b cis e |
  % 3
  d d cis e |
  % 4
  d cis b b |
  % 5
  cis2. cis4 |
  % 6
  a b cis e |
  % 7
  d d cis e |
  % 8
  d cis b b |
  % 9
  cis2. b4 |
  % 10
  b b cis b |
  % 11
  a b gis gis |
  % 12
  a b cis b8 cis |
  % 13
  d4 cis b2 |
  % 14
  a1 |
  % 15
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. a''4 |
  % 2
  fis gis a b |
  % 3
  a b a a |
  % 4
  a a a gis |
  % 5
  a2. a4 |
  % 6
  fis gis a b |
  % 7
  a b a a |
  % 8
  a a a gis |
  % 9
  a2. gis4 |
  % 10
  e gis a gis |
  % 11
  fis gis f f |
  % 12
  fis gis a e |
  % 13
  a a a gis |
  % 14
  a1 |
  % 15
  
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
  d d e e |
  % 3
  fis e e e |
  % 4
  fis e fis e |
  % 5
  e2. e4 |
  % 6
  d d e e |
  % 7
  fis e e e |
  % 8
  fis e fis e |
  % 9
  e2. e4 |
  % 10
  b e e e8 d |
  % 11
  cis4 d cis cis |
  % 12
  cis e e2 |
  % 13
  d4 e fis e8 d |
  % 14
  cis1 |
  % 15
  
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s2. a4 |
  % 2
  d8 cis b4 a gis |
  % 3
  fis gis a cis |
  % 4
  fis8 gis a4 d, e |
  % 5
  a,2. a4 |
  % 6
  d8 cis b4 a gis |
  % 7
  fis gis a cis |
  % 8
  fis8 gis a4 d, e |
  % 9
  a,2. e'8 fis |
  % 10
  gis4 e a e |
  % 11
  fis b, cis cis |
  % 12
  fis e a gis |
  % 13
  fis e d e |
  % 14
  a,1 |
  % 15
  
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
