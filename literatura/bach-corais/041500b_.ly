% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 041500b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \major
  
  \tempo 4 = 80 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d'4 |
  % 2
  a' a b cis |
  % 3
  d2 d4 fis |
  % 4
  e d d cis |
  % 5
  d2. d,4 |
  % 6
  a' a b cis |
  % 7
  d2 d4 fis |
  % 8
  e d d cis |
  % 9
  d2. d8 e |
  % 10
  fis4 fis e4. d8 |
  % 11
  cis b cis4 a cis |
  % 12
  d cis b b |
  % 13
  a2. a4 |
  % 14
  fis8 g a4 b a |
  % 15
  a g8 fis fis4 a |
  % 16
  g fis e e |
  % 17
  d2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. a'4 |
  % 2
  d d d g2 fis8 e fis4 a8 b |
  % 4
  cis4 b b a |
  % 5
  a2. a,4 |
  % 6
  d d d g2 fis8 e fis4 a8 b |
  % 8
  cis4 b b a |
  % 9
  a2. a4 |
  % 10
  d d8 cis b gis a b |
  % 11
  e, fis gis4 fis a4. gis8 a2 gis4 |
  % 13
  e2. e4 |
  % 14
  d d d8 e fis4 |
  % 15
  fis e dis d |
  % 16
  d d2 cis4 |
  % 17
  a2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. fis8 e |
  % 2
  fis g a fis g4 g8 a |
  % 3
  b4 a8 g a4 a' |
  % 4
  g fis f e |
  % 5
  fis2. fis,8 e |
  % 6
  fis g a fis g4 g8 a |
  % 7
  b4 a8 g a4 a' |
  % 8
  g fis f e |
  % 9
  fis2. fis8 g |
  % 10
  a4 d, e8 d cis b |
  % 11
  a4 gis cis fis8 e |
  % 12
  d4 e e8 fis e d |
  % 13
  cis2. a4 |
  % 14
  a d8 c b cis d c |
  % 15
  b2 b4 c |
  % 16
  b b b a8 g |
  % 17
  fis2. 
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
  s2. d8 cis |
  % 2
  d e fis d g fis e4 |
  % 3
  b8 cis d4 d, d'' |
  % 4
  ais b8 a gis4 a |
  % 5
  d,2. d8 cis |
  % 6
  d e fis d g fis e4 |
  % 7
  b8 cis d4 d, d'' |
  % 8
  ais b8 a gis4 a |
  % 9
  d,2. d4 |
  % 10
  d'8 cis b a gis e fis gis |
  % 11
  a gis fis f fis4 fis |
  % 12
  b8 b, cis d e d e e, |
  % 13
  a2. cis4 |
  % 14
  d8 e fis d g4 fis8 e |
  % 15
  dis4 e b fis |
  % 16
  g8 a b a g e a4 |
  % 17
  d,2. 
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
