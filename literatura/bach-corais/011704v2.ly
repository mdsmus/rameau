% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 011704v2.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \major
  
  \tempo 4 = 93 
  
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
  e d c d |
  % 4
  b8 a g a b4 cis |
  % 5
  d e d d |
  % 6
  d d d8 e f4 |
  % 7
  e d c d |
  % 8
  b8 a g a b4 cis |
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
  e fis g2 |
  % 16
  
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
  a g8 fis g4 c,8 d |
  % 3
  e f g4 g a |
  % 4
  g d g8 fis e4 |
  % 5
  a8 fis g4 fis g |
  % 6
  a g8 fis g4 c,8 d |
  % 7
  e f g4 g a |
  % 8
  g d g8 fis e4 |
  % 9
  a8 fis g4 fis b |
  % 10
  b a8 b cis4 cis |
  % 11
  d a8 g fis4 g |
  % 12
  g g g g |
  % 13
  a8 b e, a gis4 g |
  % 14
  a g8 a b g e4 |
  % 15
  e d d2 |
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
  a b8 c b4 a |
  % 3
  g8 c c b e4 d |
  % 4
  d8 c b a g4 a |
  % 5
  a8 d4 cis8 d4 b |
  % 6
  a b8 c b4 a |
  % 7
  g8 c c b e4 d |
  % 8
  d8 c b a g4 a |
  % 9
  a8 d4 cis8 d4 d |
  % 10
  d8 e fis g a g fis e |
  % 11
  d4 cis a b |
  % 12
  b8 c d4 c g8 e' |
  % 13
  d b c e16 dis e4 d |
  % 14
  d e d c8 b |
  % 15
  a2 b |
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
  fis d g, a8 b |
  % 3
  c4 g c fis |
  % 4
  g4. fis8 e fis g a |
  % 5
  fis d a'4 d, b' |
  % 6
  fis d g, a8 b |
  % 7
  c4 g c fis |
  % 8
  g4. fis8 e fis g a |
  % 9
  fis d a'4 d, g8 a |
  % 10
  b cis d4 a ais |
  % 11
  b8 g a4 d, g8 fis |
  % 12
  e d c b c d e4 |
  % 13
  fis8 gis a4 e g |
  % 14
  fis e8 fis g4 c, |
  % 15
  cis d g,2 |
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
  s2. g'4 |
  % 2
  fis d g, a8 b |
  % 3
  c4 g c fis, |
  % 4
  g4. fis8 e fis g a |
  % 5
  fis d a'4 d, g' |
  % 6
  fis d g, a8 b |
  % 7
  c4 g c fis, |
  % 8
  g4. fis8 e fis g a |
  % 9
  fis d a'4 d, g'8 a |
  % 10
  b cis d4 a ais |
  % 11
  b8 g a4 d, g8 fis |
  % 12
  e d c b c d e4 |
  % 13
  fis8 gis a4 e g |
  % 14
  fis e8 fis g4 c, |
  % 15
  cis d g,2 |
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
