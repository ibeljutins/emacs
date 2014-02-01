;;; emacs-rc-lisp.el ---

;; Copyright (C) 2014 Igor Bel
;;
;; Author: igorb@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(defun igorb/lisp-mode-hook ()
  (setq indent-tabs-mode t)
  (abbrev-mode 1)
  (auto-fill-mode 1)
  (turn-on-eldoc-mode)
  (paredit-mode 1)
  (local-set-key [return] 'newline-and-indent)
  )
(add-hook 'lisp-mode-hook 'igorb/lisp-mode-hook)

(defun igorb/lisp-interact-mode-hook ()
  (paredit-mode 1)
  )
(add-hook 'lisp-interaction-mode-hook 'igorb/lisp-interact-mode-hook)


;;; emacs-rc-slime.el ends here
