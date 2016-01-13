;;; emacs-rc-autocomplete.el ---

;; Copyright (C) Igor Bel
;;
;; Author: Igor Bel <igorb@gmail.com>


(add-to-list 'load-path "~/.emacs.d/ac-dict")
(add-to-list 'ac-dictionary-directories "~/emacs/ac-dict")
(require 'auto-complete-config)
(ac-config-default)

;(require 'auto-complete-config)
;(ac-config-default)
;(setq ac-auto-start nil)
(define-key ac-mode-map [(meta return)] 'auto-complete)


