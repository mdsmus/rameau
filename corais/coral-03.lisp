(event 'coral-3
       :key '(a menor)
       :time 4/4
       (event 'periodo-1
              (event 'frase-1
                     :partial 4
                     (event 'soprano
                            :relative c'
                            :notes "a4 a b c d e2")

                     (event 'contralto
                            :relative c'
                            :notes "e4 e e e a g#2")

                     (event 'tenor
                            :relative c
                            :notes "c4 c b a a b2")

                     (event 'baixo
                            :relative c,
                            :notes "a4 a' g# a8 g f4 e2")))

       (event 'periodo-2
              (event 'frase-1
                     :partial 4
                     (event 'soprano
                            :relative c'
                            :notes "r4 e e d c d b2")

                     (event 'contralto
                            :relative c'
                            :notes "r4 g4 g8 a b4 b8 a g# a g#2")

                     (event 'tenor
                            :relative c
                            :notes "r4 c4 c b8 e e4 f e2")

                     (event 'baixo
                            :relative c,
                            :notes "r4 c8 d e f# g#4 a d, e2")))

       (event 'periodo-3
              (event 'frase-1
                     :partial 4
                     (event 'soprano
                            :relative c'
                            :notes "r4 b4 c d e e d2 e4")

                     (event 'contralto
                            :relative c'
                            :notes "r4 g4 a g g a a g g")

                     (event 'tenor
                            :relative c
                            :notes "r4 e4 e d c c c b c")

                     (event 'baixo
                            :relative c,
                            :notes "r4 e4 a b c8 b a g f4 g c,"))

              (event 'frase-2
                     :partial 4
                     (event 'soprano
                            :relative c'
                            :notes "e4 c d e d8 e16 f e4 d8 c c4")

                     (event 'contralto
                            :relative c'
                            :notes "g#4 a a g f g f8 e e4")

                     (event 'tenor
                            :relative c
                            :notes "b4 a8 b c4 c8 b c4 c b g")

                     (event 'baixo
                            :relative c,
                            :notes "e4 f f# g ab g8 f g4 c,"))

              (event 'frase-3
                     :partial 4
                     (event 'soprano
                            :relative c'
                            :notes "e4 g e e e d2 d4")
                     
                     (event 'contralto
                            :relative c'
                            :notes "g4 g g8 a b4 a4 a8 g a f# g4")

                     (event 'tenor
                            :relative c
                            :notes "c4 d e e8 d c b a16 b c4 b16 a b4")

                     (event 'baixo
                            :relative c,
                            :notes "c4' b c g# a8 g f# e f d g4"))

              (event 'frase-4
                     :partial 4
                     (event 'soprano
                            :relative c'
                            :notes "d4 e d c d b2 a4")
                     
                     (event 'contralto
                            :relative c'
                            :notes "g8 f e4 f#8 g# a4 a a g# e")

                     (event 'tenor
                            :relative c
                            :notes "b4 c b a8 c f4 e. d8 c#4")

                     (event 'baixo
                            :relative c,
                            :notes "g4' c, d8 e f4 e8 d e2 a4,"))))