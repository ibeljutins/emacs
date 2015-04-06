;;; emacs-rc-git.el ---

;; magit
;(add-to-list 'load-path "~/projects/magit")

(require 'magit)
(require 'magit-svn)

(setq magit-auto-revert-mode nil)
(setq magit-last-seen-setup-instructions "1.4.0")

(global-set-key "\C-cm" 'magit-status)
(custom-set-variables
 '(magit-save-some-buffers (quote dontask)))

(add-hook 'magit-mode-hook 'turn-on-magit-svn)

(setq magit-process-connection-type nil)

(define-key magit-mode-map "q" 'bury-buffer)

;;(require 'magithub)


;;; emacs-rc-git.el ends here
