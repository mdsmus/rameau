% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 322.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \major
  
  \tempo 4 = 104 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. g''4 |
  % 2
  d e fis g |
  % 3
  a b g b8 c |
  % 4
  d4 d b8 c d4 |
  % 5
  c2 b4 b |
  % 6
  c b a g8 a |
  % 7
  b4 b8 a g4 b8 c |
  % 8
  d4 d b d |
  % 9
  c2 b4 b |
  % 10
  c b a g8 a |
  % 11
  b4 b g a |
  % 12
  b b e, fis |
  % 13
  g8 fis e4 d d |
  % 14
  g a b a8 b |
  % 15
  c4 b a2 |
  % 16
  g1 |
  % 17
  
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
  d c c d |
  % 3
  d d e d |
  % 4
  d8 e fis4 g f |
  % 5
  e fis d d |
  % 6
  d4. e8 fis4 g8 fis |
  % 7
  e4 dis e e |
  % 8
  d a' g b2 a4 g g |
  % 10
  g g fis8 e d4 |
  % 11
  d d e e8 fis4 e16 fis g8 fis e4. d8 |
  % 13
  d4 d8 cis a4 d |
  % 14
  d d g g |
  % 15
  fis8 a4 g8 g4 fis |
  % 16
  d1 |
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
  s2. b'8 a |
  % 2
  g4 g a b |
  % 3
  c b c b |
  % 4
  a a g8 a b2 a4 g b |
  % 6
  a b b b |
  % 7
  b b b g |
  % 8
  a8 b c d d e f4 |
  % 9
  e fis d d |
  % 10
  c d d d8 c |
  % 11
  b a g4 c c |
  % 12
  b b4. a8 a b16 c |
  % 13
  b8 a g4 fis fis8 a |
  % 14
  b4 a g e'8 d |
  % 15
  c d d4 e d8 c |
  % 16
  b1 |
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
  s2. g8 a |
  % 2
  b4 ais a g |
  % 3
  fis g c g' |
  % 4
  fis8 e d4 e b |
  % 5
  c d g, g' |
  % 6
  fis g dis e8 fis |
  % 7
  g a b4 e, e |
  % 8
  f fis g gis |
  % 9
  a d, g g8 fis |
  % 10
  e4 d c b8 a |
  % 11
  g a b4 c a' |
  % 12
  g8 fis e d cis4 d |
  % 13
  g, a d d8 c |
  % 14
  b a g fis e d' c b |
  % 15
  a fis g b c a d d, |
  % 16
  g1 |
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
