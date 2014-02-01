;;; emacs-rc-scala.el --- 

;; Copyright (C) Igor Bel
;;
;; Author: Igor Bel <igorb@gmail.com>
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet


(defun igorb/scala-mode-hook ()
  (setq indent-tabs-mode nil)
  
  )
(add-hook 'scala-mode-hook 'igorb/scala-mode-hook)
;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; TODO: add setting of 
;; https://github.com/aemoncannon/ensime
;; https://github.com/RayRacine/scallap

;;; emacs-rc-scala.el ends here
