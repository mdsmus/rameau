% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 011205b_.mid
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
  s2. g''8 a |
  % 2
  b4 c d c |
  % 3
  b a b b |
  % 4
  b a8 b c b a4 |
  % 5
  g8. a16 a4 g g8 a |
  % 6
  b4 c d c |
  % 7
  b a b b |
  % 8
  b a8 b c b a4 |
  % 9
  g8. a16 a4 g g |
  % 10
  a b c b |
  % 11
  a4. gis8 a4 a |
  % 12
  b c d c |
  % 13
  b a b b |
  % 14
  b a8 b c b a4 |
  % 15
  g8. a16 a4 g2 |
  % 16
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. d'8 fis |
  % 2
  g4 g fis e8 fis |
  % 3
  g4 g8 fis g4 g |
  % 4
  g fis8 g a g fis4 |
  % 5
  g4. fis8 d4 d8 fis |
  % 6
  g4 g fis e8 fis |
  % 7
  g4 g8 fis g4 g |
  % 8
  g fis8 g a g fis4 |
  % 9
  g4. fis8 d4 d |
  % 10
  d d e e |
  % 11
  e8 c f e e4 fis |
  % 12
  g f e e8 fis |
  % 13
  g4. fis16 e dis4 e |
  % 14
  d8 e fis g a g4 fis8 |
  % 15
  e d e d d2 |
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
  s2. b'8 c |
  % 2
  d4 e a, a |
  % 3
  d d d e |
  % 4
  d d e8 d d c |
  % 5
  b4 e8 d16 c b4 b8 c |
  % 6
  d4 e a, a |
  % 7
  d d d e |
  % 8
  d d e8 d d c |
  % 9
  b4 e8 d16 c b4 b |
  % 10
  a g g gis |
  % 11
  a d c a |
  % 12
  d c b c8 d |
  % 13
  e4 e, fis g8 a |
  % 14
  b c d g, fis g16 fis e8 fis |
  % 15
  g4. fis8 b2 |
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
  s2. g4 |
  % 2
  g'8 fis e4 d a |
  % 3
  b8 c d4 g, e' |
  % 4
  b8 c d4 a8 b c d |
  % 5
  e d c d g,4 g |
  % 6
  g'8 fis e4 d a |
  % 7
  b8 c d4 g, e' |
  % 8
  b8 c d4 a8 b c d |
  % 9
  e d c d g,4 g' |
  % 10
  fis f e d |
  % 11
  c8 f d e a,4 d8 c |
  % 12
  b4 a gis a |
  % 13
  e'8 d c4 b e8 fis |
  % 14
  g4 fis8 e dis e cis dis |
  % 15
  e b c d g,2 |
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
  s2. g''8 a |
  % 2
  b4 c d c |
  % 3
  b a b b |
  % 4
  b a8 b c b a4 |
  % 5
  g8. a16 a4 g g8 a |
  % 6
  b4 c d c |
  % 7
  b a b b |
  % 8
  b a8 b c b a4 |
  % 9
  g8. a16 a4 g g |
  % 10
  a b c b |
  % 11
  a8. b16 b4 a a |
  % 12
  b c d c |
  % 13
  b a b b |
  % 14
  b a8 b c b a4 |
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
  s2. b'8 d |
  % 2
  g4 g a a |
  % 3
  g d g g |
  % 4
  g d8 g a g d4 |
  % 5
  b s8 d32 b d16 b4 b8 d |
  % 6
  g4 g a a |
  % 7
  g d g g |
  % 8
  g d8 g a g d4 |
  % 9
  b s8 d32 b d16 b4 b |
  % 10
  d g g, s1 d'4 |
  % 12
  g a b a |
  % 13
  g s2 g4 |
  % 14
  g e8 g a g4 b,8 |
  % 15
  b4 s8 d32 b d16 b2 |
  % 16
  
}

trackG = <<
  \context Voice = channelA \trackGchannelA
  \context Voice = channelB \trackGchannelB
>>


trackHchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 7
  
}

trackHchannelB = \relative c {
  s2. g''8 fis |
  % 2
  g4 g fis e8 fis |
  % 3
  g4 g8 fis g4 g |
  % 4
  g fis e16 fis g8 fis4 |
  % 5
  g4. fis8 g4 g8 fis |
  % 6
  g4 g fis e8 fis |
  % 7
  g4 g8 fis g4 g |
  % 8
  g fis e16 fis g8 fis4 |
  % 9
  g4. fis8 g4 g |
  % 10
  d d g8 a b4 |
  % 11
  e,8 c f e16 d c4 fis |
  % 12
  g f e e8 fis |
  % 13
  g4. fis16 e dis4 e |
  % 14
  d8 e fis g a g4 fis8 |
  % 15
  e d e fis g2 |
  % 16
  
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
