% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 018405bv.mid
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
  s2. g''4 |
  % 2
  g fis e d |
  % 3
  g a b a |
  % 4
  b8 c16 d c4 b a8 b |
  % 5
  c4 b a2 |
  % 6
  g2. g4 |
  % 7
  g fis e d |
  % 8
  g a b a |
  % 9
  b8 c16 d c4 b a8 b |
  % 10
  c4 b a2 |
  % 11
  g2. g4 |
  % 12
  a b g g |
  % 13
  a b g e |
  % 14
  a4. g8 fis4 g8 fis |
  % 15
  e2 d4 d |
  % 16
  g fis e d |
  % 17
  g a b a |
  % 18
  d4. c8 b4 a8 b |
  % 19
  c4 b a2 |
  % 20
  g1 |
  % 21
  
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
  e d c c |
  % 3
  b d d d |
  % 4
  d e d8 e fis4 |
  % 5
  g2. fis4 |
  % 6
  d2. d4 |
  % 7
  e d c c |
  % 8
  b d d d |
  % 9
  d e d8 e fis4 |
  % 10
  g2. fis4 |
  % 11
  d2. d4 |
  % 12
  d d e d |
  % 13
  e fis e b |
  % 14
  a8 b cis4 d d |
  % 15
  d cis a b |
  % 16
  b8 cis d4 c8 b a4 |
  % 17
  d d d d8 e |
  % 18
  fis4 g8 a d, e fis4 |
  % 19
  g2. fis4 |
  % 20
  d1 |
  % 21
  
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
  b b8 a g4 fis |
  % 3
  g fis g fis |
  % 4
  fis g8 a b c d4 |
  % 5
  c8 d e4 a,8 b c4 |
  % 6
  b2. b4 |
  % 7
  b b8 a g4 fis |
  % 8
  g fis g fis |
  % 9
  fis g8 a b c d4 |
  % 10
  c8 d e4 a,8 b c4 |
  % 11
  b2. b4 |
  % 12
  fis g g b |
  % 13
  a8 g fis4 b g8 fis |
  % 14
  e4 a a g8 a |
  % 15
  b4 a8 g fis4 fis |
  % 16
  g a4. g8 fis4 |
  % 17
  g fis g fis |
  % 18
  b4. a8 b c d4 |
  % 19
  c8 d e4 a,8 b c4 |
  % 20
  b1 |
  % 21
  
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
  e b c d |
  % 3
  e d g, d' |
  % 4
  b e,8 fis g4 fis |
  % 5
  e8 e' d c d2 |
  % 6
  g,2. g'4 |
  % 7
  e b c d |
  % 8
  e d g, d' |
  % 9
  b e,8 fis g4 fis |
  % 10
  e8 e' d c d2 |
  % 11
  g,2. g'4 |
  % 12
  d g, c b |
  % 13
  cis dis e e8 d |
  % 14
  cis4 a d8 cis b a |
  % 15
  g4 a d b |
  % 16
  e, fis8 g a b c4 |
  % 17
  b d g, d'8 c |
  % 18
  b4 e8 fis g4 fis |
  % 19
  e d8 c d2 |
  % 20
  g,1 |
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
