% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 003.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key e \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. b''4 |
  % 2
  c b a e' |
  % 3
  e8 d c4 b d |
  % 4
  c b a b8 c16 d |
  % 5
  c4 b a b |
  % 6
  c b a e' |
  % 7
  e8 d c4 b d |
  % 8
  c b a b8 c16 d |
  % 9
  c4 b a a |
  % 10
  b8 a g4 fis e8 fis |
  % 11
  g4 a b g |
  % 12
  a8 b c4 b c8 b |
  % 13
  a4 gis a a |
  % 14
  e' c d e |
  % 15
  d c b2 |
  % 16
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. gis''4 |
  % 2
  a gis a gis8 a |
  % 3
  b4 e,8 fis gis4 gis |
  % 4
  a gis a8 g f4 |
  % 5
  e2 e4 gis |
  % 6
  a gis a gis8 a |
  % 7
  b4 e,8 fis gis4 gis |
  % 8
  a gis a8 g f4 |
  % 9
  e2 e4 d |
  % 10
  d8 dis e4 dis e8 dis |
  % 11
  e g fis e dis4 b |
  % 12
  a a' gis a |
  % 13
  e e e e |
  % 14
  e e f g |
  % 15
  fis8 gis a4 e2 |
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
  s2. e'4 |
  % 2
  e d e d8 c |
  % 3
  b4 c8 d e4 f |
  % 4
  e e8 d c4 d |
  % 5
  gis,8 a4 gis8 c4 e |
  % 6
  e d e d8 c |
  % 7
  b4 c8 d e4 f |
  % 8
  e e8 d c4 d |
  % 9
  gis,8 a4 gis8 c4 a |
  % 10
  g8 a b4 b b8 a |
  % 11
  b4 c fis, e'8 d |
  % 12
  c d e4 e e8 d |
  % 13
  c4 b c c |
  % 14
  b a a ais |
  % 15
  a8 e fis4 gis2 |
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
  s2. e4 |
  % 2
  a b c b8 a |
  % 3
  gis4 a e b |
  % 4
  c8 d e4 f e8 d |
  % 5
  e2 a,4 e' |
  % 6
  a b c b8 a |
  % 7
  gis4 a e b |
  % 8
  c8 d e4 f e8 d |
  % 9
  e2 a,4 fis' |
  % 10
  g8 fis e4 b'8 a g fis |
  % 11
  e d c4 b e |
  % 12
  f c8 d e4 a,8 b |
  % 13
  c d e4 a, a' |
  % 14
  gis a8 g f e d cis |
  % 15
  d4 dis e2 |
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
