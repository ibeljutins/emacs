;;; emacs-rc-info.el --- 

;; Copyright (C) 2014 Igor Bel
;;
;; Author: igorb@gmail.com
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(require 'info)
(add-to-list  'Info-directory-list "~/emacs/info")
(add-to-list  'Info-directory-list "/usr/share/info")

(when (equal system-type 'darwin)
  (add-to-list  'Info-directory-list "/opt/local/share/info"))

;;; emacs-rc-info.el ends here
