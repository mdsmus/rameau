% This LilyPond file was generated by Rosegarden 1.5.1
\version "2.10.0"
% point and click debugging is disabled
#(ly:set-option 'point-and-click #f)
\header {
    copyright = "Unknown"
    subtitle = "blank"
    title = "Untitled"
    tagline = "Created using Rosegarden 1.5.1 and LilyPond"
}
#(set-global-staff-size 20)
#(set-default-paper-size "a4")
global = { 
    \time 3/4
    \skip 2.*12  %% 1-12
}
globalTempo = {
    \override Score.MetronomeMark #'transparent = ##t
    \tempo 4 = 120  \skip 2.*12 
}
\score {
    <<
        % force offset of colliding notes in chords:
        \override Score.NoteColumn #'force-hshift = #1.0

        \context Staff = "track 1" << 
            \set Staff.instrument = "untitled"
            \set Score.skipBars = ##t
            \set Staff.printKeyCancellation = ##f
            \new Voice \global
            \new Voice \globalTempo

            \context Voice = "voice 1" {
                \override Voice.TextScript #'padding = #2.0                \override MultiMeasureRest #'expand-limit = 1

                \time 3/4
                \clef "alto"
                \key e \major
                \times 2/3 { < cis'' cis''' gis'' b'' f, > 8 -\tenuto c' cis' } d' 16 -\tenuto r32 cis' 16 c' 32 ) < cis'' cis''' > 16 \times 2/3 { < cis'' cis''' cis' > 8 < cis'' cis''' gis' > < cis'' cis''' cis' > }  |
                \times 2/3 { < cis'' cis''' fis'' fis, > 8 -\tenuto c' cis' } d' 16 -\tenuto r32 cis' 16 c' 32 ) a'' 16 \times 2/3 { < fis'' cis' > 8 -\tenuto a' cis' }  |
                \times 2/3 { < cis'' cis''' f'' gis, > 8 -\tenuto c' cis' } \times 2/3 { d' < cis'' cis''' cis' > < cis'' cis''' c' > } \times 2/3 { < cis'' cis''' cis' > < cis'' cis''' b' > < cis'' cis''' cis' > }  |
                \times 2/3 { < cis'' cis''' fis'' a, > 8 -\tenuto c' cis' } d' 16 -\tenuto r32 cis' 16 c' 32 ) a'' 16 \times 2/3 { < fis'' cis' > 8 cis'' cis' ) }  |
%% 5
                \times 2/3 { < e'' g'' cis''' e''' ais,, > 8 -\tenuto cis cis, } e 16 -\tenuto r32 e, 16 g 32 ) < e'' g'' cis''' e''' > 16 \times 2/3 { < e'' g'' cis''' e''' g, > 8 -\tenuto ais ais, }  |
                \times 2/3 { < e'' gis'' e''' b, > 8 -\tenuto b gis } \times 2/3 { < e'' gis'' b'' e' > -\tenuto b gis' } \times 2/3 { < b' e'' gis'' e' > -\tenuto b gis }  |
                \times 2/3 { < a' b' dis'' fis'' b,, > 8 -\tenuto b, fis } \times 2/3 { < a' b' cis'' e'' b > -\tenuto fis dis' } \times 2/3 { < a' b' dis'' fis'' b > -\tenuto fis b, }  |
                \times 2/3 { < gis' gis'' e'' e, > 8 -\tenuto e b, } e, 16 -\tenuto r32 gis -\tenuto dis'' -\tenuto b, 16 -\tenuto r32 \times 2/3 { < d'' e, > 8 -\tenuto b b, }  |
                \key aes \major
                \times 2/3 { < aes' c'' ees'' aes'' ees, > 8 -\tenuto ees ees, } aes 16 -\tenuto r32 ees, 16 c' 32 ) < aes' c'' ees'' aes'' > 16 \times 2/3 { < aes' c'' ees'' aes'' ees, > 8 -\tenuto ees' ees, }  |
%% 10
                < c'' ees'' aes'' aes' > 16 -\tenuto r32 ees' 16 -\tenuto c'' 16. -\tenuto aes' 16 -\tenuto r32 ees' -\tenuto < aes' c'' ees'' > -\tenuto c' 16 -\tenuto r32 \times 2/3 { < ees' aes' c'' aes > 8 -\tenuto ees ees, }  |
                \times 2/3 { < c'' des' ees' g' ees'' ees,, > 8 -\tenuto ees, bes, } g 16 -\tenuto r32 ees -\tenuto bes' -\tenuto bes, 16 -\tenuto r32 < des'' des' g' ees, > 16 -\tenuto r32 ees 16 ees' 32 ) c'' 16  |
                \times 2/3 { < c' aes' aes,, > 8 -\tenuto ees aes, } \times 2/3 { ees aes, ees } \times 2/3 { aes, ees aes, }  |
                \bar "|."
            } % Voice
        >> % Staff (final)
    >> % notes

    \layout { }
} % score