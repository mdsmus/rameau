% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 006906b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. cis''4 |
  % 2
  d cis b cis8 d |
  % 3
  e4 fis e d |
  % 4
  cis2 s4 e |
  % 5
  d cis d b |
  % 6
  a fis8 g a4 g |
  % 7
  fis2. cis'4 |
  % 8
  d cis b cis8 d |
  % 9
  e4 fis e d |
  % 10
  cis2 s4 e |
  % 11
  d cis d b |
  % 12
  a fis8 g a4 g |
  % 13
  fis2. a4 |
  % 14
  g fis e fis |
  % 15
  d e fis cis' |
  % 16
  d cis8 b a4 b8 cis |
  % 17
  d4 e cis fis |
  % 18
  e cis8 d e4 b |
  % 19
  a g fis e |
  % 20
  a b cis8 d e4 |
  % 21
  d cis b d |
  % 22
  cis b a fis8 g |
  % 23
  a2 g |
  % 24
  fis1 |
  % 25
  
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
  fis fis8 e d4 a' |
  % 3
  g fis8 gis a4 b |
  % 4
  e,2 s4 fis |
  % 5
  fis e fis d8 e |
  % 6
  fis2. e4 |
  % 7
  d2. e4 |
  % 8
  fis fis8 e d4 a' |
  % 9
  g fis8 gis a4 b |
  % 10
  e,2 s4 fis |
  % 11
  fis e fis d8 e |
  % 12
  fis2. e4 |
  % 13
  d2. fis4 |
  % 14
  e d d8 cis d4 |
  % 15
  d g, a a' |
  % 16
  a g fis fis |
  % 17
  fis8 b b4 a a |
  % 18
  a a e8 fis g fis |
  % 19
  e d e4 d cis |
  % 20
  cis8 a' gis fis e fis g4 |
  % 21
  fis8 b4 ais8 fis4 b |
  % 22
  b8 a a g g fis16 e d4. e8 fis4 e2 |
  % 24
  d1 |
  % 25
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. ais'4 |
  % 2
  b ais b a8 b |
  % 3
  cis4 d e8 fis gis4 |
  % 4
  cis,2 s4 cis |
  % 5
  b8 a g4 a b8 cis |
  % 6
  d2. a4 |
  % 7
  a2. ais4 |
  % 8
  b ais b a8 b |
  % 9
  cis4 d e8 fis gis4 |
  % 10
  cis,2 s4 cis |
  % 11
  b8 a g4 a b8 cis |
  % 12
  d2. a4 |
  % 13
  a2. a4 |
  % 14
  a a a a |
  % 15
  a b8 cis fis,4 e' |
  % 16
  d g, d'8 e fis4 |
  % 17
  fis8 d b e e4 d |
  % 18
  cis8 fis e d cis4 b |
  % 19
  e, a a a |
  % 20
  a e'8 d e d cis4 |
  % 21
  cis8 b cis e d4 e |
  % 22
  e d e8 a, a4 |
  % 23
  d2. cis4 |
  % 24
  a1 |
  % 25
  
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
  b, fis' g fis |
  % 3
  e d cis b |
  % 4
  a2 s4 ais |
  % 5
  b e d g |
  % 6
  fis b a a, |
  % 7
  d2. cis4 |
  % 8
  b fis' g fis |
  % 9
  e d cis b |
  % 10
  a2 s4 ais |
  % 11
  b e d g |
  % 12
  fis b a a, |
  % 13
  d2. d4 |
  % 14
  d8 cis d4 a d8 e |
  % 15
  fis4 e d cis |
  % 16
  d e fis8 e d cis |
  % 17
  b4 e a, d |
  % 18
  a' a,8 b cis d e d |
  % 19
  cis b cis a d4 a'8 gis |
  % 20
  fis4 e8 fis g4 ais, |
  % 21
  b fis b gis |
  % 22
  a b cis d8 e |
  % 23
  fis g a2 a,4 |
  % 24
  d1 |
  % 25
  
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
  s4*9 a'''2 gis4 |
  % 4
  a2 s4*7 d2 cis4 |
  % 7
  d2. s1. a2 gis4 |
  % 10
  a2 s4*7 d2 cis4 |
  % 13
  d2. a4 |
  % 14
  a8*9 d4 cis8 d4 cis8 b |
  % 16
  a8*5 g8 fis e |
  % 17
  fis16 gis a4 gis8 a4 a,8 a16 a |
  % 18
  a8 a16 a a8 a16 a a4 s2 cis'4 d s1 fis,,8 fis16 fis |
  % 21
  fis8 fis16 fis fis8 fis16 fis fis4 s1 a'4. g8 fis e16 d e4 
  cis' |
  % 24
  d1 |
  % 25
  
}

trackF = <<
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


trackGchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 6
  
}

trackGchannelB = \relative c {
  s4*9 fis''4 e d |
  % 4
  e2 s4*7 d8 e fis g a4 |
  % 7
  a2. s1. fis4 e d |
  % 10
  e2 s4*7 d8 e fis g a4 |
  % 13
  a2. d,4 |
  % 14
  e fis g fis8 g |
  % 15
  a4 g fis a8 g |
  % 16
  fis4 e d4. a8 |
  % 17
  d16 e fis8 e4 e a,8 a16 a |
  % 18
  a8 a16 a a8 a16 a a4 s2 e'4 fis s1 fis,8 fis16 fis |
  % 21
  fis8 fis16 fis fis8 fis16 fis fis4 s1 fis'8 e |
  % 23
  d4 a'4. g16 fis e4 |
  % 24
  fis1 |
  % 25
  
}

trackG = <<
  \context Voice = channelA \trackGchannelA
  \context Voice = channelB \trackGchannelB
>>


trackHchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 7
  
}

trackHchannelB = \relative c {
  s4*9 d''4 a d, |
  % 4
  a'2 s4*7 fis4 a e' |
  % 7
  fis2. s1. d4 a d, |
  % 10
  a'2 s4*7 fis4 a e' |
  % 13
  fis2. fis,4 |
  % 14
  a d e d8 a |
  % 15
  d,4 a' a e' |
  % 16
  fis8 d g e a a, s2. a4 a8 a16 a |
  % 18
  a8 a16 a a8 a16 a a4 s2 a4 a s1 fis8 fis16 fis |
  % 21
  fis8 fis16 fis fis8 fis16 fis fis4 s1 d'8 a |
  % 23
  fis4 s8 d'16 d d8 d16 d a8 a |
  % 24
  a1 |
  % 25
  
}

trackH = <<
  \context Voice = channelA \trackHchannelA
  \context Voice = channelB \trackHchannelB
>>


trackIchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 8
  
}

trackIchannelB = \relative c {
  s4*9 d4 a d |
  % 4
  a2 s4*7 d4 a a |
  % 7
  d2. s1. d4 a d |
  % 10
  a2 s4*7 d4 a a |
  % 13
  d2. d4 |
  % 14
  a d a d |
  % 15
  d a d a |
  % 16
  d a d s2. a4 d8 d16 d |
  % 18
  a8 a16 a a8 a16 a a4 s2 a4 d s1*3 d8 a |
  % 23
  d4 s8 d a a16 a a8 a |
  % 24
  d1 |
  % 25
  
}

trackI = <<

  \clef bass
  
  \context Voice = channelA \trackIchannelA
  \context Voice = channelB \trackIchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
    \context Staff=trackF \trackF
    \context Staff=trackG \trackG
    \context Staff=trackH \trackH
    \context Staff=trackI \trackI
  >>
}
