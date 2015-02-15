;;; emacs-rc-backups.el --- 

;; Copyright (C) Igor Bel
;;
;; Author: Igor Bel <igorb@gmail.com>
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

;;; Backup Settings
;; This setting moves all backup files to a central location. Got it from this page.
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))
;;Make backups of files, even when they're in version control
(setq vc-make-backup-files t)
(setq backup-by-copying t)

;;; emacs-rc-backups.el ends here
