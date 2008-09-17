
cima = {
	\clef treble
	\time 2/2
	\key des \major
	\relative c'' {
			des8 c bes 
			\once \override TextScript #'extra-offset = #'( -1.2 . -4.6 )
			a^\markup{ \fontsize #10 { \circle { " " } } }
			bes4 f
			\once \override TextScript #'extra-offset = #'( -0.5 . -5.6 )
			ges4^\markup{ \fontsize #8 { \circle { " " } } }^(
			ees c f )
		<< 
		\relative c''' {
			r2  bes8
			\once \override TextScript #'extra-offset = #'( -0.2 . -4.6 )
			aes^\markup{ \fontsize #8 { \circle { " " } } }
			\once \override TextScript #'extra-offset = #'( -0.2 . -4.6 )
			ges^\markup{ \fontsize #8 { \circle { " " } } }
			f
			ges f ees des c f ees f
			des4 f, r8 des'8
			}
		\\
		\relative c' {
			des4 bes bes' bes
			bes4
			\once \override TextScript #'extra-offset = #'( -1.2 . -4.6 )
			a8^\markup{ \fontsize #10 { \circle { " " } } }
			bes c4 c
			c4 bes8
			\once \override TextScript #'extra-offset = #'( -1.0 . -4.6 )
			a8^\markup{ \fontsize #10 { \circle { " " } } }
			bes2 ~ \bar " "
			} 
		>>
		}
	}


baixo = {
        \clef bass
	\key des \major
	\relative c {
			bes2 bes'2 ~ bes
			\once \override TextScript #'extra-offset = #'( -1.0 . -2.6 )
			a2^\markup{ \fontsize #10 { \circle { " " } } }
			bes8
			\once \override TextScript #'extra-offset = #'( -1.0 . -2.2 )
			aes!^\markup{ \fontsize #10 { \circle { " " } } }
			\once \override TextScript #'extra-offset = #'( -0.2 . -2.2 )
			ges^\markup{ \fontsize #8 { \circle { " " } } }
			f 
			\once \override TextScript #'extra-offset = #'( -0.2 . -2.2 )
			ges^\markup{ \fontsize #8 { \circle { " " } } }
			f ees des
			ees des c bes 
			\once \override TextScript #'extra-offset = #'( -1.0 . -5.6 )
			a^\markup{ \fontsize #10 { \circle { " " } } }(
			f
			\once \override TextScript #'extra-offset = #'( -0.9 . -5.9 )
			g^\markup{ \fontsize #9 { \circle { " " } } }
			\once \override TextScript #'extra-offset = #'( -0.2 . -5.2 )
			a^\markup{ \fontsize #7 { \circle { " " } } }
			bes ) c d ees des4  \bar " "
		}
	}


\score {
	\context PianoStaff = "piano" <<
		\new Staff = "cima" { \cima }
		\new Staff = "baixo" { \baixo }
		>>
	\layout {
		ragged-right = ##t 
		\context {
			\Staff
			\consists Horizontal_bracket_engraver
		}
	}
}

