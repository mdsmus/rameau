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
    \time 4/4
    \skip 1*9  %% 1-9
}
globalTempo = {
    \override Score.MetronomeMark #'transparent = ##t
    \tempo 4 = 45  \skip 1*9 
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

                \time 4/4
                \clef "tenor"
                \key e \major
                \times 2/3 { < gis cis, cis > 8 -\tenuto cis' e' } \times 2/3 { gis cis' e' } \times 2/3 { gis cis' e' } \times 2/3 { gis cis' e' }  |
                \times 2/3 { < gis b,, b, > 8 -\tenuto cis' e' } \times 2/3 { gis cis' e' } \times 2/3 { gis cis' e' } \times 2/3 { gis cis' e' }  |
                \times 2/3 { < a a,, a, > 8 -\tenuto cis' e' } \times 2/3 { a cis' e' } \times 2/3 { < a fis,, fis, > -\tenuto d' fis' } \times 2/3 { a d' fis' }  |
                \times 2/3 { < gis gis,, gis, > 8 -\tenuto c' fis' } \times 2/3 { gis cis' e' } \times 2/3 { < gis gis,, gis, > -\tenuto cis' dis' } \times 2/3 { fis c' dis' }  |
%% 5
                \times 2/3 { < e cis, gis, cis > 8 -\tenuto gis cis' } \times 2/3 { gis cis' e' } \times 2/3 { gis cis' e' } < gis' gis > 16 -\tenuto r32 cis' 16 -\tenuto e' 32 -\tenuto gis' 16  |
                \times 2/3 { < gis' gis c, gis, c > 8 -\tenuto dis' fis' } \times 2/3 { gis dis' fis' } \times 2/3 { gis dis' fis' } < gis' gis > 16 -\tenuto r32 dis' 16 -\tenuto fis' 32 -\tenuto gis' 16  |
                \times 2/3 { < gis' gis cis, cis > 8 -\tenuto cis' e' } \times 2/3 { gis cis' e' } \times 2/3 { < a' a fis,, fis, > -\tenuto cis' fis' } \times 2/3 { a cis' fis' }  |
                \times 2/3 { < gis' gis b,, b, > 8 -\tenuto b e' } \times 2/3 { gis b e' } \times 2/3 { < fis' a b,, b, > -\tenuto b dis' } \times 2/3 { < b' a > -\tenuto b dis' }  |
                \times 2/3 { < e' gis e, e > 8 -\tenuto b e' } \times 2/3 { gis b e' } \times 2/3 { gis b e' } \times 2/3 { gis b e' }  |
                \bar "|."
            } % Voice
        >> % Staff (final)
    >> % notes

    \layout { }
} % score