% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 343.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key d \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  d'4 d e fis4. gis8 a4 a2 |
  % 3
  gis4 a2 fis4 |
  % 4
  g2 fis4 e2 d4 e2. d |
  % 7
  d4 d e fis4. gis8 a4 a2 |
  % 9
  gis4 a2 fis4 |
  % 10
  g2 fis4 e2 d4 e2. d |
  % 13
  e4 e fis g2 g4 fis4. e8 |
  % 15
  fis4 e2. |
  % 16
  fis4 fis fis g4. a8 b4 b2 |
  % 18
  ais4 b2 cis4 |
  % 19
  d fis,2 g fis4 e e |
  % 21
  a b4. a8 g4 |
  % 22
  fis8 e e4. d8 d2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  a'4 d d8 cis d2 cis8 a fis'4 e2 e d8 cis |
  % 4
  b cis d8*5 cis16 b |
  % 5
  cis4 d2 cis8 b |
  % 6
  cis4 a2. |
  % 7
  a4 d d8 cis d2 cis8 a fis'4 e2 e d8 cis |
  % 10
  b cis d8*5 cis16 b |
  % 11
  cis4 d2 cis8 b |
  % 12
  cis4 a2. |
  % 13
  cis8 b cis4. dis8 e4 |
  % 14
  b e2 dis8 cis |
  % 15
  dis4 b2. |
  % 16
  dis4 b dis e |
  % 17
  b b g'8 fis e d |
  % 18
  e4 d2 fis4 |
  % 19
  fis8 e d2 cis8 d |
  % 20
  e4 d d8 b cis4 |
  % 21
  d d g8 fis fis e |
  % 22
  d4 d8 b cis4 a2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  fis4 fis8 d a'4 a8 fis |
  % 2
  b4 a b b8 cis |
  % 3
  d4 cis2 a4 |
  % 4
  g a8 g a2 |
  % 5
  a8 g fis4 b a4. g8 fis2. |
  % 7
  fis4 fis8 d a'4 a8 fis |
  % 8
  b4 a b b8 cis |
  % 9
  d4 cis2 a4 |
  % 10
  g a8 g a8*5 g8 fis4 b a4. g8 fis2. |
  % 13
  a8 gis a4 a b8 a |
  % 14
  g2 c4 b4. a8 g2. |
  % 16
  b4 fis8 g a b g fis |
  % 17
  e4 e'8 d cis4. b8 |
  % 18
  cis4 b2 ais4 |
  % 19
  b4. fis8 b a g fis |
  % 20
  e a4 gis8 a4 a |
  % 21
  a g8 a b cis d a |
  % 22
  a b a4 g fis2. 
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
  d8 cis b4 a d4. e8 fis4 d8 b e2 a, d4 |
  % 4
  e fis4. g8 a g |
  % 5
  fis4 b8 a g e a4 |
  % 6
  a, d2. |
  % 7
  d8 cis b4 a d4. e8 fis4 d8 b e2 a, d4 |
  % 10
  e fis4. g8 a g |
  % 11
  fis4 b8 a g e a4 |
  % 12
  a, d2. |
  % 13
  a4 a'8 g fis4 e4. d8 c b a fis b4 |
  % 15
  b e2. |
  % 16
  b8 cis dis4 b e4. fis8 g fis e d cis4 |
  % 18
  fis b,2 fis'4 |
  % 19
  b4. a8 g fis e d |
  % 20
  cis4 d a' a, |
  % 21
  fis' g4. a8 b cis, |
  % 22
  d g, a2 d2. 
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
  d8 cis b4 a d4. e8 fis4 d8 b e4 |
  % 3
  e, a2 d4 |
  % 4
  e fis4. g8 a g |
  % 5
  fis4 b8 a g e a4 |
  % 6
  a, d,2. |
  % 7
  d'8 cis b4 a d4. e8 fis4 d8 b e4 |
  % 9
  e, a2 d4 |
  % 10
  e fis4. g8 a g |
  % 11
  fis4 b8 a g e a4 |
  % 12
  a, d,2. |
  % 13
  a'4 a'8 g fis4 e4. d8 c b a fis b4 |
  % 15
  b e,2. |
  % 16
  b'8 cis dis4 b e4. fis8 g fis e d cis4 |
  % 18
  fis b,2 fis'4 |
  % 19
  b4. a8 g fis e d |
  % 20
  cis4 d a a |
  % 21
  fis g4. a8 b cis |
  % 22
  d g, a2 d,2. 
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
