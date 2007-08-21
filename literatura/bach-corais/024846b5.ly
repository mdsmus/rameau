% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 024846b5.mid
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
  s2. a''4 |
  % 2
  a e' e d8 cis |
  % 3
  b4 cis d8 cis b4 |
  % 4
  a2 s4 a |
  % 5
  b cis d b |
  % 6
  e fis e cis |
  % 7
  cis8 d e4 d cis8 b |
  % 8
  a b cis4 b cis |
  % 9
  a b8 cis d4 cis |
  % 10
  b cis d cis |
  % 11
  b a e'4. d8 |
  % 12
  cis4 d8 cis b2 |
  % 13
  a1 |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. fis'4 |
  % 2
  e8 fis gis a b4 e, |
  % 3
  dis e d8 a' gis4 |
  % 4
  e2 s4 fis |
  % 5
  fis e8 cis gis' fis e dis |
  % 6
  e fis16 gis a8 fis gis4 a |
  % 7
  a ais b8 a gis fis |
  % 8
  e fis16 gis a8 fis gis4 a8 gis |
  % 9
  fis4. gis16 ais b4 ais |
  % 10
  b8 a g4 fis e8 a4 gis fis8 gis a b4. e,8 a2 gis4 |
  % 13
  e1 |
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
  s2. cis'8 d |
  % 2
  e4 d8 cis b4 a |
  % 3
  b a8 g a4 e'8 d |
  % 4
  cis2 s4 a |
  % 5
  a gis b8 a b4 |
  % 6
  b8 e4 dis8 e4 e |
  % 7
  fis fis fis e |
  % 8
  e8 d cis dis e4 e |
  % 9
  d8 cis d e fis4 fis8 e |
  % 10
  d4 e a, a |
  % 11
  b cis8 dis e2 |
  % 12
  e8 cis a cis fis d b e |
  % 13
  cis1 |
  % 14
  
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s2. fis4 |
  % 2
  cis' b8 a gis4 a4. g8 fis e fis d e4 |
  % 4
  a,2 s4 d |
  % 5
  dis8 e4 f fis8 gis a |
  % 6
  gis e b' b, e4 a8 gis |
  % 7
  fis e d cis b4 e8 d |
  % 8
  cis b a4 e' a, |
  % 9
  d8 e d cis b4 fis' |
  % 10
  g8 fis e4 d a |
  % 11
  e'8*5 fis8 gis e |
  % 12
  a gis fis e d b e4 |
  % 13
  a,1 |
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
