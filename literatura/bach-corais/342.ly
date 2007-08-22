% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 342.mid
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
  e' e e e |
  % 3
  fis e8 d cis4 b |
  % 4
  cis8 dis e4 e8 fis dis4 |
  % 5
  e2. e4 |
  % 6
  e e e8 d cis d |
  % 7
  e4 d8 cis b4 e |
  % 8
  d cis b b8 cis |
  % 9
  a b cis d e4 e |
  % 10
  d cis b b |
  % 11
  a1 |
  % 12
  
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
  e8 fis gis4 a a |
  % 3
  a gis e e |
  % 4
  e8 fis gis4 fis gis8 a |
  % 5
  gis2. gis4 |
  % 6
  a gis8 fis e4 e8 d |
  % 7
  cis a fis'4 gis cis8 b |
  % 8
  a4. gis8 fis4 gis |
  % 9
  fis8 gis a b cis4 fis, |
  % 10
  fis8 gis a4 a gis |
  % 11
  e1 |
  % 12
  
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
  b e8 d cis d e4 |
  % 3
  d8 cis b4 a gis |
  % 4
  a b b b |
  % 5
  b2. b4 |
  % 6
  cis b8 a b4 a |
  % 7
  a a e' gis, |
  % 8
  a8 b cis a d4. cis8 |
  % 9
  cis4 fis, gis cis |
  % 10
  d8 e fis4 fis e8 d |
  % 11
  cis1 |
  % 12
  
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
  gis e a8 b cis a |
  % 3
  d,4 e a, e' |
  % 4
  a gis8 a b4 b, |
  % 5
  e2. e8 d |
  % 6
  cis d e fis gis e a4 |
  % 7
  cis, d e cis |
  % 8
  fis8 gis a4. gis8 fis f |
  % 9
  fis4 e8 d cis4 ais' |
  % 10
  b fis8 e d b e4 |
  % 11
  a,1 |
  % 12
  
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
