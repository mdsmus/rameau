% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 025200b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \major
  
  \tempo 4 = 90 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d''4 |
  % 2
  d d e e |
  % 3
  d2. b4 |
  % 4
  c b a b8 c |
  % 5
  a2 g4 d' |
  % 6
  d d e e |
  % 7
  d2. b4 |
  % 8
  c b a b8 c |
  % 9
  a2 g4 a |
  % 10
  a a b b |
  % 11
  a2. a4 |
  % 12
  b8 cis d4 d cis |
  % 13
  d2. d4 |
  % 14
  e d c b |
  % 15
  c2. b4 |
  % 16
  a b8 c a4. g8 |
  % 17
  g2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. g''4 |
  % 2
  a g g g8 a |
  % 3
  b2. g4 |
  % 4
  a d, d d |
  % 5
  e16 fis g4 fis8 d4 g |
  % 6
  a g g g8 a |
  % 7
  b2. g4 |
  % 8
  a d, d d |
  % 9
  e16 fis g4 fis8 d4 fis8 g |
  % 10
  a g a fis d4 g |
  % 11
  fis2. fis4 |
  % 12
  d8 e fis4 b a8 g |
  % 13
  fis2. g4 |
  % 14
  g8 a b4. a4 gis8 |
  % 15
  a2. d,4 |
  % 16
  d4. e8 d g fis4 |
  % 17
  d2. 
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
  a8 d b4 c c |
  % 3
  d2. d4 |
  % 4
  d4. g8 fis4 g8 g, |
  % 5
  e'4 a, b b |
  % 6
  a8 d b4 c c |
  % 7
  d2. d4 |
  % 8
  d4. g8 fis4 g8 g, |
  % 9
  e'4 a, b a |
  % 10
  d c b8 c d4 |
  % 11
  d2. d8 c |
  % 12
  b a a d d g e16 d e8 |
  % 13
  d2. b4 |
  % 14
  c d8 e16 f g8 c, f e |
  % 15
  e2. g4 |
  % 16
  fis8 d b a a b c a |
  % 17
  b2. 
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s2. g'4 |
  % 2
  fis g c,8 d e c |
  % 3
  g'2. g4 |
  % 4
  g8 fis g4 d8 c b e |
  % 5
  c b16 c d4 g, g' |
  % 6
  fis g c,8 d e c |
  % 7
  g'2. g4 |
  % 8
  g8 fis g4 d8 c b e |
  % 9
  c b16 c d4 g, d'8 e |
  % 10
  fis e fis d g, a b c |
  % 11
  d2. d4 |
  % 12
  g fis8 b g e a a, |
  % 13
  d2. g4 |
  % 14
  c, g'8 f e f d e |
  % 15
  a,2. b8 g |
  % 16
  d' fis g c, d4 d, |
  % 17
  g2. 
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
  s2. g'4 |
  % 2
  fis g c,8 d e c |
  % 3
  g2. g'4 |
  % 4
  g8 fis g4 d8 c b e |
  % 5
  c b16 c d8 d, g4 g' |
  % 6
  fis g c,8 d e c |
  % 7
  g2. g'4 |
  % 8
  g8 fis g4 d8 c b e |
  % 9
  c b16 c d8 d, g4 d'8 e |
  % 10
  fis e fis d g, a b c |
  % 11
  d2. d4 |
  % 12
  g fis8 b g e a a, |
  % 13
  d2. g,4 |
  % 14
  c g'8 f e f d e |
  % 15
  a,2. b8 g |
  % 16
  d' fis g c, d4 d, |
  % 17
  g2. 
}

trackF = <<

  \clef bass
  
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


trackGchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 6
  
}

trackGchannelB = \relative c {
  s2. d''4 |
  % 2
  d d e e |
  % 3
  d2. b4 |
  % 4
  c b a b8 c |
  % 5
  a2 g4 d' |
  % 6
  d d e e |
  % 7
  d2. b4 |
  % 8
  c b a b8 c |
  % 9
  a2 g4 a |
  % 10
  a a b b |
  % 11
  a2. a4 |
  % 12
  b8 cis d4 d cis |
  % 13
  d2. d4 |
  % 14
  e d c b |
  % 15
  c2. b4 |
  % 16
  a b8 c a4. g8 |
  % 17
  g2. 
}

trackG = <<
  \context Voice = channelA \trackGchannelA
  \context Voice = channelB \trackGchannelB
>>


trackHchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 7
  
}

trackHchannelB = \relative c {
  s2. g''8 d |
  % 2
  d b b g g g' g c |
  % 3
  b2. g8 d |
  % 4
  d a' g d d16 b d4 g d8 d16 b d8 b4 g'8 d |
  % 6
  d b b g g g' g c |
  % 7
  b2. g8 d |
  % 8
  d a' g d d16 b d4 g d8 d16 b d8 b4 d |
  % 10
  d16*9 b16 d b g8 g' |
  % 11
  d2. d4 |
  % 12
  d8 a' a d, b' g a4 |
  % 13
  a2. b8 g |
  % 14
  g c b g g a s8 b |
  % 15
  a2. g8 d |
  % 16
  d16 b d8 g, g' g d d16 b d8 |
  % 17
  b2. 
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
