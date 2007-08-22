% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 070.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key c \major
  
  \tempo 4 = 92 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. g''4 |
  % 2
  g g a2 |
  % 3
  g c4 d |
  % 4
  c b a2 |
  % 5
  g a8 b c4 |
  % 6
  g8 f e4 f e |
  % 7
  d2 c4 g' |
  % 8
  g g a2 |
  % 9
  g c4 d |
  % 10
  c b a2 |
  % 11
  g a8 b c4 |
  % 12
  g8 f e4 f e |
  % 13
  d2 c4 g' |
  % 14
  g g a4. g8 |
  % 15
  fis g a4 g2 |
  % 16
  g4 g a b |
  % 17
  c b a2 |
  % 18
  g b4 c |
  % 19
  d d d a |
  % 20
  g e d2 |
  % 21
  e4 fis g8 f e4 |
  % 22
  fis2 g |
  % 23
  d8 e f4 e d |
  % 24
  e d c2 |
  % 25
  s4 g' g g |
  % 26
  a4. g8 fis g a4 |
  % 27
  g1 |
  % 28
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. d'4 |
  % 2
  g8 f e2 d4 |
  % 3
  e2 g4 g4. fis8 g4 g8 fis16 e fis4 |
  % 5
  d2 f4. e8 |
  % 6
  d4 c4. b8 c4. b16 a b4 g d' |
  % 8
  g8 f e2 d4 |
  % 9
  e2 g4 g4. fis8 g4 g8 fis16 e fis4 |
  % 11
  d2 f4. e8 |
  % 12
  d4 c4. b8 c4. b16 a b4 g e' |
  % 14
  d8 c d f e d16 c b8 cis |
  % 15
  d g4 fis8 d2 |
  % 16
  d4 e fis g4. fis8 g4 g8 fis16 e fis4 |
  % 18
  d2 g4 g |
  % 19
  g g4. fis16 e fis8 f |
  % 20
  e d d cis a2 |
  % 21
  c4 c d c4. e8 d c b2 |
  % 23
  b4 a g8 c b4 |
  % 24
  c4. b8 g2 |
  % 25
  s4 d' c g |
  % 26
  c8 d e4 d2 |
  % 27
  d1 |
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
  s2. b'8 c |
  % 2
  d4 c8 b c4 b8 a |
  % 3
  b2 e4 f |
  % 4
  e d d4. c8 |
  % 5
  b2 d4 c |
  % 6
  d g, f g |
  % 7
  a g8 f e4 b'8 c |
  % 8
  d4 c8 b c4 b8 a |
  % 9
  b2 e4 f |
  % 10
  e d d4. c8 |
  % 11
  b2 d4 c |
  % 12
  d g, f g |
  % 13
  a g8 f e4 c' |
  % 14
  g8 a b4 c8 fis, g a |
  % 15
  b4 a16 b c8 b2 |
  % 16
  b4. cis8 d4 d |
  % 17
  c d e8 c a d16 c |
  % 18
  b2 d4 e |
  % 19
  d8 c b4 c d8 c |
  % 20
  ais4 a8. g16 f2 |
  % 21
  g4 a g g |
  % 22
  a8 c b a g2 |
  % 23
  g4 c,8 d e g g4 |
  % 24
  g g8. f16 e2 |
  % 25
  s4 g8 f e4 d8 e |
  % 26
  f4 c'8 b a g4 fis8 |
  % 27
  b1 |
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
  s2. g8 a |
  % 2
  b4 e8 d c4 f |
  % 3
  e2 e8 d c b |
  % 4
  c4 g d' d, |
  % 5
  g2 d'4 a |
  % 6
  b c8 b a4 g |
  % 7
  f g c, g'8 a |
  % 8
  b4 e8 d c4 f |
  % 9
  e2 e8 d c b |
  % 10
  c4 g d' d, |
  % 11
  g2 d'4 a |
  % 12
  b c8 b a4 g |
  % 13
  f g c, c' |
  % 14
  b8 a g4 c8 d e4 |
  % 15
  d d, g2 |
  % 16
  g'8 fis e4 d8 c b4 |
  % 17
  a b8 g c a d4 |
  % 18
  g,2 g'8 f e4 |
  % 19
  b4. e8 a,4 d |
  % 20
  g, a d2 |
  % 21
  c8 b a4 b c8 b |
  % 22
  a4 d g,2 |
  % 23
  g4 a8 b c e g f |
  % 24
  e c g' g, c2 |
  % 25
  s4 b c b |
  % 26
  a8 b c4 d2 |
  % 27
  g,1 |
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
