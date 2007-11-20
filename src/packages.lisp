(in-package #:cl-user)


(defpackage #:rameau
  (:export #:acerta-times #:*main-dir* #:get-modo
           #:cifra->acorde #:acorde->cifra #:read-pop-file #:7+ #:extract-cifra
           #:expande-cifra-setima #:expand-mel #:gera-gabarito-file
           #:algoritmo-pardo #:code->interval 
           #:code->note #:compara-gabarito-pardo
           #:cria-nota #:cria-skip #:desempata-pardo #:dim7?
           #:dim7-res #:do-nothing #:do-the-parsing #:empty-octave
           #:gera-gabarito-pardo #:%get-accidental
           #:get-accidentals #:get-exp #:get-flat #:get-interval-name
           #:get-interval-quantity #:get-sharp #:get-system-intervals
           #:get-system-item #:get-system-module #:get-system-notes
           #:group-and-count #:interval #:interval->code #:inversion 
           #:match-note-representation #:max-predicado
           #:module #:normal-form #:normaliza-notas
           #:note? #:note->code #:number-of-accidentals
           #:pardo  #:prime-form #:print-accidentals
           #:print-interval #:print-note #:processa-gabarito
           #:rest? #:rotate #:parse-file #:compara-notas #:lista-notas
           #:segmentos-minimos #:set-equal? #:calcula-duracoes
           #:set-form-list #:set-intervals #:set-inversion #:set-rotate
           #:set-symmetric? #:set-transpose #:set-transpose-to-0 #:smaller-sets
           #:smaller-sets-comparisson #:smallest-set #:sort-form-list
           #:sort-set #:string->symbol #:symbol->number #:template-prob
           #:transpoe #:transpose #:with-system #:make-evento
           #:pop2cifra #:print-repeat #:tempered #:tonal
           #:temperley #:pardo->gabarito)
  (:use #:rameau-base #:rameau-utils #:rameau-musiclib #:cl #:it.bese.arnesi #:lisp-unit)
  (:import-from #:it.bese.arnesi #:aif #:it))

(in-package :rameau)
(mapcar #'export rameau-base::*utils-funcs*)
(mapcar #'export rameau-base::*musiclib-funcs*)