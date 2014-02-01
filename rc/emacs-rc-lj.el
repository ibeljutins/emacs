;;; emacs-rc-lj.el ---

;; Copyright (C) 2014 Igor Bel
;;
;; Author: igorb@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(add-to-list 'load-path "~/emacs/ljupdate/")
(require 'ljupdate)

(add-hook 'lj-compose-common-hook
          (lambda ()
            (auto-fill-mode nil)
            ))


(custom-set-variables
 '(lj-cache-login-information t)
 '(lj-default-username "igorb")
 )

;;; emacs-rc-lj.el ends here
