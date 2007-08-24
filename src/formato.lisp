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

(defparameter *notes-names* '(#\a #\b #\c #\d #\e #\f #\g #\s))
(defparameter *tonal* '(69 83 0 14 28 41 55 nil))
(defparameter *tempered* '(9 11 0 2 4 5 7 nil))

(defparameter *quarta-tonal* 41)

(defstruct evento
  (pitch)
  (octave)
  (dur)
  (inicio))

(defun symbol->number (string mapping-list)
  "Usa uma lista para mapear strings e caracteres. Essa função conta
quantas ocorrências tem do caractere na lista de mapeamento e retorna
esse valor. Essa função é usada para contar quantos acidentes ou
oitavas uma nota tem."
  (destructuring-bind ((s1 ch1) (s2 ch2)) mapping-list
    (cond ((search s1 string) (count ch1 string))
          ((search s2 string) (- (count ch2 string)))
          (t 0))))

(defun number-of-accidentals (note)
  (symbol->number note '(("is" #\i) ("es" #\e))))

(defun note-number (note codification)
  (nth (position note *notes-names*) codification))

(defun note-name (note codification)
  (nth (position note codification) *notes-names*))

(defun note-from-string (nota &optional (codification *tonal*))
  (let ((number (note-number (char nota 0) codification)))
    (if number
     (mod (+ (number-of-accidentals nota)
             number)
          96)
     nil)))

(defun octave-from-string (string)
  (+ 8 (symbol->number string '(("'" #\') ("," #\,)))))

(defun cria-nota (nota &optional (octave "") dur articulation) 
  (declare (ignore articulation))
  (make-evento :pitch (note-from-string nota)
             :octave (octave-from-string octave)
             :dur (when dur (parse-integer dur))
             :inicio 0))

(defun notap (string)
  "Testa se uma dada string pode representar uma nota"
  (let ((nome (aref string 0))
        (resto (subseq string 1)))
    (and (find nome *notes-names*)
         (case (intern resto)
           ('|| t)
           ('|is| t)
           ('|es| t)
           ('|isis| t)
           ('|eses| t)
           (t nil)))))

(defun pontua (dur)
  (let ((dur (parse-integer dur)))
    (format nil "~d" (+ dur (/ dur 2)))))
    
(defun cria-nota-com-duracao (nota dur)
  (cria-nota nota  "" dur nil))

(defun cria-nota-com-duracao-ponto (nota dur ponto)
  (cria-nota nota  "" (pontua dur) nil))

(defun cria-nota-com-oitava-duracao-ponto (nota oitava dur ponto)
  (cria-nota nota oitava (pontua dur) nil))

(defun cria-nota-com-duracao-articulacao (nota dur artic)
  (declare (ignore artic))
  (cria-nota nota  "" dur nil))

(defun cria-nota-com-duracao-articulacao-ponto (nota dur ponto artic)
  (declare (ignore artic))
  (cria-nota nota  "" (pontua dur) nil))

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
  (if (listp evento)
      (movimenta-sequencia evento tempo)
      (make-evento :pitch (evento-pitch evento)
                   :dur (evento-dur evento)
                   :inicio (+ (evento-inicio evento) tempo)
                   :octave (evento-octave evento))))

(defun movimenta-sequencia (seq tempo)
  (mapcar (lambda (x) (move-evento-no-tempo x tempo))
          seq))

(defun fim-evento (evento)
  (+ (evento-inicio evento) (evento-dur evento)))

(defun fim-da-execucao (seq)
  (let ((l (first (last seq))))
    (fim-evento l)))

(defun coloca-expressoes-em-sequencia (sequencias)
  "Leva uma lista de expressões musicais e as arruma em sequência"
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
    (remove-if
     (lambda (x) (null (evento-pitch x)))
     (if (listp (first eventos))
         (append (first eventos) (movimenta-sequencia
                                  (rest eventos)
                                  (evento-dur (first (first eventos)))))
         (cons (first eventos)
               (sequencia-eventos
                (movimenta-sequencia (rest eventos) (evento-dur (first eventos)))))))))

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

