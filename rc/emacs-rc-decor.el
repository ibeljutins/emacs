;;; emacs-rc-decor.el ---

;; Copyright (C) 2014 Igor Bel
;;
;; Author: igorb@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'tree-widget)

(load-library "time")
(setq display-time-24hr-format t
      display-time-mail-file t
      display-time-form-list (list 'time 'load)
      display-time-day-and-date t)
(display-time)
(blink-cursor-mode t)

;; recent file list
(recentf-mode 1)
(setq recentf-max-menu-items 77)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;; ido
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

;;
(require 'mwheel)
(mwheel-install)

;; use y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; set misc decoration variables
(custom-set-variables
 '(global-font-lock-mode t)
 '(scalable-fonts-allowed t)
 '(uniquify-buffer-name-style (quote forward))
 '(use-dialog-box nil)
 '(column-number-mode t)
 '(display-time-mode t)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60)))
 '(custom-buffer-done-kill t)
 '(initial-scratch-message nil)
 '(transient-mark-mode t))

(custom-set-faces
 '(mode-line ((t (:background "#efefef" :foreground "black" :height 0.8 :foundry "Light" :family "Droid Sans Mono"))))
 '(mode-line-highlight ((t (:box (:line-width 1 :color "#0000ff")))))
 '(mode-line-inactive ((t (:inherit mode-line :foreground "#888888" :weight light))))
 )

;;; emacs-rc-decor.el ends herey
