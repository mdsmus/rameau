% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 277.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key c \major
  
  \tempo 4 = 90 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. c''4 |
  % 2
  b a g8 f e4 |
  % 3
  a a g c |
  % 4
  b a g8 f e4 |
  % 5
  a a g g |
  % 6
  a b c8 d e4 |
  % 7
  d2 c4 c |
  % 8
  b a g8 f e4 |
  % 9
  a a g c |
  % 10
  b a g8 f e4 |
  % 11
  a a g g |
  % 12
  a b c8 d e4 |
  % 13
  d2 c4 c |
  % 14
  c d c a8 b |
  % 15
  c4. d8 b4 b |
  % 16
  c d c8 b a b |
  % 17
  c4. d8 b4 e |
  % 18
  f8 e d4 e8 d c4 |
  % 19
  c b c b |
  % 20
  c b a8 b g4 |
  % 21
  g8 a fis4 g e' |
  % 22
  d c b e |
  % 23
  f8 e d4 e8 d c b |
  % 24
  a d b4 c c |
  % 25
  c c d c |
  % 26
  c b c2 |
  % 27
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. g''4 |
  % 2
  g8 f e4 e e8 d |
  % 3
  c4 f e e8 f |
  % 4
  g4 f8 e d4 c8 d |
  % 5
  e dis e fis fis e e4 |
  % 6
  d8 c f4 e a |
  % 7
  a g8 f e4 g |
  % 8
  g8 f e4 e e8 d |
  % 9
  c4 f e e8 f |
  % 10
  g4 f8 e d4 c8 d |
  % 11
  e dis e fis fis e e4 |
  % 12
  d8 c f4 e a |
  % 13
  a g8 f e4 g |
  % 14
  a b a e |
  % 15
  e d d g |
  % 16
  g g g f |
  % 17
  e4. fis8 gis4 a8 g |
  % 18
  f4 g g8 f e4 |
  % 19
  a g g g |
  % 20
  a a8 g g fis fis e |
  % 21
  e4 d d c |
  % 22
  d8 e e dis e4 e8 d |
  % 23
  c e gis a b4 e, |
  % 24
  e8 d e4 e c'8 ais |
  % 25
  a g f e d4 e8 g |
  % 26
  g4. g8 g2 |
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
  s2. e'4 |
  % 2
  d d8 c b4 c8 b |
  % 3
  a b c4 c c8 d |
  % 4
  e d c4 d g, |
  % 5
  c8 b a c b4 c8 b |
  % 6
  a4 d c8 b c4 |
  % 7
  c b g d' |
  % 8
  d d8 c b4 c8 b |
  % 9
  a b c4 c c8 d |
  % 10
  e d c4 d g, |
  % 11
  c8 b a c b4 c8 b |
  % 12
  a4 d c8 b c4 |
  % 13
  c b g e' |
  % 14
  e8 c f e e4. d8 |
  % 15
  c b a4 g d' |
  % 16
  e f e a,8 gis |
  % 17
  a e a4 b a |
  % 18
  d8 c b4 b c |
  % 19
  d e8 f e4 d |
  % 20
  d d8 e e d b c |
  % 21
  c4 a8 b16 c b4 g8 a |
  % 22
  b4 a8 fis gis4 c8 b |
  % 23
  a c d f b,4 c |
  % 24
  c8 a b gis a4 g |
  % 25
  c8 ais a4 a8 g g e' |
  % 26
  d c d4 e2 |
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
  s2. c4 |
  % 2
  g' a e8 d c4 |
  % 3
  f8 g a b c4 a |
  % 4
  e f b, c8 b |
  % 5
  a b cis dis e4 c |
  % 6
  f e8 d a'4. g8 |
  % 7
  f e g4 c, c |
  % 8
  g' a e8 d c4 |
  % 9
  f8 g a b c4 a |
  % 10
  e f b, c8 b |
  % 11
  a b cis dis e4 c |
  % 12
  f e8 d a'4. g8 |
  % 13
  f e g4 c, c'8 b |
  % 14
  a4. gis8 a b c b |
  % 15
  a g fis d g4 g8 f |
  % 16
  e d c b c4 d |
  % 17
  a8 b c a e'4 cis |
  % 18
  d g8 f e4 a8 g |
  % 19
  f d g4 c, g' |
  % 20
  g8 fis g e c d e c |
  % 21
  a4 d g, c |
  % 22
  g'8 gis a4 e a, |
  % 23
  a' b8 a gis4 a8 g |
  % 24
  fis4 gis8 e a4 e |
  % 25
  f8 g a4 b, e8 c |
  % 26
  g'4 g, c2 |
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
