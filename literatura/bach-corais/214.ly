% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 214.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  g''4 g a b |
  % 2
  c c b2 |
  % 3
  a b4 c |
  % 4
  d a g f |
  % 5
  e1 |
  % 6
  g4 g a b |
  % 7
  c c b2 |
  % 8
  a b4 c |
  % 9
  d a g f |
  % 10
  e1 |
  % 11
  s4 d e f |
  % 12
  g4. f8 e4 d |
  % 13
  c2 s4 c |
  % 14
  g' g a b |
  % 15
  c c b2 |
  % 16
  a b4 c |
  % 17
  d a g f |
  % 18
  e2 s4 a |
  % 19
  g e f g8. f16 |
  % 20
  e2 s4 a |
  % 21
  g e f g |
  % 22
  e2 a4 g |
  % 23
  a b c b8 a |
  % 24
  g4 f e d |
  % 25
  a'2 g4 f |
  % 26
  e2 a4 g |
  % 27
  a b c8 b a4 |
  % 28
  g2 c4 b |
  % 29
  d a g f |
  % 30
  e2 s4 d |
  % 31
  a'2 g4 f |
  % 32
  e1 |
  % 33
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  e'4 e e e |
  % 2
  e8 fis16 gis a4 a gis |
  % 3
  e2 g4 g |
  % 4
  a8 g f4. e4 d16 c |
  % 5
  b1 |
  % 6
  e4 e e e |
  % 7
  e8 fis16 gis a4 a gis |
  % 8
  e2 g4 g |
  % 9
  a8 g f4. e4 d16 c |
  % 10
  b1 |
  % 11
  s4 b c8 b c4 |
  % 12
  d8 e4 d c b8 |
  % 13
  g2 s4 g |
  % 14
  c4. e8 f4. e8 |
  % 15
  e a16 gis a4. gis16 fis gis4 |
  % 16
  e2 gis4 a4. g8 f4 e4. d8 |
  % 18
  cis2 s4 f8 e |
  % 19
  d4. c8 d4 d |
  % 20
  c2 s4 e |
  % 21
  d4. c16 b a4 d8 b |
  % 22
  c2 e4 e |
  % 23
  e e e8 f g f4 e d16 c b4 ais |
  % 25
  c f4. e4 d8 |
  % 26
  c2 e4. d8 |
  % 27
  c4 d e8 g4 fis8 |
  % 28
  g2 g4 g |
  % 29
  a8 g f e d e a, d |
  % 30
  cis2 s4 d |
  % 31
  d c8 d e4. d16 c |
  % 32
  b1 |
  % 33
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  b'4 b c b |
  % 2
  a4. e'8 f d b e16 d |
  % 3
  c2 d4 e |
  % 4
  f8 e d4. c16 ais a8 b16 a |
  % 5
  gis1 |
  % 6
  b4 b c b |
  % 7
  a4. e'8 f d b e16 d |
  % 8
  c2 d4 e |
  % 9
  f8 e d4. c16 ais a8 b16 a |
  % 10
  gis1 |
  % 11
  s4 g g c8 a |
  % 12
  b4 c8 g g16*7 f16 |
  % 13
  e2 s4 g |
  % 14
  g c c8 d d4 |
  % 15
  c8 d e4. b8 e d |
  % 16
  c2 e4 e |
  % 17
  d4. c8 ais4 a |
  % 18
  a2 s4 c4. b8 a4 a g8 b |
  % 20
  c2 s4 c |
  % 21
  b g f8 e d g |
  % 22
  g2 c4 b |
  % 23
  c b a d |
  % 24
  g,8 c16 b a8 b16 a gis4 g |
  % 25
  a d4. b8 c g |
  % 26
  g2 c4 c8 ais |
  % 27
  a g f4 g8 e' a, d16 c |
  % 28
  b2 e4 d8 e |
  % 29
  f e d c b cis d a |
  % 30
  a2 s4 a8 g |
  % 31
  f e f4 e8 a a b16 a |
  % 32
  gis1 |
  % 33
  
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
  e4 e8 d c b a gis |
  % 2
  a4. c8 d b e4 |
  % 3
  a,2 g'8 f e4 |
  % 4
  d8 e f4 b,8 c d4 |
  % 5
  e1 |
  % 6
  e4 e8 d c b a gis |
  % 7
  a4. c8 d b e4 |
  % 8
  a,2 g'8 f e4 |
  % 9
  d8 e f4 b,8 c d4 |
  % 10
  e1 |
  % 11
  s4 g8 f e4 a |
  % 12
  g8 g, a b c4 g |
  % 13
  c,2 s4 e'8 f |
  % 14
  e d e c f4 gis, |
  % 15
  a8 b c d e2 |
  % 16
  a, e'4 a8 g |
  % 17
  f e d4. cis8 d f |
  % 18
  a2 s4 f, |
  % 19
  g a d8 c b g |
  % 20
  a2 s4 a |
  % 21
  b c d b8 g |
  % 22
  c2 a8 c e d |
  % 23
  c b a gis a4 b |
  % 24
  c d e g |
  % 25
  f8 e d c b g a b |
  % 26
  c2 c8 d e4 |
  % 27
  f8 e d4 c d |
  % 28
  e2 e8 f g4 |
  % 29
  d8 e f4. e8 d f |
  % 30
  a2 s4 f8 e |
  % 31
  d4 a8 b c cis d4 |
  % 32
  e1 |
  % 33
  
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
