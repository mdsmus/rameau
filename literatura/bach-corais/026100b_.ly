% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 026100b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key b \minor
  
  \tempo 4 = 96 
  \skip 1*18 
  \time 2/4 
  \skip 2 |
  % 20
  
  \time 4/4 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d''4 |
  % 2
  a b8 cis d e fis4 |
  % 3
  e d2 cis4 |
  % 4
  d2 s4 fis |
  % 5
  e d cis8 b a4 |
  % 6
  b cis8 d e2. d4 cis2 |
  % 8
  b s4 d |
  % 9
  a b8 cis d e fis4 |
  % 10
  e d2 cis4 |
  % 11
  d2 s4 fis |
  % 12
  e d cis8 b a4 |
  % 13
  b cis8 d e2. d4 cis2 |
  % 15
  b s4 fis' |
  % 16
  g e fis d |
  % 17
  e fis b, fis' |
  % 18
  g e fis d |
  % 19
  e fis b,2 |
  % 20
  s4 d cis b |
  % 21
  a b g g |
  % 22
  fis s2 b4 |
  % 23
  a d2 cis4 |
  % 24
  d s2 a4 |
  % 25
  b cis d8 e fis2 e4 e d |
  % 27
  cis cis b1 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. fis'8 g |
  % 2
  a4 g a ais8 b |
  % 3
  cis4 fis, e e |
  % 4
  fis2 s4 a |
  % 5
  a8 g fis4 g fis |
  % 6
  g2. fis8 gis |
  % 7
  ais4 b8 a g4 fis8 e |
  % 8
  d2 s4 fis8 g |
  % 9
  a4 g a ais8 b |
  % 10
  cis4 fis, e e |
  % 11
  fis2 s4 a |
  % 12
  a8 g fis4 g fis |
  % 13
  g2. fis8 gis |
  % 14
  ais4 b8 a g4 fis8 e |
  % 15
  d2 s4 b' |
  % 16
  b a a g |
  % 17
  g fis fis b |
  % 18
  b a a g8 fis |
  % 19
  e4 a g2 |
  % 20
  s4 fis f fis8 gis |
  % 21
  cis,4 fis fis e |
  % 22
  dis s2 e a g4 |
  % 24
  fis s2 fis4 |
  % 25
  e e d d'8 cis |
  % 26
  b ais b cis ais4 b8 a |
  % 27
  g4 fis8 e dis1 
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
  d d d d |
  % 3
  cis d8 cis b4 a |
  % 4
  a2 s4 d |
  % 5
  cis d e8 d cis4 |
  % 6
  d e ais,8 b cis2 b ais4 |
  % 8
  b2 s4 a |
  % 9
  d d d d |
  % 10
  cis d8 cis b4 a |
  % 11
  a2 s4 d |
  % 12
  cis d e8 d cis4 |
  % 13
  d e ais,8 b cis2 b ais4 |
  % 15
  b2 s4 d |
  % 16
  d8 b cis4 cis8 a b4 |
  % 17
  b cis d fis |
  % 18
  e e d d8 cis |
  % 19
  b4 b b2 |
  % 20
  s4 b b8 a4 gis8 |
  % 21
  fis4 fis g8 a b cis |
  % 22
  dis4 s2 b8 cis16 d |
  % 23
  cis4 d8 e fis4 e |
  % 24
  d s2 d4 |
  % 25
  gis, ais b8 cis d2 cis b ais4 b1 
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
  s2. d8 e |
  % 2
  fis4 g fis4. gis8 |
  % 3
  ais4 b8 a gis4 a |
  % 4
  d,2 s4 d' |
  % 5
  a b e, fis2 e8 d cis b ais cis |
  % 7
  fis4 g8 fis e4 fis |
  % 8
  b,2 s4 d8 e |
  % 9
  fis4 g fis4. gis8 |
  % 10
  ais4 b8 a gis4 a |
  % 11
  d,2 s4 d' |
  % 12
  a b e, fis2 e8 d cis b ais cis |
  % 14
  fis4 g8 fis e4 fis |
  % 15
  b,2 s4 b' |
  % 16
  e, a d, g8 fis |
  % 17
  e4 ais, b d' |
  % 18
  d cis cis b8 a |
  % 19
  g fis e dis e2 |
  % 20
  s4 b cis dis8 f |
  % 21
  fis4 dis e8 fis g a |
  % 22
  b4 s2 g fis8 g a4 a, |
  % 24
  d s2 d4 |
  % 25
  d' cis b4. a8 |
  % 26
  g fis g e fis4 g8 fis |
  % 27
  e4 fis b,1 
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
