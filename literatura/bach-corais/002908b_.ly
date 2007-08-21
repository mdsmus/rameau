% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 002908b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key d \major
  
  \tempo 4 = 116 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2 d''4 d2 cis4 b2 |
  % 3
  a4 d e2 |
  % 4
  fis fis4 fis8 e |
  % 5
  fis2 fis |
  % 6
  e4 d8 e e2 |
  % 7
  d d4 d2 cis4 b2 |
  % 9
  a4 d e2 |
  % 10
  fis fis4 fis8 e |
  % 11
  fis2 fis |
  % 12
  e4 d8 e e2 |
  % 13
  d d4 d |
  % 14
  e fis e2 |
  % 15
  fis8 e d e cis2 |
  % 16
  b e4 e |
  % 17
  d cis d8 cis b2 a a4 |
  % 19
  d2 d4 e2 e4 fis e |
  % 21
  fis d2 d4 |
  % 22
  g2 g4 fis8 e |
  % 23
  fis2 e |
  % 24
  e4 fis2 fis4 |
  % 25
  g2 g4 a4. g8 fis e d2 |
  % 27
  fis4 e d cis |
  % 28
  d8 cis b2 a a4 d2 |
  % 30
  cis4 b2 a4 |
  % 31
  e' fis2 e fis4 g fis |
  % 33
  e fis8 g e2 |
  % 34
  d 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2 a''4 b |
  % 2
  a a a g |
  % 3
  a8 g fis4 b a |
  % 4
  a2 a4 a2 cis4 fis, b |
  % 6
  e, a b a8 e |
  % 7
  fis2 a4 b |
  % 8
  a a a g |
  % 9
  a8 g fis4 b a |
  % 10
  a2 a4 a2 cis4 fis, b |
  % 12
  e, a b a8 e |
  % 13
  fis2 a4 b |
  % 14
  a a a8 b a g |
  % 15
  fis4 fis g8 fis e fis |
  % 16
  d2 e4 e2 e4 a2 |
  % 18
  gis4 e2 e4 |
  % 19
  d8 e fis4 b b |
  % 20
  a a a1 g4 g8 a |
  % 22
  b4 a8 g c b a g |
  % 23
  c4 b8 a g2 |
  % 24
  a4 a b2. a8 g c b a g |
  % 26
  a2. g4 |
  % 27
  a b2 a4 |
  % 28
  a2 gis4 e2 e4 a8 gis a b |
  % 30
  e,4 fis cis cis8 d |
  % 31
  e4 a2 a a4 b a |
  % 33
  g fis g8 fis e4 |
  % 34
  fis2 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2 fis'4 fis2 fis8 e d4 e8 d |
  % 3
  cis4 d2 cis4 |
  % 4
  d2 d4 d2 cis4 d2 |
  % 6
  cis4 d2 cis4 |
  % 7
  a2 fis'4 fis2 fis8 e d4 e8 d |
  % 9
  cis4 d2 cis4 |
  % 10
  d2 d4 d2 cis4 d2 |
  % 12
  cis4 d2 cis4 |
  % 13
  a2 d4 g |
  % 14
  cis, d d cis |
  % 15
  cis b2 ais4 |
  % 16
  b2 gis8 a b gis |
  % 17
  a b cis b a4 fis' |
  % 18
  e8 d cis2 cis8 b |
  % 19
  a4 d2. |
  % 20
  cis8 b cis4 d a |
  % 21
  d b2 b4 |
  % 22
  e2 e4 e2 dis4 b2 |
  % 24
  cis4 d2 d4 |
  % 25
  g, e'2. |
  % 26
  d4. c8 b2 |
  % 27
  d8 cis b4 e2 |
  % 28
  d8 e fis4 e8 d cis2 cis4 cis b |
  % 30
  a a gis a |
  % 31
  a2 d4 cis2 d4 d2 |
  % 33
  a4 d2 cis4 |
  % 34
  a2 
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s2 d'8 cis b4 |
  % 2
  fis2 g8 fis e4 |
  % 3
  fis b8 a g4 a |
  % 4
  d,2 d4 d'4. cis8 b ais b a g fis |
  % 6
  g e fis4 g a |
  % 7
  d,2 d'8 cis b4 |
  % 8
  fis2 g8 fis e4 |
  % 9
  fis b8 a g4 a |
  % 10
  d,2 d4 d'4. cis8 b ais b a g fis |
  % 12
  g e fis4 g a |
  % 13
  d,2 fis4 g8 a |
  % 14
  g fis e d a'2 |
  % 15
  ais4 b e, fis |
  % 16
  b,2 cis4 gis'8 e |
  % 17
  fis gis a gis fis e d4 |
  % 18
  e a,2 a'8 g |
  % 19
  fis4 b8 a g fis g e |
  % 20
  a g fis e d e d cis |
  % 21
  d fis g2 g8 fis |
  % 22
  e4 fis8 g a b c4 |
  % 23
  a b e,2 |
  % 24
  a4 d8 cis b a g fis |
  % 25
  e d' c b a g fis g |
  % 26
  fis e d4 g2 |
  % 27
  d'4 gis,8 e fis gis a gis |
  % 28
  fis e d4 e a,2 a'8 gis fis e fis gis |
  % 30
  a4 dis,8 cis dis f fis e |
  % 31
  d cis d2 a d8 cis b a b d |
  % 33
  cis e d4 g, a |
  % 34
  d2 
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
  s1*2 a4 d s4 a |
  % 4
  d2 s1. a4 d s4 a |
  % 7
  d2 s1. a4 d s4 a |
  % 10
  d2 s1. a4 d s4 a |
  % 13
  d2 s4*69 d4 |
  % 31
  a d2 a s2. |
  % 33
  a4 d s4 a |
  % 34
  d2 
}

trackF = <<

  \clef bass
  
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


trackGchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 6
  
}

trackGchannelB = \relative c {
  s1*2 a'''4 d, g8 fis e g |
  % 4
  fis2 s1. a4 d, g8 fis e g |
  % 7
  fis2 s1. a4 d, g8 fis e g |
  % 10
  fis2 s1. a4 d, g8 fis e g |
  % 13
  fis2 s4*69 a4. g8 fis e fis gis a2 s2. |
  % 33
  a4 d, b'8 a g a |
  % 34
  fis2 
}

trackG = <<
  \context Voice = channelA \trackGchannelA
  \context Voice = channelB \trackGchannelB
>>


trackHchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 7
  
}

trackHchannelB = \relative c {
  s1*2 fis''4 fis e2 |
  % 4
  d s1. e4 a e2 |
  % 7
  d s1. fis4 fis e2 |
  % 10
  d s1. e4 a e2 |
  % 13
  d s4*69 fis4 |
  % 31
  e d2 e s2. |
  % 33
  e4 fis8 g e2 |
  % 34
  d 
}

trackH = <<
  \context Voice = channelA \trackHchannelA
  \context Voice = channelB \trackHchannelB
>>


trackIchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 8
  
}

trackIchannelB = \relative c {
  s1*2 fis'8 a d4 d, a' |
  % 4
  a2 s1. a4 a s4 a |
  % 7
  a2 s1. fis8 a d4 d, a' |
  % 10
  a2 s1. a4 a s4 a |
  % 13
  a2 s4*69 d,4 |
  % 31
  a' a2 a s2. |
  % 33
  a4 a' s4 a, |
  % 34
  a2 
}

trackI = <<
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
