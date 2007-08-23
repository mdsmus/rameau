% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 222.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 3/4 
  

  \key g \major
  
  \tempo 4 = 104 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  g''4 g a b |
  % 2
  g2 a4 a |
  % 3
  b c2 b4 |
  % 4
  c2. b4 |
  % 5
  b cis d a2 b4 cis d |
  % 7
  d2 cis4 d2. a4 a |
  % 9
  b c d e |
  % 10
  d2 c4 b2 a4 e'4. d8 |
  % 12
  c4 d4. c8 b4 |
  % 13
  c c b a2 g4 e'4. d8 |
  % 15
  c4 d4. c8 b4 |
  % 16
  c c b a2 g4 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  d'4 e fis g8 f |
  % 2
  e2 f |
  % 3
  f4 g2 g4 |
  % 4
  g2. g4 |
  % 5
  g g fis fis2 g4 g fis8 g |
  % 7
  a4 g8 fis g e fis2. fis4 fis |
  % 9
  gis a4. gis8 a g |
  % 10
  fis4 gis a a |
  % 11
  gis e e8 fis g4 |
  % 12
  a a8 g fis4 g |
  % 13
  g a g g |
  % 14
  fis d e8 fis g4 |
  % 15
  a a8 g fis4 g |
  % 16
  g a g g |
  % 17
  fis d 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  b'4 b d d |
  % 2
  c2 c |
  % 3
  d4 e2 d8 f |
  % 4
  e2. d4 |
  % 5
  d e a, d2 d4 a d4. c8 b4 a a2. d4 d |
  % 9
  d e d c8 b |
  % 10
  a4 b c8 e f4 |
  % 11
  e8 d c4 g' c,8 d |
  % 12
  e4 d2 d4 |
  % 13
  e d d e |
  % 14
  d8 c b4 g' c,8 d |
  % 15
  e4 d2 d4 |
  % 16
  e d d e |
  % 17
  d8 c b4 
}

trackD = <<
  \context Voice = channelA \trackDchannelA
  \context Voice = channelB \trackDchannelB
>>


trackEchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 4
  
}

trackEchannelB = \relative c {
  g'8 fis e4 d g, |
  % 2
  c2 f4. e8 |
  % 3
  d4 c e g |
  % 4
  c,2. g'4 |
  % 5
  g8 fis e4 d2 |
  % 6
  d4 g a b |
  % 7
  fis g a d,2. d4 c |
  % 9
  b a b c2 b4 a d |
  % 11
  e a, c'4. b8 |
  % 12
  a g fis e d4 g8 fis |
  % 13
  e4 fis g c, |
  % 14
  d g, c'4. b8 |
  % 15
  a g fis e d4 g8 fis |
  % 16
  e4 fis g c, |
  % 17
  d g, 
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
