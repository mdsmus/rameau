(event 'coral-4
       :key '(c major)
       :time 4/4
       (event 'periodo1
              (event 'frase1
                     :partial 4
                     (event 'soprano
                            :relative 5
                            :notes "c c a8 b c d e4 d8 e16 f d4 c4")
                     (event 'contralto
                            :relative 4
                            :notes "e8 f g4 f g g a g8 f e4")
                     (event 'tenor
                            :relative 4
                            :notes "c c c c c c b g")
                     (event 'baixo
                            :relative 3
                            :notes "a e f e8 d c4 f g c,"))
              (event 'frase2
                     :partial 4
                     (event 'soprano
                            :relative 4
                            :notes "c c b a8 b c4 d8 c b2 a4")
                     (event 'contralto
                            :relative 4
                            :notes "fis g f e a a gis e")
                     (event 'tenor
                            :relative 4
                            :notes "a d  d c8 b a4 f' e8 d cis4")
                     (event 'baixo
                            :relative 4
                            :notes "a g d a8 g f e d4 e a,")))
       (event 'periodo2
              (event 'frase1
                     :partial 4
                     (event 'soprano
                            :relative 5
                            :notes "d e e b8 c d4 c c b")
                     (event 'contralto
                            :relative 4
                            :notes "g g g d8 e f4 e a gis")
                     (event 'tenor
                            :relative 4
                            :notes "b c g8 a b4 a8 b c d e4 e")
                     (event 'baixo
                            :relative 3
                            :notes "g c8 d e f g4 f a,8 b c d e4"))
              (event 'frase2
                     :partial 4
                     (event 'soprano
                            :relative 4
                            :notes "c d a8 b c4 b a16 b c8 a4 g")
                     (event 'contralto
                            :relative 4
                            :notes "a a8 g fis4 e d8 g g e fis4 d")
                     (event 'tenor
                            :relative 4
                            :notes "e a, d g,8 a b d e4 d8 c  b4")
                     (event 'baixo
                            :relative 4
                            :notes "a8 g fis e d4 e8 fis g4 c, d g,"))
              (event 'frase3
                     :partial 4
                     (event 'soprano
                            :relative 4
                            :notes "c b a8 b c4 d8 c b2 a4")
                     (event 'contralto
                            :relative 4
                            :notes "e d8 e fis f e4 a a gis e")
                     (event 'tenor
                            :relative 4
                            :notes "g8 a b c d4 c8 b a c f d b e cis4")
                     (event 'baixo
                            :relative 4
                            :notes "e'8 fis g4 fis8 gis a g f e d b e4 a,"))))

(event 'coral-4
       (event 'periodo 1
              (frase 1
                     :partial 4
                     (harmony
                      (center c (vi minor)(i 1)(iv)(i 1)(i)(iv)(v8)(v8 7)(i))))
              (frase 2
                     :partial 4
                     (harmony
                      (center g (vii dim 1)(i))
                      (center c(ii minor)(vi8 minor)(vi8 minor 7 3)(ii8 minor)(vi8 minor 1)(vii dim 7 1))
                      (center a(v8)(v8 7)(i)))))
       (event 'periodo 2
              (frase 1
                     :partial 4
                     (harmony
                      (center c (v)(i)(iii minor)(v)(ii minor 2)(vi minor)(vi minor 1))
                      (center a (v))))
              (frase 2
                     :partial 4
                     (harmony
                      (center g (ii8 minor)(ii8 minor 7 3)(v 1)(v8)
                              (center c (vii8 dim 1)(i 1)(v))
                              (ii minor 7 1)(v8)(v8 7)(i))))
              (frase 3
                     :partial 4
                     (harmony
                      (center c (i8 1)
                              (center g (vii8 7)(i)(v8 1)
                                      (center a (vii8 dim))
                                      (ii8 minor)(ii8 minor 7 3))
                              (ii minor 1)(vii8 7 1)(vii8 7)
                              (center a(v)(i)))))))