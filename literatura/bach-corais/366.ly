% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 366.mid
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
  s2. cis''8 b |
  % 2
  a4 b cis8 d e4 |
  % 3
  d2 cis4 cis8 d |
  % 4
  e4 e b cis8 b |
  % 5
  a2 gis4 e |
  % 6
  a b cis8 b cis d |
  % 7
  b2 s4 cis8 b |
  % 8
  a4 b cis8 d e4 |
  % 9
  d2 cis4 cis8 d |
  % 10
  e4 e b cis8 b |
  % 11
  a2 gis4 e |
  % 12
  a b cis8 d e d |
  % 13
  cis4 b a2 |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. a''8 gis |
  % 2
  fis4. gis8 a4. e8 |
  % 3
  fis4 e e a |
  % 4
  a8 gis a b gis fis e4 |
  % 5
  e dis e b |
  % 6
  e8 fis gis4 a8 gis a b |
  % 7
  gis2 s4 gis |
  % 8
  fis e e8 d cis4 |
  % 9
  cis8 b16 a b4 a a' |
  % 10
  b8 cis b a gis fis gis4 |
  % 11
  gis8 fis16 e fis4 e e8 d |
  % 12
  cis d cis b a4 a' |
  % 13
  e8 fis b, e cis2 |
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
  s2. e'4 |
  % 2
  fis8 e d4 e a, |
  % 3
  a gis a e' |
  % 4
  e e e8 d cis4 |
  % 5
  cis b b gis |
  % 6
  a d e8 d e fis |
  % 7
  e2 s4 f |
  % 8
  cis8 d cis b a4 a |
  % 9
  a8 fis'4 e8 e4 fis |
  % 10
  e b b8 a gis fis |
  % 11
  e cis'4 b8 b4 cis8 b |
  % 12
  a4 gis8 fis e4. fis8 |
  % 13
  gis a4 gis8 e2 |
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
  s2. a'4 |
  % 2
  d8 cis b4 a cis, |
  % 3
  b e a, a'8 b |
  % 4
  cis4 cis,8 d e4 a8 gis |
  % 5
  fis4 b, e e8 d |
  % 6
  cis d cis b a4 a'8 d, |
  % 7
  e2 s4 cis |
  % 8
  fis gis a8 b a gis |
  % 9
  fis4 gis a fis |
  % 10
  gis8 a gis fis e fis e dis |
  % 11
  cis4 dis e cis |
  % 12
  fis e8 d cis b cis d |
  % 13
  e d e4 a,2 |
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
