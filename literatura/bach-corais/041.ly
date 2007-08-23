% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 041.mid
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
  
  % [SEQUENCE_TRACK_NAME] Acoustic Grand Piano
  s2. e'4 |
  % 2
  g a g c |
  % 3
  c b c c |
  % 4
  b a d4. c8 |
  % 5
  b4 c b2 |
  % 6
  a2. e4 |
  % 7
  g a g c |
  % 8
  c b c c |
  % 9
  b a d4. c8 |
  % 10
  b4 c b2 |
  % 11
  a2. a4 |
  % 12
  a a b4. a8 |
  % 13
  b4 g g fis |
  % 14
  g g a b |
  % 15
  c b a2 |
  % 16
  b4 e,8 fis g4 a |
  % 17
  g c c b |
  % 18
  c c b a |
  % 19
  d4. c8 b4 c |
  % 20
  b2 a |
  % 21
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Acoustic Grand Piano
  
}

trackCchannelB = \relative c {
  s2. c'4 |
  % 2
  e8 d c d e f g4 |
  % 3
  g g g g |
  % 4
  g f8 g a2 |
  % 5
  gis4 a2 gis4 |
  % 6
  e2. c4 |
  % 7
  e8 d c d e f g4 |
  % 8
  g g g g |
  % 9
  g f8 g a2 |
  % 10
  gis4 a2 gis4 |
  % 11
  e2. e4 |
  % 12
  d8 e fis4 g4. a8 |
  % 13
  g4 e e d |
  % 14
  d e fis f |
  % 15
  e8 fis gis4 a4. dis,8 |
  % 16
  e4 b e fis |
  % 17
  e e a g |
  % 18
  g a a8 g g f |
  % 19
  f4. e8 d4 c8 d |
  % 20
  e2 e |
  % 21
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Acoustic Grand Piano
  
}

trackDchannelB = \relative c {
  s2. a'4 |
  % 2
  b a8 b c4 c8 d |
  % 3
  e d16 c d4 e e |
  % 4
  d d a e'2 e4 e4. d8 |
  % 6
  c2. a4 |
  % 7
  b a8 b c4 c8 d |
  % 8
  e d16 c d4 e e |
  % 9
  d d a e'2 e4 e4. d8 |
  % 11
  c2. c8 b |
  % 12
  a4 d d4. dis8 |
  % 13
  e4 b a a |
  % 14
  b c a d |
  % 15
  c8 d e4 e8 d c fis, |
  % 16
  gis4 g8 a b4 c |
  % 17
  b c d d |
  % 18
  e e f8 e e d |
  % 19
  d c b a e'8*5 a,8 gis4 cis2 |
  % 21
  
}

trackD = <<

  \clef bass
  
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Acoustic Grand Piano
  
}

trackEchannelB = \relative c {
  s2. a4 |
  % 2
  e' f c8 d e f |
  % 3
  g4 g, c c |
  % 4
  g' d8 e f g a4 |
  % 5
  e8 d c a e'2 |
  % 6
  a,2. a4 |
  % 7
  e' f c8 d e f |
  % 8
  g4 g, c c |
  % 9
  g' d8 e f g a4 |
  % 10
  e8 d c a e'2 |
  % 11
  a,2. a'8 g |
  % 12
  fis4 e8 d g d g fis |
  % 13
  e b e d c a d4 |
  % 14
  g, c c'8 b a gis |
  % 15
  a4 e8 d c b a4 |
  % 16
  e' e e dis |
  % 17
  e a8 g fis4 g |
  % 18
  c, a d8 e f4 |
  % 19
  b,8 c d4 gis,8 e' c a |
  % 20
  e'2 a, |
  % 21
  
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
