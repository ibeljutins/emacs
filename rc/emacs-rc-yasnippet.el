;;; emacs-rc-yasnippet.el ---

;; Copyright (C) Igor Bel
;;
;; Author: Igor Bel <igorb@gmail.com>

(require 'yasnippet)
(setq yas/snippet-dirs (append '("~/emacs/snippets/") yas/snippet-dirs))
(yas/global-mode 1)
;;(yas/reload-all)

(add-to-list 'auto-mode-alist '("/snippets/" . snippet-mode))

;; hook for automatic reloading of changed snippets
;; TODO: do we really need it still?
(defun igorb/update-yasnippets-on-save ()
  (when (string-match "/snippets/" buffer-file-name)
;;    (yas/load-snippet-dirs)
    (yas/reload-all)
    ))
;(add-hook 'after-save-hook 'igorb/update-yasnippets-on-save)


;;; emacs-rc-yasnippet.el ends here
