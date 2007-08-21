% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 025900b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key e \minor
  
  \tempo 4 = 80 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  e'4 e g g |
  % 2
  a a b b |
  % 3
  b d c b |
  % 4
  a4. a8 g2 |
  % 5
  a4 a b g |
  % 6
  fis4. fis8 e2 |
  % 7
  e'4 e d d |
  % 8
  cis cis b b |
  % 9
  d d c b |
  % 10
  a4. a8 g2 |
  % 11
  a4 a b g |
  % 12
  fis4. fis8 e2 |
  % 13
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  b'4 b e e |
  % 2
  e a8 fis g4 g |
  % 3
  g g g8 fis g4 |
  % 4
  g fis d2 |
  % 5
  fis4 e dis8 fis b, e16 dis |
  % 6
  e4 dis b2 |
  % 7
  g'4 g fis fis |
  % 8
  g fis fis fis |
  % 9
  fis g g8 a4 g8 |
  % 10
  g4 fis d2 |
  % 11
  e4 fis fis4. e8 |
  % 12
  e4 dis b2 |
  % 13
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  g'4 g b b |
  % 2
  c d d d |
  % 3
  d d8 b c d d4 |
  % 4
  e8 c a d16 c b2 |
  % 5
  d4 a4. g16 fis g8 c4 a8 fis b16 a g2 |
  % 7
  b4 b b b |
  % 8
  b4. ais8 d4 d |
  % 9
  d8 c b4 e8 d4 e c8 a d16 c b2 |
  % 11
  cis4 d8 c b4 b8 c4 a8 fis b16 a gis2 |
  % 13
  
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
  e8 fis g fis e d c b |
  % 2
  a g fis d g4 g' |
  % 3
  g,8 a b e a, d g, b |
  % 4
  c a d4 g,2 |
  % 5
  fis'8 e d c b dis e c |
  % 6
  a fis b4 e,2 |
  % 7
  e8 fis g a b cis d b |
  % 8
  e cis fis4 b,2 |
  % 9
  b'8 a g fis e fis g e |
  % 10
  c a d4 g,2 |
  % 11
  g'4 fis8 e dis4 e8 c |
  % 12
  a fis b4 e,2 |
  % 13
  
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
