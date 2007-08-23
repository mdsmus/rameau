% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 183.mid
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
  g d g c |
  % 3
  b a g g |
  % 4
  a8 b c4 b a |
  % 5
  e fis g g |
  % 6
  g d g c |
  % 7
  b a g g |
  % 8
  a8 b c4 b a |
  % 9
  e fis g g |
  % 10
  c b a d |
  % 11
  d cis d d |
  % 12
  e c d4. c8 |
  % 13
  b4 a g b |
  % 14
  a d, g c |
  % 15
  b a g2 |
  % 16
  
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
  d a d a' |
  % 3
  d, d8. c16 b4 b8 cis |
  % 4
  d f e fis g4 d8 a16 b |
  % 5
  c4 c b d |
  % 6
  d a d a' |
  % 7
  d, d8. c16 b4 b8 cis |
  % 8
  d f e fis g4 d8 a16 b |
  % 9
  c4 c b d |
  % 10
  g8 a4 g16 fis e4 a8 fis |
  % 11
  e g4 fis16 e fis4 g |
  % 12
  g g a8 fis g a4 g fis8 e4 e4. d16 c b4 e8 d e fis |
  % 15
  g4. fis8 d2 |
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
  s2. b'8 a |
  % 2
  g4 fis g4. fis8 |
  % 3
  g4. fis8 d4 g |
  % 4
  fis8 gis a4 d,8 e fis4 |
  % 5
  g a d, b'8 a |
  % 6
  g4 fis g4. fis8 |
  % 7
  g4. fis8 d4 g |
  % 8
  fis8 gis a4 d,8 e fis4 |
  % 9
  g a d, g8 fis |
  % 10
  e' d d4 cis d |
  % 11
  b8 e, a4 a d4. c16 b c8 e d c b a |
  % 13
  b16 c d4 c8 b4 g |
  % 14
  a g8 a b4 a |
  % 15
  d16*7 c16 b2 |
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
  s2. g8 a |
  % 2
  b c d c b4 a |
  % 3
  g8 b d4 g, e' |
  % 4
  d a b8 c d4 |
  % 5
  c8 b a4 g g8 a |
  % 6
  b c d c b4 a |
  % 7
  g8 b d4 g, e' |
  % 8
  d a b8 c d4 |
  % 9
  c8 b a4 g g'8 f |
  % 10
  e fis g4. a16 g fis8 b |
  % 11
  g4 a8 a, d4 b |
  % 12
  c8 d e4 fis8 d e fis |
  % 13
  g4 d e e |
  % 14
  fis g8 fis e4 a, |
  % 15
  b8 c d4 g,2 |
  % 16
  
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
