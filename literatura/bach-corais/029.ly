% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 029.mid
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
  g''4 a b a |
  % 2
  g fis e d |
  % 3
  g a b c |
  % 4
  b a g2 |
  % 5
  g4 a b a |
  % 6
  g fis e d |
  % 7
  g a b c |
  % 8
  b a g2 |
  % 9
  b4 c d c |
  % 10
  b a b2 |
  % 11
  d4 d e d |
  % 12
  c b a2 |
  % 13
  b4 d c b8 a |
  % 14
  g4 a b2 |
  % 15
  g b8 c d4 |
  % 16
  c b a b |
  % 17
  a2 g |
  % 18
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  d'4 d d d |
  % 2
  d8 cis d4 cis a |
  % 3
  e' d d a' |
  % 4
  d, d d2 |
  % 5
  d4 d d d |
  % 6
  d8 cis d4 cis a |
  % 7
  e' d d a' |
  % 8
  d, d d2 |
  % 9
  g4 g fis g |
  % 10
  g g8 fis g2 |
  % 11
  g4 g g g8 fis |
  % 12
  e4 d8 e fis2 |
  % 13
  g4 g8 fis e fis g fis |
  % 14
  e4 fis g2 |
  % 15
  e g4 a |
  % 16
  g d8 e fis4 g |
  % 17
  g fis d2 |
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
  b'4 a g g8 fis |
  % 2
  g4 a a8 g fis4 |
  % 3
  b a g8 fis e fis |
  % 4
  g4 g8 fis b2 |
  % 5
  b4 a g g8 fis |
  % 6
  g4 a a8 g fis4 |
  % 7
  b a g8 fis e fis |
  % 8
  g4 g8 fis b2 |
  % 9
  d4 e a, e' |
  % 10
  d d d2 |
  % 11
  b4 b c8 b a4 |
  % 12
  g8 a b cis d2 |
  % 13
  d8 c b4 c d |
  % 14
  e8 d c4 d2 |
  % 15
  c d4 d |
  % 16
  g,8 a b c d4 d |
  % 17
  d4. c8 b2 |
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
  g'4 fis g d |
  % 2
  e fis8 g a4 d, |
  % 3
  e fis g a |
  % 4
  b8 c d4 g,2 |
  % 5
  g4 fis g d |
  % 6
  e fis8 g a4 d, |
  % 7
  e fis g a |
  % 8
  b8 c d4 g,2 |
  % 9
  g8 fis e4 d e8 fis |
  % 10
  g4 d g,2 |
  % 11
  g'8 f e d c4 d |
  % 12
  e8 fis g4 d2 |
  % 13
  g4 g, a b |
  % 14
  c8 b a4 g8 a b g |
  % 15
  c2 g'4 fis |
  % 16
  e8 fis g4 c, b8 c |
  % 17
  d4 d, g2 |
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
