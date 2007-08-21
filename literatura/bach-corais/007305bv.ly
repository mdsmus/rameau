% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 007305bv.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 104 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. e'4 |
  % 2
  a b c d |
  % 3
  b2 g4 g |
  % 4
  a a b b |
  % 5
  e,2. e4 |
  % 6
  a b c d |
  % 7
  b2 g4 g |
  % 8
  a a b b |
  % 9
  e,2. e'4 |
  % 10
  d c c b |
  % 11
  c2. b4 |
  % 12
  c d e e |
  % 13
  d2 b4 b |
  % 14
  c b a a |
  % 15
  b a g f |
  % 16
  e a a gis |
  % 17
  a1 |
  % 18
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. c'4 |
  % 2
  e e e d |
  % 3
  d8 e fis4 e e |
  % 4
  c d d8 f e d |
  % 5
  c2. c4 |
  % 6
  e e e d |
  % 7
  d8 e fis4 e e |
  % 8
  c d d8 f e d |
  % 9
  c2. a'4 |
  % 10
  a a g g |
  % 11
  g2. g4 |
  % 12
  g f g a8 g |
  % 13
  fis e fis4 d g |
  % 14
  g e c f4. e8 fis4 e d |
  % 16
  c d e e |
  % 17
  e1 |
  % 18
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. a'4 |
  % 2
  c b a a |
  % 3
  g fis b c |
  % 4
  a f e e |
  % 5
  a2. a4 |
  % 6
  c b a a |
  % 7
  g fis b c |
  % 8
  a f e e |
  % 9
  a2. c4 |
  % 10
  d f e d |
  % 11
  e2. d4 |
  % 12
  c4. b4 g8 c2 b8 a g4 d' |
  % 14
  c g a8 b c4 |
  % 15
  d c b g |
  % 16
  g a8 b c b16 a b8 b |
  % 17
  cis1 |
  % 18
  
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
  s2. a4 |
  % 2
  a' gis a fis |
  % 3
  g dis e c |
  % 4
  f d gis, gis |
  % 5
  a2. a4 |
  % 6
  a' gis a fis |
  % 7
  g dis e c |
  % 8
  f d gis, gis |
  % 9
  a2. a'4 |
  % 10
  f d g g, |
  % 11
  c2. g'4 |
  % 12
  e d c a |
  % 13
  d2 g,4 g' |
  % 14
  e c f e |
  % 15
  d dis e b |
  % 16
  c f e e, |
  % 17
  a1 |
  % 18
  
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
