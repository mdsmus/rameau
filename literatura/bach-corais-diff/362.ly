% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 362.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \major
  
  \tempo 4 = 94 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. g''4 |
  % 2
  g8 a b4 a g |
  % 3
  a a b g8 a |
  % 4
  b4 c d c8 b |
  % 5
  a g a4 g g |
  % 6
  g8 a b4 a g |
  % 7
  a a b g8 a |
  % 8
  b4 c d c8 b |
  % 9
  a g a4 g b |
  % 10
  b a g fis |
  % 11
  g8 a b4 a a |
  % 12
  g fis g d |
  % 13
  g a b g8 a |
  % 14
  b4 c d c8 b |
  % 15
  a g a4 g2 |
  % 16
  
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
  e8 fis g4 g8 fis g4 |
  % 3
  g fis g e8 fis |
  % 4
  g b4 a16 g fis4 g |
  % 5
  g fis d d |
  % 6
  e8 fis g4 g8 fis g4 |
  % 7
  g fis g e8 fis |
  % 8
  g b4 a16 g fis4 g |
  % 9
  g fis d g |
  % 10
  g4. fis8 fis e e dis |
  % 11
  e4 d d d |
  % 12
  d8 c d4 d8 c b4 |
  % 13
  b e dis b |
  % 14
  e e d8 e16 fis g4 |
  % 15
  g fis d2 |
  % 16
  
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
  b e e8 d d4 |
  % 3
  e8 c a d d4 e |
  % 4
  d g,8 a b c d4 |
  % 5
  d c8 b b4 b |
  % 6
  b e e8 d d4 |
  % 7
  e8 c a d d4 e |
  % 8
  d g,8 a b c d4 |
  % 9
  d c8 b b4 d |
  % 10
  d d8 c b c fis, b |
  % 11
  b a a g fis4 fis |
  % 12
  g8 a b c b a g4 |
  % 13
  g fis8 e fis4 e8 fis |
  % 14
  g4. a8 b c d4 |
  % 15
  d c8 b b2 |
  % 16
  
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
  s2. g'8 fis |
  % 2
  e4. d8 c4. b8 |
  % 3
  c a d4 g, c |
  % 4
  g'8 fis e4 b'8 a g4 |
  % 5
  d' d, g g8 fis |
  % 6
  e4. d8 c4. b8 |
  % 7
  c a d4 g, c |
  % 8
  g'8 fis e4 b'8 a g4 |
  % 9
  d' d, g g8 a |
  % 10
  b c d4 g,8 a b4 |
  % 11
  e,8 fis g4 d d'8 c |
  % 12
  b4. a8 g4. fis8 |
  % 13
  e d c4 b e |
  % 14
  e8 d c4 b8 a g4 |
  % 15
  d'2 g, |
  % 16
  
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
  s2. g'8 fis |
  % 2
  e e, e' d c c, c' b |
  % 3
  c a d d, g4 c |
  % 4
  g'8 fis e e, b' a g b |
  % 5
  d4 d, g g'8 fis |
  % 6
  e e, e' d c c, c' b |
  % 7
  c a d d, g4 c |
  % 8
  g'8 fis e e, b' a g b |
  % 9
  d4 d, g g8 a |
  % 10
  b c d d, g a b b' |
  % 11
  e, fis g g, d'4 d8 c |
  % 12
  b b' b, a g g' g, fis |
  % 13
  e d c c' b4 e, |
  % 14
  e'8 d c c' b a g g, |
  % 15
  d'4 d, g2 |
  % 16
  
}

trackF = <<

  \clef bass
  
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
    \context Staff=trackF \trackF
  >>
}
