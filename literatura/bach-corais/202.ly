% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 202.mid
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
  a''4 a a a |
  % 2
  b2 a |
  % 3
  g4 fis e e |
  % 4
  d1 |
  % 5
  a'4 a a a |
  % 6
  b2 g |
  % 7
  b4 b c b |
  % 8
  a1 |
  % 9
  a4 a a a |
  % 10
  d2 a4 a |
  % 11
  b b a a |
  % 12
  g1 |
  % 13
  a4 a a a |
  % 14
  a2 fis |
  % 15
  g4 fis e4. d8 |
  % 16
  d1 |
  % 17
  a'2 b |
  % 18
  c1 |
  % 19
  a2 gis |
  % 20
  a1 |
  % 21
  d2. e4 |
  % 22
  a,2 b |
  % 23
  cis1 |
  % 24
  a2. gis4 |
  % 25
  a1 |
  % 26
  a4. g8 fis4 g |
  % 27
  e2 d |
  % 28
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  fis'4 g fis8 g a4. g16 fis g2 fis4 |
  % 3
  e4. d4 cis16 b cis4 |
  % 4
  a1 |
  % 5
  d4 cis8 d e cis d e |
  % 6
  fis g fis4 e2 |
  % 7
  g4 gis a4. gis8 |
  % 8
  e1 |
  % 9
  fis4 fis8 e fis g a2 g4 fis fis |
  % 11
  e8 dis e4 e d8 c |
  % 12
  b1 |
  % 13
  e8 cis d e fis4 fis |
  % 14
  e8 g fis e e dis16 cis dis4 |
  % 15
  e d8 d cis16 b cis4 d8 |
  % 16
  a1 |
  % 17
  fis'2 f4 e |
  % 18
  e f8 g a4 g2 f4 e2 |
  % 20
  e1 |
  % 21
  b'2. a8 g |
  % 22
  fis8*5 gis8 a4 |
  % 23
  gis2. cis,2 d8 e fis4 e8 d |
  % 25
  e1 |
  % 26
  cis8 d e4. d8 d4. cis16 b cis4 a2 |
  % 28
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  d'4 e e d |
  % 2
  d2 d8*5 cis16 b a4 b a8 g |
  % 4
  fis1 |
  % 5
  fis4 e a8 g fis4. e8 b'4 b2 |
  % 7
  e4 e e8 a, f' e |
  % 8
  cis1 |
  % 9
  d4 d8 cis d e fis e |
  % 10
  d c d4 d d8 c |
  % 11
  b a g4. fis16 e fis4 |
  % 12
  g1 |
  % 13
  e8 g fis e d a' d4 |
  % 14
  d8 cis c4 b2 |
  % 15
  b4 b b8 g e a |
  % 16
  fis1 |
  % 17
  a4 d2 c8 b |
  % 18
  a4 g f e |
  % 19
  d d'2 c8 b |
  % 20
  cis1 |
  % 21
  fis,4 e8 fis g4 e |
  % 22
  fis8 gis a2 fis4 |
  % 23
  cis' b8 a gis fis gis4 |
  % 24
  a b8 cis d2. d4 cis b |
  % 26
  a16*9 b16 c4 b16 a |
  % 27
  b8 e,4 fis16 g fis2 |
  % 28
  
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
  d4. cis8 d e fis d |
  % 2
  g4 g, d'2 |
  % 3
  e4 fis g a8 a, |
  % 4
  d1 |
  % 5
  d4 a8 b cis a d cis |
  % 6
  dis e4 dis8 e2 |
  % 7
  e8 d c b a f d e |
  % 8
  a1 |
  % 9
  d8 e fis g fis e d c |
  % 10
  b a b cis d4 d |
  % 11
  g8 fis e d c cis d dis |
  % 12
  e1 |
  % 13
  cis8 a b cis d e fis g |
  % 14
  a4 a, b2 |
  % 15
  e,8 g b a g e a4 |
  % 16
  d,1 |
  % 17
  d'2 gis, |
  % 18
  a2. b8 c |
  % 19
  d4 b e2 |
  % 20
  a,1 |
  % 21
  b2. cis4 |
  % 22
  d2 dis |
  % 23
  e f |
  % 24
  fis b, |
  % 25
  a1 |
  % 26
  fis'4 cis d g, |
  % 27
  gis a d,2 |
  % 28
  
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
