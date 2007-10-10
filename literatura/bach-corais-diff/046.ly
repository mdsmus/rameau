% Lily was here -- automatically converted by /usr/local/lilypond/usr/bin/midi2ly from 046.mid
\version "2.10.0"


trackAchannelA =  {
  
  \time 4/4 
  

  \key d \major
  
  \tempo 4 = 88 
  
}

trackA = <<
  \context Voice = channelA \trackAchannelA
>>


trackBchannelA = \relative c {
  
  % [SEQUENCE_TRACK_NAME] Instrument 1
  s2. d''4 |
  % 2
  cis b cis a |
  % 3
  b cis d s1. d4 d a |
  % 6
  a fis8 g a4 g |
  % 7
  fis s1. fis4 |
  % 9
  b b a8 b cis4 |
  % 10
  d8 cis b4 a s1. d4 cis b |
  % 13
  a b8 a g fis e4 |
  % 14
  d2 
}

trackB = <<
  \context Voice = channelA \trackBchannelA
>>


trackCchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 2
  
}

trackCchannelB = \relative c {
  s2. a''4 |
  % 2
  a8 gis fis4 e fis8 e |
  % 3
  d4 e fis s1. fis8 g a g fis4 |
  % 6
  e d d e |
  % 7
  d s1. d8 e |
  % 9
  fis4 e e8 gis a4 |
  % 10
  a4. gis8 e4 s1. fis8 e e fis4 e8 |
  % 13
  cis d b cis d4. cis8 |
  % 14
  a2 
}

trackC = <<
  \context Voice = channelA \trackCchannelA
  \context Voice = channelB \trackCchannelB
>>


trackDchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 3
  
}

trackDchannelB = \relative c {
  s2. fis'4 |
  % 2
  e d cis d8 cis |
  % 3
  b a g4 a s1. a4 d d |
  % 6
  cis c8 b a4 a |
  % 7
  a s1. a4 |
  % 9
  a gis a8 d cis b |
  % 10
  a cis fis e cis4 s1. d8 b4 a8 a g |
  % 13
  a4 g8 fis d4 a'8 g |
  % 14
  fis2 
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
  a'4. gis8 a g fis4 |
  % 3
  g8 fis e4 d s1. d8 e fis4 fis8 g |
  % 6
  a4 a8 g fis e d cis |
  % 7
  d4 s1. d4 |
  % 9
  dis e8 d cis b a4 |
  % 10
  fis'8 e d e a,4 s1. b'8 e, a4 d,8 g4 fis8 g a b g a a, |
  % 14
  d2 
}

trackE = <<

  \clef bass
  
  \context Voice = channelA \trackEchannelA
  \context Voice = channelB \trackEchannelB
>>


trackFchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 5
  
}

trackFchannelB = \relative c {
  s2. d4 |
  % 2
  a'4. gis8 a g fis4 |
  % 3
  g8 fis e4 d8 d' s16 d, fis d |
  % 4
  b8 b' s16 b, d b g8 g' a a, |
  % 5
  d d, d' e fis fis, fis' g |
  % 6
  a a, a' g fis e d cis |
  % 7
  d d' s16 d, fis d b8 b' s16 b, d b |
  % 8
  g8 g' a a, d d, d' cis |
  % 9
  dis b e d cis b a gis |
  % 10
  fis e d e a a' s16 a, cis a |
  % 11
  fis8 fis' s16 fis, a fis d8 d' e e, |
  % 12
  a a'4 gis8 a4 d,8 g4 fis8 g a b g a a, |
  % 14
  d d' s16 d, fis d b8 b' s16 b, d b |
  % 15
  g8 g' a a, b4 s8 b' |
  % 16
  a g a a, d,2 |
  % 17
  
}

trackF = <<

  \clef bass
  
  \context Voice = channelA \trackFchannelA
  \context Voice = channelB \trackFchannelB
>>


trackGchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 6
  
}

trackGchannelB = \relative c {
  s8*21 <d'' fis >16 <e g >16 <d fis >8 <d fis >8 |
  % 4
  s8 <d fis >16 <e g >16 <d fis >8 <d fis >8 s8 <g b >8 <fis a >8 
  <e g >8 |
  % 5
  <d fis >16 <fis a >16 <g b >16 <e cis' >16 <fis d' >8 s4*7 <fis, d' >16 
  <a e' >16 <fis d' >8 <fis d' >8 s8 <fis d' >16 <a e' >16 <fis d' >8 
  <fis d' >8 |
  % 8
  s8 <e' g >8 <d fis >8 <a e' >8 <fis d' >16 <d a' >16 <fis d' >16 
  <a e' >16 <d fis >8 s4*7 <a' cis >16 <b d >16 <a cis >8 <a cis >8 |
  % 11
  s8 <a cis >16 <b d >16 <a cis >8 <a cis >8 s8 <b d >8 <a cis >8 
  <gis b >8 |
  % 12
  <a cis >16 <g b >16 <fis a >16 <e g >16 <d fis >8 s4*7 <d fis >16 
  <e g >16 <d fis >8 <d fis >8 s8 <d fis >16 <e g >16 <d fis >8 
  <d fis >8 |
  % 15
  s8 <g b >8 <fis a >8 <e g >8 <d fis >16 <fis a >16 <g b >16 
  <e cis' >16 <fis d' >8 <d g >8 |
  % 16
  <d fis >4 <a fis' >16 fis a8 <fis d' >2 |
  % 17
  
}

trackG = <<
  \context Voice = channelA \trackGchannelA
  \context Voice = channelB \trackGchannelB
>>


trackHchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 7
  
}

trackHchannelB = \relative c {
  s2*5 a''4 s8 a16 fis |
  % 4
  d8 fis s8 fis16 a d8 d d a |
  % 5
  a4 s4*7 a4 s8 a16 fis d8 fis s8 fis16 a |
  % 8
  d8 d16 e fis g a8 a,4 s4*7 a4 s8 a16 e' |
  % 11
  fis8 a, s8 fis16 a fis'8 fis e e |
  % 12
  e s8*15 a,4 s8 a16 fis d8 fis s8 fis16 a |
  % 15
  d8 d d a d,4 s8 d16 d |
  % 16
  d8 fis16 d a'8 a a2 |
  % 17
  
}

trackH = <<
  \context Voice = channelA \trackHchannelA
  \context Voice = channelB \trackHchannelB
>>


trackIchannelA =  {
  
  % [SEQUENCE_TRACK_NAME] Instrument 8
  
}

trackIchannelB = \relative c {
  s2*5 d4 s8 d16 d |
  % 4
  d4 s8 d16 d d8 d a a |
  % 5
  d4 s4*7 d4 s8 d16 d d4 s8 d16 d |
  % 8
  d8 d a a d4 s4*7 a4 s8 a16 a |
  % 11
  a4 s8 a16 a d8 s4. |
  % 12
  a4 s4*7 d4 s8 d16 d d4 s8 d16 d |
  % 15
  d8 d a a d4 s8 d |
  % 16
  a4 a16 a a a d2 |
  % 17
  
}

trackI = <<

  \clef bass
  
  \context Voice = channelA \trackIchannelA
  \context Voice = channelB \trackIchannelB
>>


\score {
  <<
    \context Staff=trackB \trackB
    \context Staff=trackC \trackC
    \context Staff=trackD \trackD
    \context Staff=trackE \trackE
    \context Staff=trackF \trackF
    \context Staff=trackG \trackG
    \context Staff=trackH \trackH
    \context Staff=trackI \trackI
  >>
}
