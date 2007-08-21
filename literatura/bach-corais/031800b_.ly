% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 031800b_.mid
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
  g''4 g8 a b4 c |
  % 2
  d e d2 |
  % 3
  e4 fis g d |
  % 4
  b cis d2 |
  % 5
  c4 a b c |
  % 6
  b a g2 |
  % 7
  fis4 g a b |
  % 8
  a4. g8 fis4 e |
  % 9
  d1 |
  % 10
  g4 g8 a b4 c |
  % 11
  d e d2 |
  % 12
  g,4 a b c |
  % 13
  b a g2 |
  % 14
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  d'4 e8 fis g4 fis8 e |
  % 2
  d fis b a fis2 |
  % 3
  a4 a g a |
  % 4
  g8 fis e4 fis2 |
  % 5
  e4 d d c |
  % 6
  d4. c8 b2 |
  % 7
  d4 cis8 b a4 d |
  % 8
  e8*5 d4 cis8 |
  % 9
  a1 |
  % 10
  d4 e8 fis g4 g |
  % 11
  f e8 fis g2 |
  % 12
  g8 e d c b a g fis' |
  % 13
  g4. fis8 d2 |
  % 14
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  b'4 c d c |
  % 2
  b16 c d4 cis8 d2 |
  % 3
  c8 b c d b4 a |
  % 4
  d a a2 |
  % 5
  g4 a g8 fis g4 |
  % 6
  g fis g2 |
  % 7
  a4 g d'8 cis b4 |
  % 8
  e, a2 g4 |
  % 9
  fis1 |
  % 10
  g4 c d c4. b8 c4 b2 |
  % 12
  b4 a d e8 a, |
  % 13
  b c d4 b2 |
  % 14
  
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
  g'4 c, g8 g' a4 |
  % 2
  b8 a g a d,2 |
  % 3
  a'4 d, e fis |
  % 4
  g a d,2 |
  % 5
  e4 fis g e |
  % 6
  d8 c d4 g,2 |
  % 7
  d'4 e fis g |
  % 8
  cis, a d a |
  % 9
  d1 |
  % 10
  b4 c g' e |
  % 11
  d c g'2 |
  % 12
  e4 fis g e |
  % 13
  d2 g |
  % 14
  
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
