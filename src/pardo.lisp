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
  


(defun segmentos-minimos (musica)
  "Extrai os segmentos mínimos de uma música já no formato interno"
  (when musica
    (let* ((primeiro (first musica))
           (inicio (evento-inicio primeiro))
           (resto (cdr musica)))
      (multiple-value-bind (grupo restante) (agrupa-por inicio resto)
        
        (cons (cons primeiro grupo)
              (segmentos-minimos restante))))))


