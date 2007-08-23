% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 017.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key e \minor
  
  \tempo 4 = 100 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  e'4 e e b'2 cis4 d cis |
  % 3
  b a2. |
  % 4
  b4 cis dis e2 b4 d cis2 b b4 |
  % 7
  d c b a |
  % 8
  g fis g e2 d d4 |
  % 10
  g2 a4 b2 a4 g d'2 b a4 |
  % 13
  g fis2 e2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  b'4 b cis d |
  % 2
  e e fis8 gis a4 |
  % 3
  gis e2. |
  % 4
  e4 e fis g8 a |
  % 5
  g fis e4 fis g |
  % 6
  fis dis2 e4 |
  % 7
  d2 d4 e2 d4 d2 |
  % 9
  cis4 a2 b4 |
  % 10
  b e d d8 e |
  % 11
  fis2 e4 fis8 g |
  % 12
  a4 g2 fis4 |
  % 13
  e2 dis4 b2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  g'8 a b4 a fis |
  % 2
  b a a fis |
  % 3
  b cis2. |
  % 4
  b4 a a b2 b4 b2 |
  % 6
  ais4 fis2 g4 |
  % 7
  a2 g4 e |
  % 8
  a2 g8 a b4 |
  % 9
  a8 g fis2 fis4 |
  % 10
  g c2 b4 |
  % 11
  b2 b8 c d2 d c4 |
  % 13
  b a8 g a4 gis2. 
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
  e8 fis g4 a2 |
  % 2
  gis4 a fis d |
  % 3
  e a,2. |
  % 4
  gis'4 a fis e8 dis |
  % 5
  e fis g4 fis e |
  % 6
  fis b,2 e4 |
  % 7
  fis2 g4 cis,2 d4 b g |
  % 9
  a d2 b4 |
  % 10
  e2 fis4 g |
  % 11
  dis2 e4 b' |
  % 12
  fis g2 a4 |
  % 13
  b b,2 e2. 
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
