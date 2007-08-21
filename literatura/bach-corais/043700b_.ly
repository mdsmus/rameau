% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 043700b_.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key a \minor
  
  \tempo 4 = 96 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  d'2 a'4 g |
  % 2
  a e f2 |
  % 3
  e g |
  % 4
  f4 e d cis |
  % 5
  d2 a'4 a |
  % 6
  d c b a8 b |
  % 7
  c4 b a2 |
  % 8
  s4 b c a |
  % 9
  a e f f |
  % 10
  e2 d4 e |
  % 11
  f g a g |
  % 12
  f e d2 |
  % 13
  d'4 d e d |
  % 14
  e cis d2 |
  % 15
  d e4 b |
  % 16
  c a a e |
  % 17
  f2 e |
  % 18
  a4 gis a b |
  % 19
  c b a gis |
  % 20
  a2 b4 cis |
  % 21
  d2 a4 g |
  % 22
  a e f2 |
  % 23
  e g |
  % 24
  f4 e d cis |
  % 25
  d8 e f4 e2 |
  % 26
  d f4 g |
  % 27
  a b c b |
  % 28
  a2 s4 g |
  % 29
  f e d2 |
  % 30
  e f4 g |
  % 31
  f g d cis |
  % 32
  d1 |
  % 33
  
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s4 a' d8 f4 e16 d |
  % 2
  e4. d16 cis d2. cis4 s4 d8 e4 d cis8 d16 c ais8 a4 |
  % 5
  a2 f'8 e d4. e16 f e4 e4. d8 |
  % 7
  e f4 e16 d c2 |
  % 8
  s4 e8 f g e c d |
  % 9
  e d e cis a b16 c d4. cis16 b cis4 d4. cis8 |
  % 11
  a ais16 c d8 c c cis d e4 d cis8 a2 |
  % 13
  b8 c d b c4 d8 g |
  % 14
  g a ais g a fis g4. fis16 e fis4 e8 fis gis e |
  % 16
  a4 cis, d4. cis8 |
  % 17
  d4. cis16 b cis2 |
  % 18
  e e4 f4. fis8 g gis a a, b d4 c16 b c4 g'8 f e g4 f16 e f4 
  f4. e4 d cis8 d2 |
  % 23
  e e4 a, |
  % 24
  d8 c ais c a ais g e' |
  % 25
  d cis d2 cis4 |
  % 26
  a2 d4 c2 f8 d e f g e |
  % 28
  f2 s4 f8 e4 d cis8 d2 |
  % 30
  cis8 d e4. d8 cis e |
  % 31
  a, ais4 a b8 a4 |
  % 32
  a1 |
  % 33
  
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s4 f8 g a4 d8 g,4 f16 e a4 a2 |
  % 3
  a s4 d,8 a' |
  % 4
  a4 ais8 a16 g f8 g16 f e f g4 f16 e f4 d' a4. gis8 a4 gis8 
  c4 b16 a |
  % 7
  gis8 a4 gis8 a2 |
  % 8
  s4 g8 f e g a4 |
  % 9
  a4. g8 f8. g16 a4 |
  % 10
  a2 f8 g16 a ais8 a16 g |
  % 11
  f4. e8 f e d ais' |
  % 12
  cis, a' ais a16 g f2 |
  % 13
  g g8 a b g |
  % 14
  c a e'4 d8 c4 ais8 |
  % 15
  a2 a4 e'8 d |
  % 16
  c d e4 a,2 |
  % 17
  a4. gis8 a2 |
  % 18
  a8 b c d c b a gis |
  % 19
  a4 e'4. d8 e4 |
  % 20
  e2 g,4 a |
  % 21
  a2 d4. c16 ais |
  % 22
  a8*5 g8 a b |
  % 23
  c2 cis8 d e4 |
  % 24
  a, g8 a fis g a4. g8 a4 ais a8 g4 f16 e f4 ais8 a g c |
  % 27
  a4 d8 b g4. c8 |
  % 28
  c2 s4 d8 a |
  % 29
  a ais4 a16 g f2 |
  % 30
  a a8 ais4 a16 g |
  % 31
  a8 g16 f g8 f16 e f4 e16 f g4 fis16 e fis2. |
  % 33
  
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
  s4 d8 e f d ais'4 |
  % 2
  cis,4. b16 a d8 e f d |
  % 3
  a2 s4 b8 cis |
  % 4
  d f, g a ais g a4 |
  % 5
  d,2 d'8 e f d |
  % 6
  b4 c8 d e c f4 |
  % 7
  e8 d e4 a,2 |
  % 8
  s4 e'8 d c e f4 |
  % 9
  cis8 b cis a d a f d |
  % 10
  a'2 ais8 a g a |
  % 11
  d c ais c f, g16 a ais8 a16 g |
  % 12
  a8 f g a d,2 |
  % 13
  g8 a b g c4 g'8 b |
  % 14
  e, f g e fis d g4 |
  % 15
  d2 c8 d e4. f8 g e f g a g |
  % 17
  f e d4 a2 |
  % 18
  c8 d e b c4 d4. dis8 e c f4 e |
  % 20
  a,2 e'4 a, |
  % 21
  d2 d8 c ais c |
  % 22
  f, g a4 d,8 e f d |
  % 23
  a'2 e'8 d cis e |
  % 24
  d4. c8 c ais a g |
  % 25
  f e d f g e a4 |
  % 26
  d,2 d'4 e |
  % 27
  f8 e d g e d e c |
  % 28
  f2 s4 b,8 cis |
  % 29
  d ais g a ais2 |
  % 30
  a8 b cis a d4 e4. d4 cis8 d gis, a4 |
  % 32
  d,1 |
  % 33
  
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
