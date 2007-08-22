% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 242.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key e \minor
  
  \tempo 4 = 92 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. b''4 |
  % 2
  b a g2 |
  % 3
  fis4 g a g |
  % 4
  fis fis e fis |
  % 5
  g a b2 |
  % 6
  a4 c c b |
  % 7
  a a g a |
  % 8
  a a a fis |
  % 9
  g a b2 |
  % 10
  a4 fis g a |
  % 11
  b b a g8 fis |
  % 12
  fis2 e |
  % 13
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. e'8 dis |
  % 2
  e b cis dis e dis e4 |
  % 3
  e8 dis e4. dis8 e4 |
  % 4
  e dis b dis |
  % 5
  e d8 c b d g4 |
  % 6
  fis e d d |
  % 7
  e d8 c b4 d |
  % 8
  d8 cis d e fis4 d |
  % 9
  d8 e fis4 g d |
  % 10
  d fis b,8 e d c |
  % 11
  b4 e4. dis8 e4 |
  % 12
  e dis b2 |
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
  s2. g'8 a |
  % 2
  b e4 a,8 b2 |
  % 3
  b4 b a8 b16 c b4 |
  % 4
  cis8 fis, b a g4 b |
  % 5
  b8 c b a g b d4 |
  % 6
  d c8 b a fis g2 fis4 g fis8 g |
  % 8
  a4 a d a |
  % 9
  b c d g,4. fis8 b a g4 d'4. f8 e d c4 cis |
  % 12
  b4. a8 gis2 |
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
  s2. e8 fis |
  % 2
  g4. fis8 e fis g e |
  % 3
  b4 e fis g8 e |
  % 4
  ais,4 b e, b' |
  % 5
  e fis g g,8 b |
  % 6
  d4 a'8 g fis d g b, |
  % 7
  c a d4 g, d'8 e |
  % 8
  fis g fis e d e d c |
  % 9
  b c b a g a b c |
  % 10
  d4 dis e fis |
  % 11
  g gis a a |
  % 12
  b b, e2 |
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
