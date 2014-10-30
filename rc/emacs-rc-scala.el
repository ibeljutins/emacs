;;; emacs-rc-scala.el --- 

;; Copyright (C) Igor Bel
;;
;; Author: Igor Bel <igorb@gmail.com>
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet


;; (setq exec-path (append exec-path (list "/usr/bin" ))) ;;change to location of scala bin!!! necessary for comint.
;; ;;(require 'scala-mode-auto)
;; (setq ensime-default-java-home "")
(require 'scala-mode2)
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(eval-after-load "scala-mode2" 
  '(progn
     (define-key scala-mode-map (kbd "<f9>") 'ensime-builder-build)
     (define-key scala-mode-map (kbd "<f10>") 'ensime-inf-switch)))

(eval-after-load "scala-mode2" 
  '(progn
     (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
     (define-key scala-mode-map (kbd "<f9>") 'scala-run)
     (define-key scala-mode-map (kbd "RET") 'newline-and-indent)
     ))

(defun scala-run () 
  (interactive)   
  (ensime-sbt-action "run")
  (ensime-sbt-action "~compile")
  (let ((c (current-buffer)))
    (switch-to-buffer-other-window
     (get-buffer-create (ensime-sbt-build-buffer-name)))
    (switch-to-buffer-other-window c)))

;; (setq exec-path
;;       (append exec-path (list "~/usr/bin")))

(defun igorb/scala-mode-hook ()
  (setq indent-tabs-mode nil)
  
  )
(add-hook 'scala-mode-hook 'igorb/scala-mode-hook)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)


;; TODO: add setting of 
;; https://github.com/aemoncannon/ensime
;; https://github.com/RayRacine/scallap

;;; emacs-rc-scala.el ends here
