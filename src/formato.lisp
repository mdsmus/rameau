;; Formato interno:
;; O formato interno é uma lista de eventos. Cada evento é uma nota
;; que soa, e soa em uma altura (pitch), por um certo tempo (dur) a
;; partir de um certo instante na música (inicio). Isso é representado
;; na struct evento.

;; Antes disso, no entanto, as notas são processadas pra se extrair a
;; duração e a altura. Isso é feito usando a struct nota, que
;; desaparece depois do primeiro passo de processamento, quando as
;; notas são transformadas em eventos.

;; As funções desse arquivo só fazem essa conversão, de notas pra
;; eventos, e representam esses eventos, e os manipulam de forma
;; básica.

(defparameter *notes-names* '(#\a #\b #\c #\d #\e #\f #\g))
(defparameter *tonal* '(69 83 0 14 28 41 55))
(defparameter *tempered* '(9 11 0 2 4 5 7))
 
(defun number-of-accidentals (note)
  "Usa um hack para contar quantos acidentes tem contando quantos
i tem nos isis e quantos e tem nos eses."
  (let ((accidental (subseq note 1)))
    (cond ((search "is" note) (count #\i accidental))
          ((search "es" note) (- (count #\e accidental)))
          (t 0))))

(defun note-number (note codification)
  (nth (position note *notes-names*) codification))

;; (pitch-from-note nota) - converte "c" em 0, por exemplo
;; A priori usar a codificação de Jamary
(defun note-from-string (nota &optional (codification *tonal*))
  (mod (+ (number-of-accidentals nota)
          (note-number (char nota 0) codification))
       96))

(defun octave-from-string (string)
  (cond ((search "'" string) (count #\' string))
        ((search "," string) (count #\, string))
        (t 0)))

(defstruct nota
  (pitch)
  (octave)
  (dur))

;; Esse 42 está horrível aí, preciso tirar.
(defun cria-nota (nota &optional (octave "") (dur "42") articulation) 
  (declare (ignore articulation))
  (make-nota :pitch (note-from-string nota)
             :octave (octave-from-string octave)
             :dur (/ 1 (parse-integer dur))))

(defun cria-nota-dur (nota dur)
  (cria-nota nota  "" dur nil))

(defun cria-nota-dur-artic (nota dur artic)
  (declare (ignore artic))
  (cria-nota nota  "" dur nil))

(defun cria-nota-artic (nota artic)
  (cria-nota nota))

(defun pitch (nota)
  (nota-pitch nota))

(defun dur (nota)
  (nota-dur nota))

(defstruct evento
  (pitch)
  (octave)
  (dur)
  (inicio))

(defun inicio (evento)
  (evento-inicio evento))

(defun emite-evento (nota duracao inicio oitava)
  (make-evento :pitch nota :dur duracao :inicio inicio :octave oitava))

(defun move-evento-no-tempo (evento tempo)
  (make-evento :pitch (evento-pitch evento)
               :dur (evento-dur evento)
               :inicio (+ (evento-inicio evento) tempo)))

(defun emite-sequencia (notas)
  (let ((seq nil)
        (inicio 0)
        (dur 1/4))
    (dolist (n notas)
      (if (not (= 1/42 (dur n)))
          (setf dur (dur n)))
      (setf seq (cons (emite-evento (pitch n)
                                    dur
                                    inicio
                                    (nota-octave n))
                      seq))
      (setf inicio (+ inicio dur)))
    (nreverse seq)))

;; (emite-sequencia (list (cria-nota "d")
;;                        (cria-nota "e" "'''" "2")
;;                        (cria-nota "f")))

(defun emite-acorde (&rest notas)
  (mapcar (lambda (n)
            (emite-evento (pitch n) (/ 1 (dur n)) 0 (nota-octave n)))
          notas))

(defun movimenta-sequencia (seq tempo)
  (mapcar (lambda (x)
            (move-evento-no-tempo x tempo))
          seq))

(defun fim-da-execucao (seq)
  (let ((l (first (last seq))))
    (+ (evento-inicio l) (evento-dur l))))

(defun concatena-sequencias (a b)
  (nconc a (movimenta-sequencia b (fim-da-execucao a))))
