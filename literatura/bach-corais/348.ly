% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 348.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key c \major
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  g''4 g a a |
  % 2
  b b c2 |
  % 3
  d4 d c c |
  % 4
  b a8 b16 c a2 |
  % 5
  g g4 g |
  % 6
  a a g f |
  % 7
  e2 g4 g |
  % 8
  f f e d8 e16 f |
  % 9
  d2 c |
  % 10
  c'4 c b b |
  % 11
  a a g2 |
  % 12
  g4 g f e |
  % 13
  d d c2 |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  e'4 e f f |
  % 2
  f8 e d4 e2 |
  % 3
  g4 g g fis |
  % 4
  d c8 d16 e fis2 |
  % 5
  d e8 d c4 |
  % 6
  c d d8 e f d |
  % 7
  c2 b4 e |
  % 8
  d d c8 ais a4 |
  % 9
  g2 g |
  % 10
  e'8 d c4 g'8*5 a16 g fis e fis8 b,2 |
  % 12
  e4 e d c8 b |
  % 13
  a4 b g2 |
  % 14
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  c'4 c c d |
  % 2
  d g, g2 |
  % 3
  d'4 b a a |
  % 4
  g8 fis e c' c b a4 |
  % 5
  b2 c4 g |
  % 6
  f f g c8 g |
  % 7
  g2 g4 a |
  % 8
  a g g4. f4 e8 d4 e2 |
  % 10
  g4. fis8 d'4 d |
  % 11
  d c8 a e'2 |
  % 12
  cis4 a a8*5 d,8 g f e2 |
  % 14
  
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
  c'8 ais a g f e d4 |
  % 2
  g g, c2 |
  % 3
  b8 c d e a, b c d |
  % 4
  g,4 c d2 |
  % 5
  g, c8 d e c |
  % 6
  f e d c b c a b |
  % 7
  c2 e8 d cis a |
  % 8
  d c b g c4 f, |
  % 9
  g2 c |
  % 10
  c8 b a4 g8 a b c |
  % 11
  d4 dis e2 |
  % 12
  a,8 b cis a d4 a8 g |
  % 13
  f4 g c,2 |
  % 14
  
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
  g'''4 g g f8 e |
  % 2
  d e f g e2 |
  % 3
  d4 e2 fis4 |
  % 4
  g g2 fis4 |
  % 5
  g2 e8 f g4. c,8 f4. e4 d8 |
  % 7
  g2 e4 e |
  % 8
  f g2 a4 |
  % 9
  d,8 e f g e2 |
  % 10
  c8 d e fis g d g4. fis16 e fis8 a16 g e2 |
  % 12
  e8 a16 g a4. c16 b c2 b4 c2 |
  % 14
  
}

trackF = <<
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


trackGchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 6
  
}

trackGchannelB = \relative c {
  e''4 e4. a,8 d c |
  % 2
  b c b a16 g g2 |
  % 3
  b4 b c d2 e4 a,8 b c d |
  % 5
  b2 g4 e'4. a,8 d4. g8 c, d |
  % 7
  e2 b4 a2 b4 c c2 b4 c2 |
  % 10
  g4 c8 b16 a d8 c d e |
  % 11
  a, b c4 b2 |
  % 12
  cis8 d e4 f8 g a2 g4 g2 |
  % 14
  
}

trackG = <<
  \context Voice = channelA \trackGchannelA
  \context Voice = channelB \trackGchannelB
>>


trackHchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 7
  
}

trackHchannelB = \relative c {
  c''4 c8 ais a4 a |
  % 2
  d, d c2 |
  % 3
  g'4 g a a |
  % 4
  b c8 g d'4 d, |
  % 5
  d2 c4 c'8 ais |
  % 6
  a g f e d c4 g'8 |
  % 7
  c2 b4 cis |
  % 8
  d d, e f8 c |
  % 9
  g'2 g |
  % 10
  e4 a b8 a g4 |
  % 11
  d' fis, g2 |
  % 12
  a4. cis8 d4 e |
  % 13
  f8 e d4 e2 |
  % 14
  
}

trackH = <<
  \context Voice = channelA \trackHchannelA
  \context Voice = channelB \trackHchannelB
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
  >>
}
