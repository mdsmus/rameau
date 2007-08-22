% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 344.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 12/8 
  

  \key g \major
  
  \tempo 4 = 120 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s8*9 g'''4. fis e fis d |
  % 4
  e fis g g g d d4 c8 b4 c8 |
  % 7
  d4. c b b e e d4 e8 fis4. |
  % 10
  g4 fis8 e4. d g fis e d e4 d8 |
  % 13
  c4 b8 a4. g2. 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s8*9 b''4. a b4 a8 a4. g |
  % 4
  g4 c8 b4 a8 b4. b b b a g |
  % 7
  a4 e8 e8. g16 fis8 g4. g g g4 a8 b4 a8 a4 b8 |
  % 10
  b4 a8 b4 a8 a4. b c4 b8 b4 a8 a4 g8 g4. |
  % 13
  g g4 fis8 d2. 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s8*9 d'4. d d4 cis8 d4 c8 c4 b8 |
  % 4
  b4 a8 d4. d d e fis4 g8 d4. d4 e8 |
  % 7
  a,4 b8 c8. e16 dis8 e4. e e4 d8 c4. b4 cis8 d4. |
  % 10
  g,4 d'8 d4 cis8 fis4. e e4 d8 d4 c8 c4 b8 c4 b8 |
  % 13
  c4 d8 e4 d8 b2. 
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  s8*9 g'4. d' g,4 a8 d,4. g |
  % 4
  c, d g, g'4 fis8 e4. b' fis g4 e8 |
  % 7
  fis4 gis8 a4. e e4 d8 c4 d8 e4 c8 g'4. fis4 b8 |
  % 10
  e,4 fis8 g4 a8 d,4. e4 g8 a4 b8 g4 a8 fis4 g8 c,4 d8 |
  % 13
  e4 d8 c4 d8 g,2. 
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
