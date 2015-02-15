;;; emacs-rc-javascript.el ---

;; Copyright (C) Igor Bel
;;
;; Author: Igor Bel <igorb@gmail.com>
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(load-library "js3-mode")
(autoload 'js3-mode "js3-mode" nil t)
(setq js3-use-font-lock-faces t)
(setq js3-indent-on-enter-key t)
(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))
(add-to-list 'auto-mode-alist '("\\.qbs$" . js3-mode))

(setq js3-basic-offset 2)
(setq js3-use-font-lock-faces t)

(defun igorb/js3-mode-hook ()
  (local-set-key [return] 'newline-and-indent)
  (set (make-local-variable 'ac-auto-start) 3)
  (set (make-local-variable 'ac-auto-show-menu) t)
  )
(add-hook 'js3-mode-hook 'igorb/js3-mode-hook)

;;; emacs-rc-javascript.el ends here
