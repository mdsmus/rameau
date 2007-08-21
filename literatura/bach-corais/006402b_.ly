% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 006402b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. g''4 |
  % 2
  g g a g |
  % 3
  c d c2 |
  % 4
  b4 d e d |
  % 5
  b a g g |
  % 6
  c b d a |
  % 7
  g e d d |
  % 8
  a' a a b |
  % 9
  c a g8 a b4 |
  % 10
  a2 g4 g |
  % 11
  g1 |
  % 12
  
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
  e e f g |
  % 3
  a b a2 |
  % 4
  g4 g g fis |
  % 5
  g fis d e |
  % 6
  e8 fis g4 g f |
  % 7
  e8 d cis4 a d |
  % 8
  d a'8 g fis4 gis |
  % 9
  a f e8 fis g2 f4. e8 e2 d8 c d2 |
  % 12
  
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
  b c c c8 d |
  % 3
  e4 f e2 |
  % 4
  e4 d c8 b a4 |
  % 5
  b8 c d4 b b |
  % 6
  c d d d8 c |
  % 7
  b4 a8 g fis4 fis8 g |
  % 8
  a b cis4 d d |
  % 9
  e c c d4. a8 d c b4 c2 b8 a b2 |
  % 12
  
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
  e c f e |
  % 3
  a gis a2 |
  % 4
  e4 b' c d |
  % 5
  g, d g e |
  % 6
  a g b,8 c d4 |
  % 7
  g, a d d8 e |
  % 8
  fis g a b c4 b |
  % 9
  a a,8 b c4 b8 c |
  % 10
  d4 c8 d e4 d8 c |
  % 11
  g'1 |
  % 12
  
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
  e c f e |
  % 3
  a gis a2 |
  % 4
  e4 b c d |
  % 5
  g d g, e' |
  % 6
  a, g8 a b c d4 |
  % 7
  g, a d d8 e |
  % 8
  fis g a b c4 b |
  % 9
  a a,8 b c4 b8 c |
  % 10
  d4 c8 d e4 d8 c |
  % 11
  g'2 g, |
  % 12
  
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
