% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 042500b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  d,4. e8 f4 g |
  % 3
  a8 b c4 b a |
  % 4
  a gis a a |
  % 5
  g g c a |
  % 6
  ais8 a g f g4. f8 |
  % 7
  f2 s4 a |
  % 8
  d, e f g |
  % 9
  a8 b c4 b4. a8 |
  % 10
  a2 s4 a |
  % 11
  g g c a |
  % 12
  ais8 a g f e4. d8 |
  % 13
  d2 s4 a' |
  % 14
  g8 a f g e4. d8 |
  % 15
  d2 s4 a' |
  % 16
  a b c c |
  % 17
  b2 a4 a |
  % 18
  g g c a |
  % 19
  ais8 a g f g4. f8 |
  % 20
  f2 s4 a |
  % 21
  d, e f8 g a4 |
  % 22
  d,2 s4 e |
  % 23
  f e f g |
  % 24
  a b c8 b a4 |
  % 25
  d c ais8 a g f |
  % 26
  e4. d8 d2 |
  % 27
  
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
  a b8 cis d f4 e8 |
  % 3
  f g g a g f e4 |
  % 4
  f e e e8 f4 e16 d e8 f g e f4 |
  % 6
  f e8 f4 e16 d e4 |
  % 7
  c2 s4 d4. a8 ais a4 d cis8 |
  % 9
  d4 g8 f4 d8 b e16 d |
  % 10
  c2 s4 f4. e16 d e8 f g e f a |
  % 12
  g f e d d cis16 b cis4 |
  % 13
  a2 s4 f' |
  % 14
  e d4. cis16 b cis4 |
  % 15
  d2 s4 c |
  % 16
  c8 d16 e f8 e16 d g8 f16 g a4. gis16 fis gis4 e f |
  % 18
  f f8 e16 d e4 f |
  % 19
  f16 e f8 e f4 e16 d e4 |
  % 20
  c2 s4 c |
  % 21
  b cis d cis |
  % 22
  d2 s4 cis |
  % 23
  d cis d8 c ais c |
  % 24
  c d16 e f8 e16 d e8 f16 g a8 g |
  % 25
  fis g a fis d4 e8 d4 cis16 b cis4 a2 |
  % 27
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. f8 g |
  % 2
  a4 g a c |
  % 3
  c8 d e4 d4. c8 |
  % 4
  b4. d8 c4 c |
  % 5
  d8 g, c4 c c |
  % 6
  d8 a c4 d8 ais g c16 ais |
  % 7
  a2 s4 f8 g |
  % 8
  a4 g f8 ais4. |
  % 9
  a8 g g a4 gis16 fis g4 |
  % 10
  e2 s4 c' |
  % 11
  d8 g, c4 c c8 f |
  % 12
  d cis4 d8 ais g4 a16 g |
  % 13
  f2 s4 d'8 c |
  % 14
  ais a a g16 a ais8 g e a16 g |
  % 15
  f2 s4 f8 g |
  % 16
  a b16 c d8 b g c16 b a8 c |
  % 17
  f d b e16 d cis4 d4. c16 b c4 c4. d16 c |
  % 19
  ais8 c c16 ais a8 g16 a ais4 c16 ais |
  % 20
  a2 s4 f |
  % 21
  g4. f16 g a4. g8 |
  % 22
  f2 s4 a |
  % 23
  a a a d8 c16 ais |
  % 24
  a8 b16 c d8 b g d' c4. ais8 a d4 c8 ais b |
  % 26
  e,16*5 f16 g8 fis2 |
  % 27
  
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
  f g f e d4 c |
  % 3
  f e8 fis g gis a c, |
  % 4
  d b e4 a, a |
  % 5
  b c8 d e c f dis |
  % 6
  d c ais a ais g c4 |
  % 7
  f,2 s4 d'8 e |
  % 8
  f4 cis d e |
  % 9
  f8 g16 f e8 f16 e d8 b e4 |
  % 10
  a,2 s4 a |
  % 11
  b c8 d e c f d |
  % 12
  g a ais a g e a a, |
  % 13
  d2 s4 d4. cis8 d ais g e a4 |
  % 15
  ais2 s4 f' |
  % 16
  f8 e d g e a16 g f8 e |
  % 17
  d b e4 a, d8 c |
  % 18
  b g c ais a g f4 |
  % 19
  g8 a16 ais c8 d ais g c c, |
  % 20
  f2 s4 f'2 e4 d a |
  % 22
  ais2 s4 a |
  % 23
  d8 f a g f4. e8 |
  % 24
  f e d g c, d16 e f8 e |
  % 25
  d e fis d g4. gis8 |
  % 26
  a4 a, d2 |
  % 27
  
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
