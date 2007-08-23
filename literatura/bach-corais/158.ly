% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 158.mid
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
  g g a b |
  % 3
  c8 b a4 g2 |
  % 4
  a4 a e fis |
  % 5
  g a g g |
  % 6
  g g a b |
  % 7
  c8 b a4 g2 |
  % 8
  a4 a e fis |
  % 9
  g a g g |
  % 10
  d' d e d8 c |
  % 11
  b4 cis d d |
  % 12
  d d e d8 c |
  % 13
  b4 a g2 |
  % 14
  e4 fis g e |
  % 15
  d cis d2 |
  % 16
  g4 g a b |
  % 17
  c8 b a4 g2 |
  % 18
  a4 a e fis |
  % 19
  g8 fis e4 d f |
  % 20
  e c e fis |
  % 21
  g a g2 |
  % 22
  
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
  e e4. fis8 g4 |
  % 3
  g4. fis8 d2 |
  % 4
  fis4 e8 d e4. d16 c |
  % 5
  b8 g d'4 d d |
  % 6
  e e4. fis8 g4 |
  % 7
  g4. fis8 d2 |
  % 8
  fis4 e8 d e4. d16 c |
  % 9
  b8 g d'4 d d |
  % 10
  d g8 a b c b a |
  % 11
  g4 g a a |
  % 12
  g g g a4. g4 fis8 d2 |
  % 14
  c4 c d8 b4 a8 |
  % 15
  a b a4 a2 |
  % 16
  e'4 e e8 fis g4 |
  % 17
  g4. fis8 d2 |
  % 18
  d4 d cis d |
  % 19
  d cis a d |
  % 20
  c g c d |
  % 21
  d4. c8 b2 |
  % 22
  
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
  b c c d8 f |
  % 3
  e4 a,8 d16 c b2 |
  % 4
  d4 c8 b4 a b16 a |
  % 5
  g4. fis8 b4 b |
  % 6
  b c c d8 f |
  % 7
  e4 a,8 d16 c b2 |
  % 8
  d4 c8 b4 a b16 a |
  % 9
  g4. fis8 b4 b |
  % 10
  a8 c b a g4 d' |
  % 11
  d e fis d8 c |
  % 12
  b c d b c b a d |
  % 13
  d4 d8. c16 b2 |
  % 14
  g4 a d,8 g4 fis16 e |
  % 15
  fis4 e8 fis16 g fis2 |
  % 16
  b4 c c d8 f |
  % 17
  e4 a,8 d16 c b2 |
  % 18
  fis8 g a4 a a |
  % 19
  b e,8 a16 g fis4 g |
  % 20
  g e a a |
  % 21
  g fis g2 |
  % 22
  
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
  e d c b a4 g |
  % 3
  c d g,2 |
  % 4
  d'4 a8 b c4 d |
  % 5
  e d g, g'8 fis |
  % 6
  e d c b a4 g |
  % 7
  c d g,2 |
  % 8
  d'4 a8 b c4 d |
  % 9
  e d g, g' |
  % 10
  fis g8 fis e4 fis |
  % 11
  g8 fis e4 d fis |
  % 12
  g8 a b g c4 fis, |
  % 13
  g d g,2 |
  % 14
  c8 b a4 b cis |
  % 15
  d a d,2 |
  % 16
  e'8 d c b a4 g |
  % 17
  c d g,2 |
  % 18
  d8 e fis g a g fis4 |
  % 19
  e a d b |
  % 20
  c4. b8 a4 d8 c |
  % 21
  b g d'4 g,2 |
  % 22
  
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
