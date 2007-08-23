% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 341.mid
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
  a a a b |
  % 3
  g fis e b' |
  % 4
  cis b a gis8 fis |
  % 5
  gis4 fis e e |
  % 6
  a a a b |
  % 7
  gis fis e b' |
  % 8
  cis b a gis8 fis |
  % 9
  gis4 fis e e' |
  % 10
  d cis b a |
  % 11
  a8 b cis4 b cis |
  % 12
  d cis b ais |
  % 13
  b2. e,4 |
  % 14
  a b cis d |
  % 15
  e d8 cis b4 d |
  % 16
  cis b e4. d8 |
  % 17
  cis b a b cis4 b |
  % 18
  a2. 
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
  e4 e fis fis |
  % 3
  e dis b gis' |
  % 4
  a gis cis,8 dis e2 dis4 b b |
  % 6
  cis8 d e4 dis8 e fis4 |
  % 7
  b,8 e4 dis8 e4 e |
  % 8
  e e e4. dis8 |
  % 9
  cis4 dis b gis' |
  % 10
  fis e8 fis gis4 a8 g |
  % 11
  fis gis a4 gis ais |
  % 12
  b ais b fis |
  % 13
  fis2. e4 |
  % 14
  cis e e fis |
  % 15
  e fis gis fis |
  % 16
  e e8 fis gis4 a |
  % 17
  e8*5 d8 d cis |
  % 18
  cis2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. a'4 |
  % 2
  a8 b cis4 d8 cis b4 |
  % 3
  b a16 gis a8 gis4 e' |
  % 4
  e e8 dis cis b16 a b8 cis |
  % 5
  b4 a16 gis a8 gis4 gis |
  % 6
  a8 g fis e fis4 fis |
  % 7
  gis8. a16 b8 a gis4 b |
  % 8
  a b cis b8 dis |
  % 9
  e4 b gis cis |
  % 10
  a8 b cis d e4 e |
  % 11
  d cis8 d e4 e |
  % 12
  fis e fis8 e16 d cis4 |
  % 13
  d2. gis,4 |
  % 14
  fis gis a a8 b |
  % 15
  cis4 b8 a e'4 a,8 b |
  % 16
  cis d e4 b a2 a gis4 |
  % 18
  e2. 
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
  s2. fis4 |
  % 2
  cis a d dis |
  % 3
  e b e e |
  % 4
  a, e' fis gis8 a |
  % 5
  b4 b, e d |
  % 6
  cis c b8 cis dis4 |
  % 7
  e b e gis |
  % 8
  a gis cis,8 dis e4 |
  % 9
  a, b e cis |
  % 10
  fis8 gis a4 e8 d cis4 |
  % 11
  d a e' cis |
  % 12
  b cis d8 e fis4 |
  % 13
  b,2. cis4 |
  % 14
  fis e a fis |
  % 15
  cis d e fis8 gis |
  % 16
  a4 gis8 fis e d cis b |
  % 17
  a b cis d e4 e |
  % 18
  a,2. 
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
