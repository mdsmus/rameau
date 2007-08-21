% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 019406bv.mid
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
  b8 c d4 c b |
  % 14
  g a b2 |
  % 15
  g b4 d |
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
  d'4 d d4. cis8 |
  % 2
  b4 a8 d d cis d4 |
  % 3
  b d d d |
  % 4
  d d d2 |
  % 5
  d4 d d4. cis8 |
  % 6
  b4 a8 d d cis d4 |
  % 7
  b d d d |
  % 8
  d d d2 |
  % 9
  g4 g fis e8 fis |
  % 10
  g4 fis g2 |
  % 11
  g4 g g fis |
  % 12
  e d d2 |
  % 13
  d4 g8 f e4 d |
  % 14
  e8 dis e4. dis16 cis dis4 |
  % 15
  b2 e4 f |
  % 16
  e b8 c d4 d |
  % 17
  d2 d |
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
  b'4 fis g8 fis e4 |
  % 2
  d8 e fis8. g16 a8 e fis4 |
  % 3
  g fis g a |
  % 4
  a8 g g fis b2 |
  % 5
  b4 fis g8 fis e4 |
  % 6
  d8 e fis8. g16 a8 e fis4 |
  % 7
  g fis g a |
  % 8
  a8 g g fis b2 |
  % 9
  d4 e a,8 b c4 |
  % 10
  d d d2 |
  % 11
  b4 b c a |
  % 12
  g g fis2 |
  % 13
  g8 a b4. a4 g fis8 e fis g fis16 e fis4 |
  % 15
  e2 g4 g |
  % 16
  g g fis g4. fis16 e fis4 b2 |
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
  g'4 d g, a |
  % 2
  b8 cis d4 a d, |
  % 3
  e' d8 c b a g fis |
  % 4
  g4 d g2 |
  % 5
  g'4 d g, a |
  % 6
  b8 cis d4 a d, |
  % 7
  e' d8 c b a g fis |
  % 8
  g4 d g2 |
  % 9
  g'8 fis e4 d a |
  % 10
  b8 c d4 g,2 |
  % 11
  g8 a b g c b c d |
  % 12
  e fis g4 d2 |
  % 13
  g4 g, a b |
  % 14
  c c b2 |
  % 15
  e e8 d c b |
  % 16
  c d e d c b a g |
  % 17
  d'4 d, g2 |
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
