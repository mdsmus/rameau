;; Formato interno:
;; O formato interno � uma lista de eventos. Cada evento � uma nota
;; que soa, e soa em uma altura (pitch), por um certo tempo (dur) a
;; partir de um certo instante na m�sica (inicio). Isso � representado
;; na struct evento.

;; Antes disso, no entanto, as notas s�o processadas pra se extrair a
;; dura��o e a altura. Isso � feito usando a struct nota, que
;; desaparece depois do primeiro passo de processamento, quando as
;; notas s�o transformadas em eventos.

;; As fun��es desse arquivo s� fazem essa convers�o, de notas pra
;; eventos, e representam esses eventos, e os manipulam de forma
;; b�sica.

(defparameter *notes-names* '(#\a #\b #\c #\d #\e #\f #\g))
(defparameter *tonal* '(69 83 0 14 28 41 55))
(defparameter *tempered* '(9 11 0 2 4 5 7))

(defparameter *quarta-tonal* 41)

(defstruct evento
  (pitch)
  (octave)
  (dur)
  (inicio))

(defun number-of-accidentals (note)
  "Usa um hack para contar quantos acidentes tem contando quantos
i tem nos isis e quantos e tem nos eses."
  (let ((accidental (subseq note 1)))
    (cond ((search "is" note) (count #\i accidental))
          ((search "es" note) (- (count #\e accidental)))
          (t 0))))

(defun note-number (note codification)
  (nth (position note *notes-names*) codification))

(defun note-from-string (nota &optional (codification *tonal*))
  (mod (+ (number-of-accidentals nota)
          (note-number (char nota 0) codification))
       96))

(defun octave-from-string (string)
  (+ 8 (cond ((search "'" string) (count #\' string))
             ((search "," string) (- (count #\, string)))
             (t 0))))

;; Esse 42 est� horr�vel a�, preciso tirar.
(defun cria-nota (nota &optional (octave "") dur articulation) 
  (declare (ignore articulation))
  (make-evento :pitch (note-from-string nota)
             :octave (octave-from-string octave)
             :dur (when dur (parse-integer dur))
             :inicio 0))

(defun cria-nota-com-duracao (nota dur)
  (cria-nota nota  "" dur nil))

(defun cria-nota-com-duracao-articulacao (nota dur artic)
  (declare (ignore artic))
  (cria-nota nota  "" dur nil))

(defun cria-nota-com-articulacao (nota artic)
  (declare (ignore artic))
  (cria-nota nota))

(defun emite-evento (nota duracao inicio oitava)
  (make-evento :pitch nota
               :dur (if (numberp duracao)
                        duracao
                        (/ 1 (parse-integer duracao)))
               :inicio inicio
               :octave oitava))

(defun move-evento-no-tempo (evento tempo)
  (make-evento :pitch (evento-pitch evento)
               :dur (evento-dur evento)
               :inicio (+ (evento-inicio evento) tempo)
               :octave (evento-octave evento)))


(defun movimenta-sequencia (seq tempo)
  (mapcar (lambda (x) (move-evento-no-tempo x tempo))
          seq))

(defun fim-evento (evento)
  (+ (evento-inicio evento) (evento-dur evento)))

(defun fim-da-execucao (seq)
  (let ((l (first (last seq))))
    (fim-evento l)))

(defun coloca-expressoes-em-sequencia (sequencias)
  "Leva uma lista de express�es musicais e as arruma em sequ�ncia"
  (when sequencias
    (let* ((primeiro (car sequencias))
           (outros (cdr sequencias))
           (fim-primeiro (reduce #'max (mapcar #'fim-evento primeiro)))
           (inicio-primeiro (evento-inicio (car primeiro)))
           (movimentador (- fim-primeiro inicio-primeiro)))
      (append primeiro
              (coloca-expressoes-em-sequencia
               (mapcar (lambda (x) (movimenta-sequencia x movimentador))
                       outros))))))
(defun sequencia-eventos (eventos)
  (when eventos
    (cons (first eventos)
          (sequencia-eventos
           (movimenta-sequencia (rest eventos) (evento-dur (first eventos)))))))


(defun menos-mod-96 (a b)
  (mod (- a b) 96))

(defun menos-de-uma-quarta (a b)
  (let ((a (evento-pitch a))
        (b (evento-pitch b)))
    (< (menos-mod-96 b a)
       41)))

(defun modificador-oitava (a b)
  (let ((pa (evento-pitch a))
        (pb (evento-pitch b))
        (oa (evento-octave a))
        (ob (evento-octave b)))
    (+ (- ob 8)
       (if (< pa pb)
           (if (menos-de-uma-quarta a b)
               oa
               (- oa 1))
           (if (menos-de-uma-quarta b a)
               oa
               (+ oa 1))))))


(defun relativiza (nota expressao &optional seq oitava)
  (if (not expressao)
      (nreverse seq)
      (let* ((prox-nota (first expressao))
             (oitava (if oitava oitava
                         (evento-octave nota)))
             (expressao (rest expressao))
             (evento-novo
              (emite-evento
               (evento-pitch prox-nota)
               (evento-dur prox-nota)
               (evento-inicio prox-nota)
               (modificador-oitava nota prox-nota)))
             (seq 
              (cons evento-novo seq)))
        (relativiza evento-novo expressao seq oitava))))

