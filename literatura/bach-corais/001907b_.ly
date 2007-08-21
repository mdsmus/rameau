% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 001907b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key c \major
  
  \tempo 4 = 160 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  c''2 d4 e2 d4 c2 |
  % 3
  b4 a2. |
  % 4
  g c2 d4 e2 |
  % 6
  f4 e d2 |
  % 7
  c2. c2 d4 e2 |
  % 9
  d4 c2 b4 |
  % 10
  a2. g c2 |
  % 12
  d4 e2 f4 |
  % 13
  e d2 c2. e2 |
  % 15
  f4 g2 f4 |
  % 16
  e d2 e2. g4 g2 a g4 |
  % 19
  f e2 d2. e2 |
  % 21
  g4 f2 e4 |
  % 22
  c d2 e2. c e2 g4 |
  % 25
  f2 e4 d2 e4 d2. c |
  % 28
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  g''2 g4 g2 fis4 g a |
  % 3
  g e fis2 |
  % 4
  d2. c2 g'4 g2 |
  % 6
  a4 e a g |
  % 7
  g2. g2 g4 g2 |
  % 9
  fis4 g a g |
  % 10
  e fis2 d2. c2 |
  % 12
  g'4 g2 a4 |
  % 13
  e a g g2. g2 |
  % 15
  a4 ais2 a4 |
  % 16
  e a g g2. c4 ais2 a4 b c |
  % 19
  c g2 g2. g2 |
  % 21
  g4 a2 g4 |
  % 22
  f d g g2. f g2 g4 |
  % 25
  g2 g4 f |
  % 26
  d g g2. g |
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
  e'2 b4 c |
  % 2
  b a e' d |
  % 3
  d c a2 |
  % 4
  b2. g2 b4 c2 |
  % 6
  c4 c2 b4 |
  % 7
  g2. e'2 b4 c b |
  % 9
  a e' d d |
  % 10
  c a2 b2. g2 |
  % 12
  b4 c2 c4 |
  % 13
  c2 b4 g2. c2 |
  % 15
  c4 g2 c4 |
  % 16
  c2 b4 g2. e'4 e2 c4 d e |
  % 19
  c2 c4 b2. c2 |
  % 21
  c4 c2 b4 |
  % 22
  c b2 c ais4 a2. c2 e4 |
  % 25
  d2 c4 a |
  % 26
  g2 g8 d' f e |
  % 27
  f4 e2. |
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
  c'2 g4 c,2 d4 e fis |
  % 3
  g c, d2 |
  % 4
  g,2. e'2 g4 c b |
  % 6
  a g f g |
  % 7
  c,2. c'2 g4 c,2 |
  % 9
  d4 e fis g |
  % 10
  c, d2 g,2. e'2 |
  % 12
  g4 c b a |
  % 13
  g f g c,2. c'2 |
  % 15
  a4 e2 f4 |
  % 16
  g f g c,2. c4 c'8 ais |
  % 18
  a g f2 e4 |
  % 19
  a8 b c4 c, g'2. c2 |
  % 21
  e,4 f2 g4 |
  % 22
  a b g c2 c,4 f2. c2 c'4 |
  % 25
  c b c f, |
  % 26
  g c, g2. c |
  % 28
  
}

trackE = <<

  \clef bass
  
  \context Voice = channelA \trackEchannelA
  \context Voice = channelB \trackEchannelB
>>


trackFchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 5
  
}

trackFchannelB = \relative c {
  g'''2 g4 g |
  % 2
  s1 |
  % 3
  g4 g fis2 |
  % 4
  g2. s4 |
  % 5
  g g e g |
  % 6
  f g a b |
  % 7
  c2. g2 g4 g s1 g4 |
  % 10
  g fis2 g2. s4 g |
  % 12
  g e g f |
  % 13
  g a b c2. s4 g |
  % 15
  f s4 g a |
  % 16
  g a b c2. c,8*13 d8 e d e f g2. e8 f e d |
  % 21
  c2 d4 e |
  % 22
  f g f e8 f |
  % 23
  g a f g a2. g8 a g f e4 |
  % 25
  f g2 a4 |
  % 26
  b c2 b c2. |
  % 28
  
}

trackF = <<
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


trackGchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 6
  
}

trackGchannelB = \relative c {
  e''2 d4 c |
  % 2
  s1 |
  % 3
  d4 e d2 |
  % 4
  d2. s4 |
  % 5
  e d c2 |
  % 6
  c8 d e4 f d |
  % 7
  e2. e2 d4 c s1 d4 |
  % 10
  e d2 d2. s4 e |
  % 12
  d c2 c8 d |
  % 13
  e4 f d e2. c4*7 f4 f e2. s4 e |
  % 18
  e f s2. c4 c d2. c2 |
  % 21
  g4 c,2 g'4 |
  % 22
  c g d' c8 d |
  % 23
  e f d e f2. e8 f e d c4 |
  % 25
  d2 e4 f2 e8 f g2. g |
  % 28
  
}

trackG = <<
  \context Voice = channelA \trackGchannelA
  \context Voice = channelB \trackGchannelB
>>


trackHchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 7
  
}

trackHchannelB = \relative c {
  c''4 g g e |
  % 2
  s4*15 c'4 |
  % 6
  c, c c8 c g' g |
  % 7
  g2. c4 |
  % 8
  g g e s4*15 c'4 c, |
  % 13
  c c8 c g' g g2. s4*7 c,4 g' g2. s4 c |
  % 18
  c c, s2. g'4 g g2. s4 g |
  % 21
  c f s1. c4 c c2. s4 c g |
  % 25
  g2 g4 d'2 c4 d2. e |
  % 28
  
}

trackH = <<
  \context Voice = channelA \trackHchannelA
  \context Voice = channelB \trackHchannelB
>>


trackIchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 8
  
}

trackIchannelB = \relative c {
  c4 c g c |
  % 2
  s4*15 c4 |
  % 6
  c c c g |
  % 7
  c2. c4 |
  % 8
  c g c s4*15 c4 c |
  % 13
  c c g c2. s4*7 c4 g c2. s4 c |
  % 18
  c c s2. c4 c g2. s4 c |
  % 21
  c c s1. c4 c c2. s4 c c |
  % 25
  g g c s4 |
  % 26
  g c g2. c |
  % 28
  
}

trackI = <<

  \clef bass
  
  \context Voice = channelA \trackIchannelA
  \context Voice = channelB \trackIchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
    \context Staff=trackF \trackF
    \context Staff=trackG \trackG
    \context Staff=trackH \trackH
    \context Staff=trackI \trackI
  >>
}
