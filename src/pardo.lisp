;; Implementação dos algoritmos de Pardo


(defun agrupa-por (inicio resto)
  (if resto
      (if (= inicio (evento-inicio (car resto)))
          (multiple-value-bind (segmento restante) (agrupa-por inicio (cdr resto))
            (values (cons (car resto) segmento)
                    restante))
          (values
           nil
           resto))
      (values nil nil)))
  


(defun agrupa-inicio (musica)
  "Separa a musica em pedaços com inicio igual, primeira etapa da segmentação"
  (when musica
    (let* ((primeiro (first musica))
           (inicio (evento-inicio primeiro))
           (resto (cdr musica)))
      (multiple-value-bind (grupo restante) (agrupa-por inicio resto)
        
        (cons (cons primeiro grupo)
              (segmentos-minimos restante))))))

(defun normaliza-notas (segmento)
  (let ((sobras nil)
        (tamanho (evento-dur (first segmento))))
    (values (mapcar (lambda (nota)
                      (if (= (evento-dur nota) tamanho)
                          nota
                          (progn
                            (push (make-evento
                                   :pitch (evento-pitch nota)
                                   :octave (evento-octave nota)
                                   :dur (- (evento-dur nota) tamanho)
                                   :inicio (+ tamanho (evento-inicio nota)))
                                  sobras)
                            (make-evento
                             :pitch (evento-pitch nota)
                             :octave(evento-octave nota)
                             :dur tamanho
                             :inicio (evento-inicio nota)))))
                    segmento)
            sobras)))


(let ((x (list
          (make-evento :pitch 1
                       :octave 1
                       :inicio 0
                       :dur 2)
          (make-evento :pitch 2
                       :octave 1
                       :inicio 0
                       :dur 2)
          (make-evento :pitch 3
                       :octave 1
                       :inicio 0
                       :dur 5)
          (make-evento :pitch 4
                       :octave 1
                       :inicio 0
                       :dur 4))))
  (normaliza-notas x))



(defun segmentos-minimos (musica)
  "Pega uma musica agrupada em pedaços de inicio igual e cria os
   segmentos minimos.  Para isso é preciso garantir que todos os
   pedaços tem o mesmo início e o mesmo fim. Escolhe-se o menor
   fim de cada pedaço e, caso haja alguma nota com fim posterior,
   divide-se ela e coloca-se o resto no próximo pedaço."
  (when musica
    (let ((ordenados (mapcar
                      (lambda (x) (sort x (lambda (x y)
                                            (< (evento-dur x)
                                               (evento-dur y)))))
                      musica)))
      (multiple-value-bind
            (segmento sobras)
          (normaliza-notas (first ordenados))
        (cons segmento (cons (append sobras
                                     (second ordenados))
                             (cddr ordenados)))))))
        