% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 043300b_.mid
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
  s4 g'' g a |
  % 2
  b2 s4 b |
  % 3
  c b a2 |
  % 4
  s4 a g a |
  % 5
  b a g2 |
  % 6
  a4 a b a |
  % 7
  g g fis2 |
  % 8
  g1 |
  % 9
  s4 g g a |
  % 10
  b2 s4 b |
  % 11
  c b a2 |
  % 12
  s4 a g a |
  % 13
  b a g2 |
  % 14
  a4 a b a |
  % 15
  g g fis2 |
  % 16
  g1 |
  % 17
  s4 b c b |
  % 18
  a2 s4 a |
  % 19
  g g fis2 |
  % 20
  s4 fis g fis |
  % 21
  e e dis2 |
  % 22
  e s4 g |
  % 23
  g fis g2 |
  % 24
  s4 b c b |
  % 25
  a2 s4 a |
  % 26
  g a b a |
  % 27
  g2 a4 a |
  % 28
  b a g g |
  % 29
  fis2 g |
  % 30
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s4 d' e8 g4 fis8 |
  % 2
  g2 s4 g4. fis8 g4 g fis |
  % 4
  s4 fis4. e4 d8 |
  % 5
  d4 d d cis |
  % 6
  d d d8 e fis4. e8 d e d2 |
  % 8
  d1 |
  % 9
  s4 d e8 g4 fis8 |
  % 10
  g2 s4 g4. fis8 g4 g fis |
  % 12
  s4 fis4. e4 d8 |
  % 13
  d4 d d cis |
  % 14
  d d d8 e fis4. e8 d e d2 |
  % 16
  d1 |
  % 17
  s4 g g8 a4 g fis16 e fis4 s4 fis2 e dis4 |
  % 20
  s4 fis b,8 e dis4 |
  % 21
  e b8 c b2 |
  % 22
  b s4 b8 c |
  % 23
  d e d4 d2 |
  % 24
  s4 g a4. g8 |
  % 25
  g4 fis s4 fis |
  % 26
  g d d8 e fis e |
  % 27
  d c d e fis4 a4. g4 fis e8 d e |
  % 29
  d2 d |
  % 30
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s4 b' b d |
  % 2
  d2 s4 d |
  % 3
  c d d2 |
  % 4
  s4 d8 c b4 a4. g4 fis8 g b a g |
  % 6
  fis4 d'8 c b cis d c |
  % 7
  b4 b8 a a b c4 |
  % 8
  b1 |
  % 9
  s4 b b d |
  % 10
  d2 s4 d |
  % 11
  c d d2 |
  % 12
  s4 d8 c b4 a4. g4 fis8 g b a g |
  % 14
  fis4 d'8 c b cis d c |
  % 15
  b4 b8 a a b c4 |
  % 16
  b1 |
  % 17
  s4 d e8 d d4 |
  % 18
  d2 s4 b |
  % 19
  b b b2 |
  % 20
  s4 b8 a g c4 b a8 g fis fis g a4 |
  % 22
  g2 s4 g8 a |
  % 23
  b a a16 b c8 c4 b |
  % 24
  s4 d8 e4 d8 d4 |
  % 25
  d2 s4 d |
  % 26
  d4. c8 b c d4 |
  % 27
  g,8 a b c16 b a4 d |
  % 28
  d d b4. a8 |
  % 29
  a b c4 b2 |
  % 30
  
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
  s4 g'8 fis e4 d |
  % 2
  g2 s4 g, |
  % 3
  a b8 c d2 |
  % 4
  s4 d e fis |
  % 5
  g d e2 |
  % 6
  d4 fis g d |
  % 7
  e b8 c d2 |
  % 8
  g,1 |
  % 9
  s4 g'8 fis e4 d |
  % 10
  g2 s4 g, |
  % 11
  a b8 c d2 |
  % 12
  s4 d e fis |
  % 13
  g d e2 |
  % 14
  d4 fis g d |
  % 15
  e b8 c d2 |
  % 16
  g,1 |
  % 17
  s4 g'8 fis e fis g4 |
  % 18
  d2 s4 dis8 b |
  % 19
  e fis g a b2 |
  % 20
  s4 dis, e b |
  % 21
  c g8 a b2 |
  % 22
  e s4 e |
  % 23
  b8 c d4 g,2 |
  % 24
  s4 g'4. fis8 g4 |
  % 25
  d2 s4 c |
  % 26
  b fis g d'8 c |
  % 27
  b a g4 d' fis |
  % 28
  g d e b8 c |
  % 29
  d2 g, |
  % 30
  
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
