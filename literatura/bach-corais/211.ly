% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 211.mid
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
  c''4 b a a |
  % 2
  a b c8 b a4 |
  % 3
  g2 s4 b |
  % 4
  c b c a |
  % 5
  b g a2 |
  % 6
  b s4 b |
  % 7
  b b a b |
  % 8
  c2 g4 g |
  % 9
  a b c a |
  % 10
  b2 b4 c |
  % 11
  d d c a |
  % 12
  b2 d4 d |
  % 13
  d d e d8 c |
  % 14
  b2 b4 g |
  % 15
  a b8 c d c b4 |
  % 16
  a b c2 |
  % 17
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  e'8 f g4. f16 e f4 |
  % 2
  f8 a g4 g4. f8 |
  % 3
  f4 e s4 g |
  % 4
  g g g f2 e4 e2 |
  % 6
  e s4 e |
  % 7
  fis8 a4 g8 fis4 e |
  % 8
  e2 d8 f4 e d8 d4 c8 g'4 fis8 |
  % 10
  g2 g4. fis8 |
  % 11
  g a b4 a8 g fis4 |
  % 12
  g2 a4 g8 a |
  % 13
  b a g f e4 f |
  % 14
  g2 g8 f e4. fis8 g4 a4. g4 f16 e f8 e16 d e2 |
  % 17
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  g'4 g8 c c4 c |
  % 2
  d8 f e d c4 c |
  % 3
  c2 s4 d |
  % 4
  e d c c |
  % 5
  d b a8 b c a |
  % 6
  gis2 s4 g |
  % 7
  b8 fis'4 e d8 c b |
  % 8
  a2 d4. c16 b |
  % 9
  c4 b8 a g e' d4 |
  % 10
  d2 d4 c |
  % 11
  b e e d |
  % 12
  d2 fis8 e d c |
  % 13
  b4 b c8 b a4 |
  % 14
  e'2 d4 c |
  % 15
  c d d d |
  % 16
  d d8 g, g2 |
  % 17
  
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
  c8 d e4 f8 g f e |
  % 2
  d4 g8 f e4 f |
  % 3
  c2 s4 g' |
  % 4
  c,8 e g f e c f e |
  % 5
  d b e d c b a c |
  % 6
  e2 s4 e |
  % 7
  dis e fis gis |
  % 8
  a2 b4 c |
  % 9
  fis, g8 fis e c d4 |
  % 10
  g,2 g4 a |
  % 11
  b gis a8 b c d |
  % 12
  g,2 d''8 c b a |
  % 13
  g f e d c4 d |
  % 14
  e2 g,4 c8 b |
  % 15
  a4 g fis g |
  % 16
  d' g, c2 |
  % 17
  
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
