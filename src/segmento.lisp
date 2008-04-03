;; Implementação da segmentação

(in-package #:rameau)

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
              (agrupa-inicio restante))))))

(defun normaliza-notas (segmento proximo)
  (let* ((sobras nil)
         (proximo-evento (if proximo (evento-inicio (first proximo))))
         (proximo-inicio (if proximo
                             (min proximo-evento
                                  (+ (smallest segmento #'evento-dur)
                                     (evento-inicio (first segmento))))
                             (+ (smallest segmento #'evento-dur)
                                     (evento-inicio (first segmento)))))
         (tamanho (- proximo-inicio (evento-inicio (first segmento)))))
    (dbg 'segmento "Prox-ini: ~a, Tam: ~a ~%" proximo-inicio tamanho)
    (values (mapcar (lambda (nota)
                      (if (= (evento-dur nota) tamanho)
                          nota
                          (progn
                            (push (make-evento
                                   :pitch (evento-pitch nota)
                                   :octave (evento-octave nota)
                                   :dur (- (evento-dur nota) tamanho)
                                   :inicio (+ tamanho (evento-inicio nota))
                                   :key (evento-key nota)
                                   :time-sig (evento-time-sig nota))
                                  sobras)
                            (make-evento
                             :pitch (evento-pitch nota)
                             :octave(evento-octave nota)
                             :dur tamanho
                             :inicio (evento-inicio nota)
                             :key (evento-key nota)
                             :time-sig (evento-time-sig nota)))))
                    segmento)
            sobras)))

(defun redivide-segmentos (musica)
  "Pega uma musica agrupada em pedaços de inicio igual e cria os
   segmentos minimos.  Para isso é preciso garantir que todos os
   pedaços tem o mesmo início e o mesmo fim. Escolhe-se o menor
   fim de cada pedaço e, caso haja alguma nota com fim posterior,
   divide-se ela e coloca-se o resto no próximo pedaço."
  (if (cdr musica)
      (multiple-value-bind
            (segmento sobras)
          (normaliza-notas (first musica) (second musica))
        (let* ((sobras-acumuladas (nconc sobras (second musica)))
               (segmentos (nconc (agrupa-inicio (sort sobras-acumuladas
                                                       (lambda (x y)
                                                         (< (evento-inicio x)
                                                            (evento-inicio y)))))
                                 (cddr musica))))
          (cons segmento (redivide-segmentos segmentos))))
      musica))

(defun segmentos-minimos (musica)
  (redivide-segmentos (agrupa-inicio musica)))

(do-not-test agrupa-por agrupa-inicio redivide-segmentos)

