;;; emacs-rc-python.el ---

;; Copyright (C) Igor Bel
;;
;; Author: Igor Bel <igorb@gmail.com>
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(when (require 'elpy nil t)
  (elpy-enable))

(setq elpy-rpc-backend "jedi")

(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))

(defun igorb/python-mode-hook ()
;;  (setq tab-width 2)
  (local-set-key [return] 'newline-and-indent)
  (setq indent-tabs-mode t)
  (auto-fill-mode 1)
  (turn-on-eldoc-mode)

  (define-key python-mode-map "\"" 'electric-pair)
  (define-key python-mode-map "\'" 'electric-pair)
  (define-key python-mode-map "(" 'electric-pair)
  (define-key python-mode-map "[" 'electric-pair)
  (define-key python-mode-map "{" 'electric-pair)
  )
(add-hook 'python-mode-hook 'igorb/python-mode-hook)

(add-hook 'python-mode-hook 'flyspell-prog-mode)

(custom-set-variables
'(python-remove-cwd-from-path nil)
)


;;; emacs-rc-python.el ends here
