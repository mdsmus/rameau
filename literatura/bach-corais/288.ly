% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 288.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key b \minor
  
  \tempo 4 = 92 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  a a b a |
  % 3
  d e d2 |
  % 4
  cis8 d e4 fis e8 d |
  % 5
  cis4 b a a |
  % 6
  d cis8 d e4 b |
  % 7
  a8 gis fis4 e e |
  % 8
  b' b b cis |
  % 9
  d8 cis b4 a8 b cis4 |
  % 10
  b2 a4 a |
  % 11
  a2 a |
  % 12
  
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
  e4 fis fis8 e e4 |
  % 3
  a a8 g fis2 |
  % 4
  e8 fis g4 a8 fis b4 |
  % 5
  b8 a a gis e4 fis |
  % 6
  fis8 g a4 a gis |
  % 7
  fis8 e e dis b4 cis |
  % 8
  dis dis e e |
  % 9
  d4. e8 fis4 e8 fis |
  % 10
  gis2 fis4 e4. d16 e fis4 e2 |
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
  s2. a'4 |
  % 2
  a d d cis |
  % 3
  d8 e16 fis cis4 a2 |
  % 4
  a4 b cis8 d e4 |
  % 5
  e e cis d |
  % 6
  d8 e fis4 e e8 b |
  % 7
  b4 b gis a8 gis |
  % 8
  fis4 b8 a gis4 ais |
  % 9
  b8 a g4 fis8 gis a4 |
  % 10
  e'2 cis8 d e g, |
  % 11
  fis a d4 cis2 |
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
  s2. fis4 |
  % 2
  cis d g4. fis16 e |
  % 3
  fis8 d a'4 d,2 |
  % 4
  a'4 g fis gis |
  % 5
  a e a, d8 cis |
  % 6
  b4 fis' cis8 d e4 |
  % 7
  dis8 e b4 e a |
  % 8
  a gis8 fis e d cis4 |
  % 9
  b4. cis8 d4 cis8 dis |
  % 10
  e2 fis4 cis |
  % 11
  d2 a |
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
