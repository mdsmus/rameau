% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 015.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 80 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. a''4 |
  % 2
  gis a8 b c4 d |
  % 3
  c b a a |
  % 4
  f g a g8 f |
  % 5
  e d e4 d a' |
  % 6
  gis a8 b c4 d |
  % 7
  c b a a |
  % 8
  f g a g8 f |
  % 9
  e d e4 d2 |
  % 10
  d8 e f4 g d8 e |
  % 11
  f4 g a a |
  % 12
  d cis d e8 d |
  % 13
  c4 b a b |
  % 14
  c a8 ais c4 g |
  % 15
  f e d2 |
  % 16
  a'4 g f e |
  % 17
  d1 |
  % 18
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. f'4 |
  % 2
  f8 e4 gis8 a4 b4. a4 gis8 e4 e4. d8 cis d e4. d8 |
  % 5
  cis d4 cis8 a4 f' |
  % 6
  f8 e4 gis8 a4 b4. a4 gis8 e4 e4. d8 cis d e4. d8 |
  % 9
  cis d4 cis8 a2 |
  % 10
  a4 d d8 c ais c |
  % 11
  d a d c c4 f8 g |
  % 12
  a ais4 a8 a4 e4. f4 e8 e4 f4. e8 f4 f e4. d8 cis d d2 |
  % 16
  d4. e8 cis d4 cis8 |
  % 17
  a1 |
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
  s2. d'8 c |
  % 2
  b4 c8 d e4 f8 e |
  % 3
  e f4 e16 d cis4 a |
  % 4
  a ais a a |
  % 5
  a8 f g e f4 d'8 c |
  % 6
  b4 c8 d e4 f8 e |
  % 7
  e f4 e16 d cis4 a |
  % 8
  a ais a a |
  % 9
  a8 f g e f2 |
  % 10
  f8 g a4 g8 a ais4 |
  % 11
  a8 f'4 e8 f4 c |
  % 12
  f, g d'8 c b4. a4 gis8 c4 d |
  % 14
  g,8 c c4 c8 d e d |
  % 15
  cis a ais a16 g f2 |
  % 16
  a8 c ais4 a g2 fis8 e fis2 |
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
  s2. d4 |
  % 2
  d c8 b a a'4 gis8 |
  % 3
  a f d e a,4 cis |
  % 4
  d8 f e d cis a d4 |
  % 5
  a' a, d d |
  % 6
  d c8 b a a'4 gis8 |
  % 7
  a f d e a,4 cis |
  % 8
  d8 f e d cis a d4 |
  % 9
  a' a, d2 |
  % 10
  d4. c8 ais a g4 |
  % 11
  d'8 c ais c f,4 f'8 e |
  % 12
  d4 e fis gis |
  % 13
  a8 f d e a,4 d |
  % 14
  c f,8 g a ais c ais |
  % 15
  a f g a ais2 |
  % 16
  fis4 g a2 |
  % 17
  d,1 |
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
