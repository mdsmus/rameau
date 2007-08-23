% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 051.mid
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
  g g a g |
  % 3
  c d c2 |
  % 4
  b8 c d4 e d8 c |
  % 5
  b4 a g g |
  % 6
  c b8 c d4 a |
  % 7
  g8 fis e4 d d |
  % 8
  a' a a b |
  % 9
  c8 b a4 g8 a b4 |
  % 10
  a2 g4 g |
  % 11
  g2 g |
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
  e d8 e fis4 e |
  % 3
  g g8 f e2 |
  % 4
  g8 a b4 c8 b a4 |
  % 5
  g fis d d8 e |
  % 6
  fis4 g g fis8 e |
  % 7
  d b cis4 a a |
  % 8
  d cis fis g |
  % 9
  a8 g4 fis8 e a g4 |
  % 10
  fis2 d8 e f4 |
  % 11
  e e d2 |
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
  c b a8 d b4 |
  % 3
  e8 c b4 g2 |
  % 4
  e'4 f g d |
  % 5
  d4. c8 b4 g |
  % 6
  a d8 c b g d'4 |
  % 7
  d a8 g fis4 fis8 g |
  % 8
  a b cis e d4 d |
  % 9
  e8 d e d4 c8 b c |
  % 10
  d2 d4 b |
  % 11
  g c b2 |
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
  s2. g'8 fis |
  % 2
  e fis g4 d e8 d |
  % 3
  c4 g c2 |
  % 4
  e4 d c fis, |
  % 5
  g8 b d4 g, b |
  % 6
  a g8 a b c d c |
  % 7
  b g a4 d d8 e |
  % 8
  fis g a cis, d c b4 |
  % 9
  a8 b c d e fis g4 |
  % 10
  d2 b8 a g4 |
  % 11
  c8 e16 d c8 c, g'2 |
  % 12
  
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
