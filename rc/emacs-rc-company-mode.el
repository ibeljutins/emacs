;;; emacs-rc-company-mode.el ---

;; Copyright (C) Igor Bel
;;
;; Author: Igor Bel <igorb@gmail.com>
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet


(add-to-list 'load-path "~/emacs/company-mode")
(autoload 'company-mode "company" nil t)

(require 'company-c-headers)
(add-to-list 'company-backends 'company-c-headers)
(add-to-list 'company-c-headers-path-system "/usr/include/c++/4.9/")

;;; emacs-rc-company-mode.el ends here
