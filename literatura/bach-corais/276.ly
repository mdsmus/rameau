% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 276.mid
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
  d' d d d |
  % 3
  e d8 c b4 a |
  % 4
  b8 cis d4 d cis |
  % 5
  d2. d4 |
  % 6
  d d d8 c b c |
  % 7
  d c b4 a d |
  % 8
  c b a a |
  % 9
  g8 a b c d4 d |
  % 10
  c b a a |
  % 11
  g1 |
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
  d8 e fis4 g g8 f |
  % 3
  e g fis4 g a |
  % 4
  g fis e e |
  % 5
  d2. fis4 |
  % 6
  g fis g8 a b a |
  % 7
  g4 g8 fis16 e fis4 fis |
  % 8
  g g8 fis e4 fis |
  % 9
  g fis f e |
  % 10
  e8 fis g fis e4 fis |
  % 11
  d1 |
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
  a a8 b16 c b8 a g4 |
  % 3
  g d' d d |
  % 4
  g, d'8 cis b e a g |
  % 5
  fis2. d8 c |
  % 6
  b c d c b c d4 |
  % 7
  d e a, b8 a |
  % 8
  g a b d e4 d |
  % 9
  d c b b |
  % 10
  c8 d e4 e8 c a b16 c |
  % 11
  b1 |
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
  s2. g'4 |
  % 2
  fis d g8 a b g |
  % 3
  c4 d g, fis |
  % 4
  e b'8 a g4 a |
  % 5
  d,2. d4 |
  % 6
  g8 a b a g4. a8 |
  % 7
  b4 c d b |
  % 8
  e,4. d8 c a d c' |
  % 9
  b4 a gis gis, |
  % 10
  a e'8 d c a d4 |
  % 11
  g,1 |
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
