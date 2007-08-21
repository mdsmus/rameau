% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 014406b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key b \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. fis'4 |
  % 2
  a b a d |
  % 3
  d cis d d |
  % 4
  cis b e4. d8 |
  % 5
  cis4 d cis2 |
  % 6
  b2. fis4 |
  % 7
  a b a d |
  % 8
  d cis d d |
  % 9
  cis b e4. d8 |
  % 10
  cis4 d cis2 |
  % 11
  b2. b4 |
  % 12
  b b cis4. b8 |
  % 13
  cis4 a a gis |
  % 14
  a a b cis |
  % 15
  d cis b2 |
  % 16
  cis2. fis,8 gis |
  % 17
  a4 b a d |
  % 18
  d cis d d |
  % 19
  cis b e4. d8 |
  % 20
  cis4 d cis2 |
  % 21
  b1 |
  % 22
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. d'4 |
  % 2
  d d d d8 e |
  % 3
  fis g a4 a a |
  % 4
  a g g fis |
  % 5
  fis8*5 g8 fis e |
  % 6
  d2. d4 |
  % 7
  d d d d8 e |
  % 8
  fis g a4 a a |
  % 9
  a g g fis |
  % 10
  fis8*5 g8 fis e |
  % 11
  d2. fis4 |
  % 12
  e d cis dis8 f |
  % 13
  fis4 fis fis e |
  % 14
  e e e e |
  % 15
  fis ais b gis |
  % 16
  ais2. cis,4 |
  % 17
  fis gis fis fis |
  % 18
  b a a gis |
  % 19
  a gis ais4. b8 |
  % 20
  cis4 b2 ais4 |
  % 21
  a g fis2 |
  % 22
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. b'4 |
  % 2
  a g fis8 g a b |
  % 3
  a4 e' fis fis |
  % 4
  e e b b |
  % 5
  ais b2 ais4 |
  % 6
  fis2. b4 |
  % 7
  a g fis8 g a b |
  % 8
  a4 e' fis fis |
  % 9
  e e b b |
  % 10
  ais b2 ais4 |
  % 11
  fis2. d'8 cis |
  % 12
  b cis b a g4 a8 b |
  % 13
  a b cis4 b b |
  % 14
  cis cis b ais |
  % 15
  b g' fis f |
  % 16
  fis2. a,8 b |
  % 17
  cis4 d8 cis cis4 d |
  % 18
  e e fis e8 d |
  % 19
  e4 e e8 fis g4. fis16 e d8 cis16 b fis'8 cis fis e |
  % 21
  dis4 e dis2 |
  % 22
  
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
  s2. b4 |
  % 2
  fis' g d8 e fis g |
  % 3
  a4 a, d d |
  % 4
  a' e8 fis g a b4 |
  % 5
  fis8 e d e fis2 |
  % 6
  b,2. b4 |
  % 7
  fis' g d8 e fis g |
  % 8
  a4 a, d d |
  % 9
  a' e8 fis g a b4 |
  % 10
  fis8 e d e fis2 |
  % 11
  b,2. b'8 a |
  % 12
  gis a gis fis f cis fis gis |
  % 13
  a gis fis e d b e4 |
  % 14
  a, a' gis g |
  % 15
  fis e d8 cis d b |
  % 16
  fis'2. fis,4 |
  % 17
  fis' f fis b8 a |
  % 18
  gis4 a d, b |
  % 19
  a e'8 d cis d cis b |
  % 20
  ais g' fis f fis2 |
  % 21
  b,1 |
  % 22
  
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
