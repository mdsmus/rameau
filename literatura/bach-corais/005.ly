% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 005.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \major
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d''4 |
  % 2
  e d8 c b c d4 |
  % 3
  c8 b c4 b a |
  % 4
  b c d c8 b |
  % 5
  a g a4 g d' |
  % 6
  e d8 c b c d4 |
  % 7
  c8 b c4 b a |
  % 8
  b c d c8 b |
  % 9
  a g a4 g g |
  % 10
  a b c8 b a4 |
  % 11
  b a g g8 a |
  % 12
  b4 c d e |
  % 13
  b cis d b8 c |
  % 14
  d4 e d8 c b4 |
  % 15
  c2 b4 e |
  % 16
  e e a, d |
  % 17
  c b a c |
  % 18
  b a g a8 g |
  % 19
  f4 e d d |
  % 20
  g a b4. c8 |
  % 21
  d4 c8 b a4 b8 c |
  % 22
  a2 g4 
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
  g fis g fis |
  % 3
  e8 g4 fis8 g4 a |
  % 4
  g g g g |
  % 5
  g fis d g |
  % 6
  g fis g fis |
  % 7
  e8 g4 fis8 g4 a |
  % 8
  g g g g |
  % 9
  g fis d d |
  % 10
  d8 e fis4 e e8 d |
  % 11
  d4 c b e |
  % 12
  d e f e8 fis |
  % 13
  g fis g a fis4 d |
  % 14
  g g a b |
  % 15
  b8 gis a4 gis b |
  % 16
  a e8 c d e f4 |
  % 17
  e d c a' |
  % 18
  d,8 e f4 e8 d e4. d4 cis8 d4 d8 c |
  % 20
  b a g f g4 g' |
  % 21
  fis g g g2 fis4 d 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. b'4 |
  % 2
  c8 b a4 e' a,8 b |
  % 3
  c e d4 d d |
  % 4
  d g,8 a b g e'4 |
  % 5
  a,8 b c4 b b |
  % 6
  c8 b a4 e' a,8 b |
  % 7
  c e d4 d d |
  % 8
  d g,8 a b g e'4 |
  % 9
  a,8 b c4 b b |
  % 10
  a d g, a4. g4 fis8 g4 g |
  % 12
  g g g g |
  % 13
  g8 a16 a a4 a g |
  % 14
  g8 d' c b a4 e' |
  % 15
  e2 e4 e8 d |
  % 16
  c b a4. gis8 a b |
  % 17
  gis a4 gis8 a4 e8 fis |
  % 18
  g4 d'8 c ais4 a |
  % 19
  a g fis fis |
  % 20
  g d' d e |
  % 21
  d2 e8 d c4 |
  % 22
  d8 e d c b4 
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
  s2. g'4 |
  % 2
  c, d e fis8 g |
  % 3
  a4 d, g fis |
  % 4
  g8 fis e4 b c |
  % 5
  d2 g,4 g' |
  % 6
  c, d e fis8 g |
  % 7
  a4 d, g fis8 s8 |
  % 8
  g fis e4 b c |
  % 9
  d2 g,4 g' |
  % 10
  fis e8 d e4 fis |
  % 11
  g d g, c |
  % 12
  g'8 f e d c b c d |
  % 13
  e4 a, d g8 a |
  % 14
  b4 c fis, gis |
  % 15
  a a, e' gis, |
  % 16
  a8 b c a f'4 e8 d |
  % 17
  e4 e, a a |
  % 18
  b8 cis d2 cis4 |
  % 19
  d a d b |
  % 20
  e d g8 fis e4 |
  % 21
  b8 a g4 c8 b a4 |
  % 22
  d8 c d4 g, 
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
