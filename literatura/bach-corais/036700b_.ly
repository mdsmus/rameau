% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 036700b_.mid
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
  s2. g''4 |
  % 2
  c c d d |
  % 3
  e2 d4 d |
  % 4
  c b a a |
  % 5
  b2 b4 g |
  % 6
  g g c c |
  % 7
  b2 s4 b |
  % 8
  e e c c |
  % 9
  d2 b4 b |
  % 10
  c c a a |
  % 11
  b2 g4 g |
  % 12
  c d e d |
  % 13
  c1 |
  % 14
  
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
  e8 f g4 a g |
  % 3
  g2 g4 g4. fis8 g4 g fis |
  % 5
  g2 g4 d |
  % 6
  e e a a |
  % 7
  gis2 s4 g |
  % 8
  g g f f |
  % 9
  fis8 g a fis g4 g |
  % 10
  g g fis fis |
  % 11
  fis b, b b |
  % 12
  c f e8 f g f |
  % 13
  e1 |
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
  s2. c'4 |
  % 2
  c c c b |
  % 3
  c2 b4 b |
  % 4
  c d e d |
  % 5
  d2 d4 b |
  % 6
  c c8 d e4 e |
  % 7
  e2 s4 e4. d8 c b a b c a |
  % 9
  a4 d d d |
  % 10
  e e e d |
  % 11
  dis8 e fis dis e4 d |
  % 12
  g, b c b |
  % 13
  g1 |
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
  s2. c4 |
  % 2
  c8 d e4 f g |
  % 3
  c,8 d e f g4 g, |
  % 4
  a b c d |
  % 5
  g2 g,4 g'8 f |
  % 6
  e d c b a b c d |
  % 7
  e2 s4 e8 d |
  % 8
  c d e c f g a f |
  % 9
  d e fis d g4 g, |
  % 10
  c8 d e c d e fis d |
  % 11
  b cis dis b e4 g8 f |
  % 12
  e f e d c4 g' |
  % 13
  c,1 |
  % 14
  
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
