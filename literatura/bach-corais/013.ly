% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 013.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key c \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. c''4 |
  % 2
  g a8 b c d e4 |
  % 3
  d c2 b4 |
  % 4
  c2. e4 |
  % 5
  d c b8 a g4 |
  % 6
  a b8 c d4 c8 b |
  % 7
  c4 b a c |
  % 8
  g a8 b c d e4 |
  % 9
  d c2 b4 |
  % 10
  c2. e4 |
  % 11
  d c b8 a g4 |
  % 12
  a b8 c d4 c8 b |
  % 13
  c4 b a e' |
  % 14
  f8 e d4 e8 d c4 |
  % 15
  d e a, e' |
  % 16
  f8 e d4 e8 d c4 |
  % 17
  d e a, c |
  % 18
  b a g a |
  % 19
  f8 e f4 e a |
  % 20
  g c2 b4 |
  % 21
  c g a b |
  % 22
  c8 d e4 d c |
  % 23
  b b a 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. e'4 |
  % 2
  e8 d c d e f g4 |
  % 3
  g4. fis8 g2 |
  % 4
  g2. g4 |
  % 5
  g8 f e4 e8*5 fis8 gis a b4 a |
  % 7
  a gis e e |
  % 8
  e8 d c d e f g4 |
  % 9
  g4. fis8 g2 |
  % 10
  g2. g4 |
  % 11
  g8 f e4 e8*5 fis8 gis a b4 a |
  % 13
  a gis e a |
  % 14
  a a gis e |
  % 15
  a g f e |
  % 16
  a a8 g g4 g |
  % 17
  a b e, g |
  % 18
  g8 fis e4 e8 g f e |
  % 19
  d cis d4 cis c |
  % 20
  d g8 f e4 d |
  % 21
  e e fis gis |
  % 22
  a e a2. gis4 e 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. a'8 b |
  % 2
  c b a4 g g8 a |
  % 3
  b a16 b c8 d e4 d |
  % 4
  e2. c4 |
  % 5
  b4. a8 g a b4 |
  % 6
  c d8 e f e e4 |
  % 7
  f8 d b c16 d c4 a8 b |
  % 8
  c b a4 g g8 a |
  % 9
  b a c d e4 d |
  % 10
  e2. c4 |
  % 11
  b4. a8 g a b4 |
  % 12
  c d8 e f e e4 |
  % 13
  f8 d b c16 d c4 c |
  % 14
  c b8 a b4 c8 b |
  % 15
  a4 a d b |
  % 16
  c d c c |
  % 17
  c b c e |
  % 18
  d e b cis |
  % 19
  a a a a |
  % 20
  b8 a g2 g4 |
  % 21
  g e' d d |
  % 22
  e8 d c b a b c d16 e |
  % 23
  f4 e8 d cis4 
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
  s2. a'4 |
  % 2
  e f e8 d c4 |
  % 3
  g' a g g |
  % 4
  c,2. c4 |
  % 5
  g' a e4. d8 |
  % 6
  c c' b a gis4 a |
  % 7
  d, e a, a' |
  % 8
  e f e8 d c4 |
  % 9
  g' a g g |
  % 10
  c,2. c4 |
  % 11
  g' a e4. d8 |
  % 12
  c c' b a gis4 a |
  % 13
  d, e a, a' |
  % 14
  d,8 e f4 e a8 g |
  % 15
  f e d cis d4 gis |
  % 16
  a b c e, |
  % 17
  fis gis a e8 fis |
  % 18
  g4 cis,8 dis e4 a, |
  % 19
  d8 f e d a'4 f2 e8 d e f g4 |
  % 21
  c, c' c8 d c b |
  % 22
  a b a g f4. e8 |
  % 23
  d4 e a, 
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
