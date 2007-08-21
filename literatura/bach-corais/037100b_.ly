% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 037100b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key c \major
  
  \tempo 4 = 80 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  g''2 a |
  % 2
  b a4 c |
  % 3
  c b a a |
  % 4
  g2 a4 a |
  % 5
  g f e e |
  % 6
  d2 d4 a' |
  % 7
  a g a b |
  % 8
  c b a2 |
  % 9
  g g4 f8 g |
  % 10
  a4 g g f |
  % 11
  e1 |
  % 12
  e2 d |
  % 13
  g a4 b |
  % 14
  c c c2 |
  % 15
  c4 c b a |
  % 16
  g a b b |
  % 17
  b2 e,4 d |
  % 18
  g a8 b c4 c |
  % 19
  c2 c4 c |
  % 20
  b a g a |
  % 21
  a g f e |
  % 22
  d2 d4 a' |
  % 23
  a g a b |
  % 24
  c b a2 |
  % 25
  g g4 f8 g |
  % 26
  a4 g g f |
  % 27
  e1 |
  % 28
  b'2 c |
  % 29
  d s4 b |
  % 30
  d c b a |
  % 31
  g2 b4 c |
  % 32
  d b8 c d4 c |
  % 33
  b a g a |
  % 34
  a g f e |
  % 35
  d2 d4 a' |
  % 36
  a g a b |
  % 37
  c b a2 |
  % 38
  g g4 f8 g |
  % 39
  a4 g g f |
  % 40
  e1. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  e'8 f g4. fis16 e fis4 |
  % 2
  g2 f4 e |
  % 3
  a g4. fis16 e fis4 |
  % 4
  d2 f8 e d cis |
  % 5
  d cis d4. cis16 b cis4 |
  % 6
  a2 d4 e |
  % 7
  f16 e d4 e16 d c8 f4 e8. fis16 g4 g fis16 e fis4 |
  % 9
  d2 e4 d |
  % 10
  c8 d e4 e d |
  % 11
  c b8 a b2 |
  % 12
  b4 c8 b a4 b8 c |
  % 13
  d f e d c d16 e f4 |
  % 14
  e16 f g4 f e16 d e4 |
  % 15
  e16 fis g4 fis e16 d cis b a8 |
  % 16
  d c4 a' g8 fis16 e fis8 |
  % 17
  e2 c4. b8 |
  % 18
  c d16 e f e f8 e4 f4. e16 d e4 e8 a16 gis a4. g4 fis8 d4 f8 
  g |
  % 21
  a g16 f f8 e4 d cis8 |
  % 22
  a2 a4 d16 e f8 |
  % 23
  f4. e8. d16 e g f e fis a |
  % 24
  g8 d d g4 fis16 e fis4 |
  % 25
  d2 e4 f8 e |
  % 26
  f4. e16 d e4. d16 c |
  % 27
  b8 d c2 b4 |
  % 28
  g'2 g |
  % 29
  g s4 g |
  % 30
  g4. a4 g fis8 |
  % 31
  d2 g4 a4. g16 fis g4 g4. fis8 |
  % 33
  b,16 c d8 e d16 c b4 d |
  % 34
  d8 dis d cis d4. cis8 |
  % 35
  a2 d4 e |
  % 36
  a,8 fis'4 e8 fis4. e16 dis |
  % 37
  e8 d4 g fis16 e fis4 |
  % 38
  d2 d8 e d e |
  % 39
  f e d g cis, a d4 |
  % 40
  cis c b1 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  b'4. c16 d e8 a, d4 |
  % 2
  d2 d4 c8 d |
  % 3
  e8*5 c8 a d16 c |
  % 4
  b2 d8 c16 ais a4 |
  % 5
  ais a8 d ais g e a16 g |
  % 6
  f2 f4 e8 a |
  % 7
  a d16 c b8 c16 b a8 c d c16 b |
  % 8
  a8 g16 a b8 c16 d e8 c a d |
  % 9
  b2 c4. ais8 |
  % 10
  a b c ais a ais4 a8 |
  % 11
  a4 gis8 fis gis2 |
  % 12
  g4 a8 g fis4 g4. d'8 c b a4. g16 f |
  % 14
  g8 c16 ais a4 g2 |
  % 15
  a4 a b8 g e' d16 c |
  % 16
  b8 c16 ais a8 d16 c b8 d8. c16 b a |
  % 17
  g2 g4 g |
  % 18
  g c8 d g,4 a4. g16 f g4 c8 d e4. d8 e d16 c b4 d4. cis8 d a 
  a4 ais8 a16 g |
  % 22
  f2 f8 g a d |
  % 23
  d b g c16 b a4. g16 fis |
  % 24
  e8 a b e4 c8 a d16 c |
  % 25
  b2 c4. ais8 |
  % 26
  c16 ais c8 d g, c ais a b16 a |
  % 27
  gis4 a2 gis4 |
  % 28
  e'2 e |
  % 29
  b s4 d |
  % 30
  d e8 d d4 e8 d16 c |
  % 31
  b2 e4 e |
  % 32
  d d8 c b4. a4 g fis8 g4 f8 g |
  % 34
  a c4 ais b8 e, a16 g |
  % 35
  fis2 b4 cis |
  % 36
  d4. c16 b c8 fis,4 g16 a |
  % 37
  g8 a4 g8 e'16 d c4 b16 a |
  % 38
  b2 b8 ais a g |
  % 39
  f4. e16 d e8 f16 g a8 b4 a16 gis a4. gis16 fis gis2. 
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
  e4. d8 c4 d |
  % 2
  g,2 d'4 a8 b |
  % 3
  c d e d c a d4 |
  % 4
  g,2 d'8 e f4. e8 f ais g e a a, |
  % 6
  d2 d4. cis8 |
  % 7
  d f4 e8 f a4 gis8 |
  % 8
  a e4 d8 c a d4 |
  % 9
  g,2 c4 d8 e |
  % 10
  f4 c cis d |
  % 11
  e1 |
  % 12
  e8 d c2 b8 a |
  % 13
  b4 e2 d4 |
  % 14
  e f c2 |
  % 15
  a4 d g,8 g'4 f e8 f fis g b,16 c d8 dis |
  % 17
  e2 e8 c g' f |
  % 18
  e4. d8 c b a b |
  % 19
  c2 a8 b c d |
  % 20
  e b c d g,4 d'8 e |
  % 21
  f a, b cis d f, g a |
  % 22
  d,2 d'8 e f d |
  % 23
  ais b c4. cis8 d dis |
  % 24
  e fis g e c a d4 |
  % 25
  g,2 c8 ais a g |
  % 26
  f a ais b c cis d4. c16 b c8 d e2 |
  % 28
  e,4 e'2 d8 c |
  % 29
  g'2 s4 g,8 a |
  % 30
  b4 e,8 fis g b c d |
  % 31
  g,2 e8 e' d c |
  % 32
  b b'4 a8 g fis e4. b8 c d g,4 d'8 e |
  % 34
  f fis g4. gis8 a a, |
  % 35
  d2 g,8 g'4 fis16 e |
  % 36
  fis8 b e,4. dis16 cis dis8 b |
  % 37
  e fis g e c a d4 |
  % 38
  g,2 g'8 cis, d4. c8 b ais a4. gis8 |
  % 40
  a b c d e1 
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
