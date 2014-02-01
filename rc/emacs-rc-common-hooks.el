;;; emacs-rc-common-hooks.el ---

;; Copyright (C) Igor Bel
;;
;; Author: Igor Bel <igorb@gmail.com>
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;; common settings for different text & programming modes
(defun igorb/common-hook ()
  (local-set-key "\C-c:" 'uncomment-region)
  (local-set-key "\C-c;" 'comment-region)
  (local-set-key "\C-c\C-c" 'comment-region)
  (font-lock-mode 1)
  )
(add-hook 'prog-mode-hook 'igorb/common-hook)

;; show FIXME/TODO/BUG keywords
(defun igorb/show-prog-keywords ()
  ;; highlight additional keywords
  (font-lock-add-keywords nil '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))
  (font-lock-add-keywords nil '(("\\<\\(DONE\\):" 1 font-lock-doc-face t)))
  ;; highlight too long lines
  ;;(font-lock-add-keywords nil '(("^[^\n]\\{120\\}\\(.*\\)$" 1 font-lock-warning-face t)))
  )

(defun igorb/common-prog-hook ()
  (subword-mode 1)
  (igorb/show-prog-keywords)
  )
(add-hook 'prog-mode-hook 'igorb/common-prog-hook)

;; clean trailing whitespaces automatically
(setq igorb/trailing-whitespace-modes '(haskell-mode lisp-mode scheme-mode erlang-mode))

(defun igorb/trailing-whitespace-hook ()
  (when (member major-mode igorb/trailing-whitespace-modes)
    (delete-trailing-whitespace)))
(add-hook 'before-save-hook 'igorb/trailing-whitespace-hook)

;; untabify some modes
;; (setq igorb/untabify-modes '(haskell-mode lisp-mode scheme-mode erlang-mode clojure-mode))
;; (defun igorb/untabify-hook ()
;;   (when (member major-mode igorb/untabify-modes)
;;     (untabify (point-min) (point-max))))
;; (add-hook 'before-save-hook 'igorb/untabify-hook)



;;; emacs-rc-common-hooks.el ends here
