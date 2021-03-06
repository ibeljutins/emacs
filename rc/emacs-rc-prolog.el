;;; emacs-rc-prolog.el ---

;; Copyright (C) Igor Bel
;;
;; Author: Igor Bel <igorb@gmail.com>
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
(autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)
(setq prolog-system 'swi)

(add-to-list 'auto-mode-alist '("\\.plg$" . prolog-mode))

;;  (turn-on-eldoc-mode)

;;; emacs-rc-prolog.el ends here
