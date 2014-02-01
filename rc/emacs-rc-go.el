;;; emacs-rc-go.el --- 

;; Copyright (C) Igor Bel
;;
;; Author: Igor Bel <igorb@gmail.com>
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(when (file-exists-p "~/exp/go/src/github.com/nsf/gocode/emacs/")
  (load "~/exp/go/src/github.com/nsf/gocode/emacs/go-autocomplete.el"))

(defun igorb/go-mode-hook ()
  (setq tab-width 4)
  (setq indent-tabs-mode t)
  ;; minor modes
  (auto-fill-mode 0)  
  ;; local keys
  (local-set-key [return] 'newline-and-indent)

  ;; autocomplete
  (set (make-local-variable 'ac-auto-start) 3)
  (set (make-local-variable 'ac-auto-show-menu) 0.5)
  
  )
(add-hook 'go-mode-hook 'igorb/go-mode-hook)


;;; emacs-rc-go.el ends here
