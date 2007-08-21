% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 025100b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \major
  
  \tempo 4 = 92 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d''4 |
  % 2
  d d d8 e f4 |
  % 3
  e d c d8 c |
  % 4
  b a g a b4 cis |
  % 5
  d e d d |
  % 6
  d d d8 e f4 |
  % 7
  e d c d8 c |
  % 8
  b a g a b4 cis |
  % 9
  d e d d |
  % 10
  g fis e fis |
  % 11
  g8 fis e4 d d |
  % 12
  g d e b8 c |
  % 13
  d4 c b b |
  % 14
  a8 b c4 b a |
  % 15
  e16 fis g4 fis8 g2 |
  % 16
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. b''4 |
  % 2
  a8 g fis4 g c,8 d |
  % 3
  e f g4 c, a' |
  % 4
  d, e8 fis g fis e4 |
  % 5
  fis g fis b |
  % 6
  a8 g fis4 g c,8 d |
  % 7
  e f g4 c, a' |
  % 8
  d, e8 fis g fis e4 |
  % 9
  fis g fis b8 a |
  % 10
  g4 d' cis8 b a4 |
  % 11
  b8 d a4 a g8 a |
  % 12
  b c b a g4 g |
  % 13
  fis8 e e fis gis4 g |
  % 14
  a8 d, g a d, g4 fis8 |
  % 15
  g b, e d d2 |
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
  s2. g''4 |
  % 2
  d a g8 b a g |
  % 3
  c4 d8 e16 f e4 d |
  % 4
  d8 c b4 e a, |
  % 5
  a8 d4 cis8 d4 g |
  % 6
  d a g8 b a g |
  % 7
  c4 d8 e16 f e4 d |
  % 8
  d8 c b4 e a, |
  % 9
  a8 d4 cis8 d4 d |
  % 10
  d8 e fis g a4 d, |
  % 11
  d8 b e4 fis b,8 a |
  % 12
  g4 g'8 fis e4 e |
  % 13
  d8 b a4 b b8 g |
  % 14
  d'4 c8 a b4 c8 a |
  % 15
  e'4 a, b2 |
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
  s2. g'4 |
  % 2
  fis8 e d c g' g, a b |
  % 3
  c4 g' a fis |
  % 4
  g4. fis8 e fis g a |
  % 5
  fis b g a d,4 g |
  % 6
  fis8 e d c g' g, a b |
  % 7
  c4 g' a fis |
  % 8
  g4. fis8 e fis g a |
  % 9
  fis b g a d,4 g8 a |
  % 10
  b cis d4 a8 b c4 |
  % 11
  b8 g a4 d, g8 fis |
  % 12
  e4 b c8 d e4 |
  % 13
  fis8 gis a4 e g |
  % 14
  fis8 g e fis g e c d |
  % 15
  e4 c8 d g,2 |
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
  s2. d''4 |
  % 2
  d d d8 e f4 |
  % 3
  e d c d8 c |
  % 4
  b a g a b4 cis |
  % 5
  d e d d |
  % 6
  d d d8 e f4 |
  % 7
  e d c d8 c |
  % 8
  b a g a b4 cis |
  % 9
  d e d d |
  % 10
  g fis e fis |
  % 11
  g8 fis e4 d d |
  % 12
  g d e b8 c |
  % 13
  d4 c b b |
  % 14
  a8 b c4 b a |
  % 15
  g8. a16 a4 g2 |
  % 16
  
}

trackF = <<
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


trackGchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 6
  
}

trackGchannelB = \relative c {
  s2. g''4 |
  % 2
  a8 b c4 b c8 d |
  % 3
  g, c4 b8 a4 a |
  % 4
  g8 fis b, d g a16 b a4. d,8 b' a a4 g |
  % 6
  a8 b c4 b c8 d |
  % 7
  g, c4 b8 a4 a |
  % 8
  g8 fis b, d g a16 b a4. d,8 b' a a4 b8 c |
  % 10
  d4 a8 b cis4 d |
  % 11
  d4. cis8 a4 b |
  % 12
  b8 a g4 g g |
  % 13
  a8 b c d e4 d,4. b8 g d' g4. d8 |
  % 15
  b16 d g4 d32 b d16 b2 |
  % 16
  
}

trackG = <<
  \context Voice = channelA \trackGchannelA
  \context Voice = channelB \trackGchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
    \context Staff=trackF \trackF
    \context Staff=trackG \trackG
  >>
}
