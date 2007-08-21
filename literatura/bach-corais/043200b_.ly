% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 043200b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key g \major
  
  \tempo 4 = 92 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. g''4 |
  % 2
  g a b a8 b |
  % 3
  c b a4 g b |
  % 4
  c b a g |
  % 5
  fis8 g g8. fis32 g a4 d |
  % 6
  c b a g8 fis |
  % 7
  e8. fis32 g e4 d b' |
  % 8
  c b a g8 a |
  % 9
  b4 a g2 |
  % 10
  
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
  e4. d8 d e fis4 |
  % 3
  e8 g16 fis e8 fis d4 g |
  % 4
  g8 a4 g8 fis e16 dis e4 |
  % 5
  d d d fis |
  % 6
  e d8 cis16 d e8 fis16 e d4 |
  % 7
  d cis d fis |
  % 8
  e d e8 fis g4 |
  % 9
  g fis d2 |
  % 10
  
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
  b a8 fis g4 a |
  % 3
  a8 d c b16 a b4 d |
  % 4
  e8 dis4 e8 c4 b |
  % 5
  a b fis b8 a |
  % 6
  g a b4 cis b |
  % 7
  b8 g a4 fis fis |
  % 8
  g8 a b4 e,8 b'4 c8 |
  % 9
  d4 c16 b c8 b2 |
  % 10
  
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
  e d c d g,4 d' |
  % 3
  a8 b c d g,4 g'8 fis |
  % 4
  e4 e e4. d8 |
  % 5
  c b a g d'4 b |
  % 6
  e8 fis g4. fis8 b a |
  % 7
  g e a4 d, dis |
  % 8
  e8 fis g4 cis,8 dis e d16 c |
  % 9
  b8 c d4 g,2 |
  % 10
  
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
