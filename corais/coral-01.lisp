(event 'coral-1
       :key '(e menor)
       :time 4/4
       (event 'periodo-1
              (event 'frase-1
                     :partial 4
                     (event 'soprano
                            :relative c'
                            :notes "b4 c b a e' e8 d c4 b")

                     (event 'contralto
                            :relative c'
                            :notes "gis4 a gis a gis8 a b4 e8, fis gis4")

                     (event 'tenor
                            :relative c
                            :notes "e4 e d e d8 c b4 c8 d e4")

                     (event 'baixo
                            :relative c,
                            :notes "e4 a b c b8 a gis4 a e"))

              (event 'frase-2
                     :partial 4
                     (event 'soprano
                            :relative c'
                            :notes "d4 c b a b8 c16 d c4 b a")

                     (event 'contralto
                            :relative c'
                            :notes "gis4 a gis a8 g f4 e2 e4")

                     (event 'tenor
                            :relative c
                            :notes "f4 e e8 d c4 d gis8, a4 gis8 c4")

                     (event 'baixo
                            :relative c,
                            :notes "b4 c8 d e4 f e8 d e2 a4,")))

       (event 'periodo-2
              (event 'frase-1
                     :partial 4
                     (event 'soprano
                            :relative c'
                            :notes "a4 b8 a g4 fis e8 fis g4 a b")

                     (event 'contralto
                            :relative c'
                            :notes "d4 d8 dis e4 dis e8 dis e g fis e dis4")

                     (event 'tenor
                            :relative c
                            :notes "a4 g8 a b4 b b8 a b4 c fis,")

                     (event 'baixo
                            :relative c,
                            :notes "fis4 g8 fis e4 b8' a g fis e d c4 b"))

              (event 'frase-2
                     :partial 4
                     (event 'soprano
                            :relative c'
                            :notes "g4 a8 b c4 b c8 b a4 gis a")

                     (event 'contralto
                            :relative c'
                            :notes "b4 a a' gis a e e e")

                     (event 'tenor
                            :relative c
                            :notes "e8 d c d e4 e e8 d c4 b c")

                     (event 'baixo
                            :relative c,
                            :notes "e4 f c8 d e4 a8, b c d e4 a,"))

              (event 'frase-3
                     :partial 4
                     (event 'soprano
                            :relative c'
                            :notes "a4 e' c d e d c b")

                     (event 'contralto
                            :relative c'
                            :notes "e4 e e f g fis8 gis a4 e")

                     (event 'tenor
                            :relative c
                            :notes "c4 b a a bb a8 e fis4 gis")

                     (event 'baixo
                            :relative c,
                            :notes "a4' gis a8 g f e d cis d4 dis e"))))

(chord
 (frase1 c7 am)
 (frase2 c7 am))
         