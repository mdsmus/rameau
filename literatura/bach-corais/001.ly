% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 001.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  \key g \major
 
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  \key g \major
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  \partial 4 g''4 g2 d'4 b4. a8 
  % 3
  g4 g4. a8 b4 
  % 4
  a2 b4 d2 c4 b a2 g g4 
  % 7
  g2 d'4 b4. a8 g4 g4. a8 
  % 9
  b4 a2 b4 
  % 10
  d2 c4 b 
  % 11
  a2 g 
  % 12
  b4 b c d 
  % 13
  d4. c8 b4 a2 g4 b2 
  % 15
  c4 d2 c4 
  % 16
  b2. g2 b4 d2 
  % 18
  c4 b2 a4 
  % 19
  g4. a8 b4 a2 b4 d2 
  % 21
  c4 b a2 
  % 22
  g 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  \key g \major
   \partial 4  d'4 d 
  % 2
  e d d2 
  % 3
  b4 e8 d e fis g4 
  % 4
  fis2 g4 d 
  % 5
  e fis g2 
  % 6
  fis4 d2 d4 
  % 7
  d e d d2 b4 e8 d e fis 
  % 9
  g4 fis2 g4 
  % 10
  d e fis g2 fis4 d2 
  % 12
  g4. fis8 e fis g4. a8 g fis g4 fis2 e4 e fis8 g 
  % 15
  a4 a g4. fis8 
  % 16
  g2 f4 e2 g4 a4. g8 
  % 18
  fis4 g2 fis4 
  % 19
  fis8 e e fis g4 fis2 g4 a2 
  % 21
  g8 fis g2 fis4 
  % 22
  d2 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  \key g \major
   \partial 4 b'4 b 
  % 2
  c8 b a4 g fis 
  % 3
  g c8 b c4 d 
  % 4
  d2 d4 a 
  % 5
  b c d e 
  % 6
  d8 c b2 b4 
  % 7
  b c8 b a4 g 
  % 8
  fis g c8 b c4 
  % 9
  d d2 d4 
  % 10
  a b c d 
  % 11
  e d8 c b2 
  % 12
  d4 d c b8 a 
  % 13
  b c d4 d d2 b4 g b 
  % 15
  e d2 d4 
  % 16
  d2. c2 d4 d8 c b4 
  % 18
  c d2 d8 c 
  % 19
  b4 c d d2 d4 d2 
  % 21
  e4 e2 d8 c 
  % 22
  b2 
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
  \key g \major
   \partial 4  g4 g' 
  % 2
  e fis g d 
  % 3
  e c b8 a g4 
  % 4
  d'2 g,4 fis 
  % 5
  g a b c 
  % 6
  d g,2 g4 
  % 7
  g' e fis g 
  % 8
  d e c b8 a 
  % 9
  g4 d'2 g,4 
  % 10
  fis g a b 
  % 11
  c d g,2 
  % 12
  g4 g a b 
  % 13
  b4. a8 g4 d'2 e d4 
  % 15
  c b4. c8 d4 
  % 16
  g,8 a b4 g c2 g4 fis g 
  % 18
  a b g d' 
  % 19
  e8 d c b a g d'2 g fis4 
  % 21
  e e8 d c4 d 
  % 22
  g,2 
}

trackE = <<

  \trackAchannelA
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
