;;; emacs-rc-smex.el --- 

;; Copyright (C) Igor Bel
;;
;; Author: Igor Bel <igorb@gmail.com>
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(require 'smex)
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is our old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


;; Use the M-n to search the buffer for the word the cursor is currently pointing. M-p to go backwards.
;;(load-library "smart-scan")  


;;; emacs-rc-smex.el ends here
