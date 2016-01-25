
;;; emacs-rc-clojure.el ---

;; Copyright (C) Igor Bel
;;
;; Author: Igor Bel <igorb@gmail.com>
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(defun igorb/clojure-mode-hook ()
  "Hook for Clojure mode"
  (turn-on-eldoc-mode)
  (whitespace-mode 1)
  (paredit-mode 1)
  (rainbow-delimiters-mode 1)
  (local-set-key [return] 'newline-and-indent)
  (local-set-key "\C-c\C-c" 'nrepl-eval-expression-at-point)
  ;; clojure-test-mode
  (clojure-test-maybe-enable)
  )
(add-hook 'clojure-mode-hook 'igorb/clojure-mode-hook)

;; NRepl
(defun igorb/nrepl-mode-hook ()
  (nrepl-turn-on-eldoc-mode)
  (paredit-mode 1)
  (rainbow-delimiters-mode 1)
  (local-set-key [return] 'nrepl-return)
  (local-set-key "\C-c\C-c" 'nrepl-interrupt)
  )
(add-hook 'nrepl-mode-hook 'igorb/nrepl-mode-hook)

(add-to-list 'same-window-buffer-names "*nrepl*")

