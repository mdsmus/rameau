% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 004207b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key fis \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. fis'4 |
  % 2
  fis fis f fis8 gis |
  % 3
  a4 gis fis a |
  % 4
  b b cis8 b a4 |
  % 5
  b2 cis4 cis |
  % 6
  cis b cis8 b a4 |
  % 7
  b8 a gis4 fis fis8 gis |
  % 8
  a4 a b a8 gis |
  % 9
  fis2 fis4 b |
  % 10
  cis b fis8 gis a4 |
  % 11
  gis8 fis gis4 fis fis |
  % 12
  fis e a b |
  % 13
  cis8 b a4 b b |
  % 14
  cis2 d |
  % 15
  cis4 b8 cis16 d b4. a8 |
  % 16
  a2. cis4 |
  % 17
  cis8 b a4 b8 cis d4 |
  % 18
  cis2 e4 cis |
  % 19
  d cis8 b cis4 cis |
  % 20
  d cis8 d e d cis4 |
  % 21
  b2 a |
  % 22
  cis4 cis a b |
  % 23
  a gis fis2 |
  % 24
  e4 fis8 gis a4 fis |
  % 25
  fis2. e4 |
  % 26
  fis gis a gis |
  % 27
  fis2. f4 |
  % 28
  fis1 |
  % 29
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. cis'4 |
  % 2
  d d cis2 |
  % 3
  cis8 fis fis f cis4 fis |
  % 4
  e8 fis gis4 a2 |
  % 5
  a8 gis16 fis gis4 a a |
  % 6
  a f8 fis gis4 fis |
  % 7
  fis e dis dis8 f |
  % 8
  fis4 fis gis8 fis f4 |
  % 9
  fis8 e d4 cis e |
  % 10
  e e d8 e fis4 |
  % 11
  fis f cis cis |
  % 12
  cis cis d d |
  % 13
  cis cis fis e |
  % 14
  e2 b' |
  % 15
  e,4 fis e e |
  % 16
  e2. gis4 |
  % 17
  a8 gis fis4 fis fis8 f |
  % 18
  fis2 gis8 b b a |
  % 19
  a gis a gis a b cis4 |
  % 20
  cis8 b a4 e e |
  % 21
  fis e8 d cis2 |
  % 22
  e4 e fis fis |
  % 23
  fis e e d |
  % 24
  cis d e d |
  % 25
  d2. cis4 |
  % 26
  cis2. d8 e |
  % 27
  fis4 gis8 a d,4 cis |
  % 28
  cis1 |
  % 29
  
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
  a a gis8 b a gis |
  % 3
  fis4 cis'8 b a4 cis |
  % 4
  b e e4. d16 cis |
  % 5
  b4 e e e |
  % 6
  e8 d d4 cis cis |
  % 7
  b b b b |
  % 8
  cis d d cis8 b |
  % 9
  a ais b4 a gis |
  % 10
  a b8 cis d4 cis |
  % 11
  cis4. b8 a4 a |
  % 12
  a gis fis gis |
  % 13
  a8 gis a4 a gis |
  % 14
  a2 gis |
  % 15
  a4 a a8 fis gis d' |
  % 16
  cis2. cis4 |
  % 17
  fis4. e8 d cis b gis |
  % 18
  a2 b4 e |
  % 19
  e e8 d cis b a gis |
  % 20
  fis gis a4 b a |
  % 21
  a gis e2 |
  % 22
  a4 a a d |
  % 23
  cis b b2 |
  % 24
  gis4 a8 b cis4 b |
  % 25
  a2. a8 gis |
  % 26
  fis4 b a b |
  % 27
  a gis8 fis gis a b4 |
  % 28
  ais1 |
  % 29
  
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
  s2. fis8 e |
  % 2
  d4 cis8 b cis4 dis8 f |
  % 3
  fis b, cis4 fis fis |
  % 4
  gis fis8 e a gis fis e |
  % 5
  d4 e a, a'8 gis |
  % 6
  fis4 gis8 fis f4 fis8 e |
  % 7
  dis4 e b b' |
  % 8
  fis8 e d cis b4 cis |
  % 9
  d cis8 b fis'4 e |
  % 10
  a gis8 a b4 a8 b |
  % 11
  cis4 cis, fis fis8 gis |
  % 12
  a b cis4 cis8 d cis b |
  % 13
  a f fis cis d b e4 |
  % 14
  a,2 b |
  % 15
  cis4 d e e |
  % 16
  a,2. f'4 |
  % 17
  fis4. fis8 gis ais b4 |
  % 18
  fis2 e4 e |
  % 19
  e e8 e e4 e |
  % 20
  e fis gis a |
  % 21
  d, e a,2 |
  % 22
  a8 b cis a d cis d e |
  % 23
  fis4 gis8 a b2 |
  % 24
  cis,4. b8 a4 b8 cis |
  % 25
  d2. a'4. gis8 fis f fis4 b,8 cis |
  % 27
  d cis b a b4 cis |
  % 28
  fis1 |
  % 29
  
}

trackE = <<

  \clef bass
  
  \context Voice = channelA \trackEchannelA
  \context Voice = channelB \trackEchannelB
>>


trackFchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 5
  
}

trackFchannelB = \relative c {
  s2. fis8 e |
  % 2
  d4 cis8 b cis4 dis8 f |
  % 3
  fis b, cis4 fis, fis' |
  % 4
  gis fis8 e a gis fis e |
  % 5
  d4 e a, a'8 gis |
  % 6
  fis4 gis8 fis f4 fis8 e |
  % 7
  dis4 e b b' |
  % 8
  fis8 e d cis b4 cis |
  % 9
  d cis8 b fis'4 e |
  % 10
  a gis8 a b4 a8 b |
  % 11
  cis4 cis, fis fis,8 gis |
  % 12
  a b cis4. d8 cis b |
  % 13
  a f fis cis' d b e4 |
  % 14
  a,2 b |
  % 15
  cis4 d e e, |
  % 16
  a2. f'4 |
  % 17
  fis4. fis8 gis ais b4 |
  % 18
  fis2 e4 e |
  % 19
  e,4*5 fis4 gis a |
  % 21
  d, e a2 |
  % 22
  a8 b cis a d cis d e |
  % 23
  fis fis, gis a b2 |
  % 24
  cis4. b8 a4 b8 cis |
  % 25
  d2. a4. gis8 fis f fis4 b8 cis |
  % 27
  d cis b a b4 cis |
  % 28
  fis,1 |
  % 29
  
}

trackF = <<

  \clef bass
  
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
    \context Staff=trackF \trackF
  >>
}
