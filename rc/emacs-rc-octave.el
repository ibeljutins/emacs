;;; emacs-rc-octave.el --- 

;; Copyright (C) Igor Bel
;;
;; Author: Igor Bel <igorb@gmail.com>
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))

(defun igorb/octave-mode-hook ()
  )
(add-hook 'octave-mode-hook 'igorb/octave-mode-hook)

;;; emacs-rc-octave.el ends here
