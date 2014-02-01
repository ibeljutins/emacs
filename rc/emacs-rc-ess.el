;;; emacs-rc-ess.el ---

;; Copyright (C) Igor Bel
;;
;; Author: Igor Bel <igorb@gmail.com>
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;; R doc
(add-to-list 'auto-mode-alist '("\\.r\\'" . ess-mode))

(defun igorb/ess-mode-hook ()
  (local-set-key [(control return)] 'ess-eval-line-and-step)
  (font-lock-mode 1)
  )
(add-hook 'ess-mode-hook 'igorb/ess-mode-hook)

;; Rd-mode...
(add-to-list 'auto-mode-alist '("\\.rd\\'" . Rd-mode))
(defun igorb/rd-mode-hook ()
  (abbrev-mode 1)
  (font-lock-mode 1)
  )
(add-hook 'Rd-mode-hook 'igorb/rd-mode-hook)

;;; emacs-rc-ess.el ends here
