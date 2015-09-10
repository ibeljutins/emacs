;;; emacs-rc-ccmode.el ---

;; Copyright (C) 2014 Igor Bel
;;
;; Author: igorb@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'cc-mode)

(load "c-eldoc")
(setq c-eldoc-includes "-I~/exp/include -I./ -I../ ")

(add-to-list 'load-path "c:/bin/gtags/share/gtags/")
(autoload 'gtags-mode "gtags-mode" "Loading GNU Global")
(add-hook 'c-mode-hook '(lambda ()
			  (gtags-mode t)
			  (setq gtags-global-command "c:/bin/gtags/bin/global.exe")
			  (setq gtags-suggested-key-mapping t)))

(require 'gtags)
;; customisation of Global tags mode
(defun igorb/gtags-common-hook ()
  (gtags-mode t)
  (setq gtags-global-command "c:/bin/gtags/bin/global.exe")
  (setq gtags-suggested-key-mapping t)
  )

;; customisation of cc-mode
(defun igorb/c-mode-common-hook ()
  ;; style customization
  (c-set-offset 'member-init-intro '++)
  (setq tab-width 3)
  (setq   indent-tabs-mode nil)
  (c-set-offset 'substatement-open 0)
  (c-set-style "bsd")
  (setq c-basic-offset 3)
  (c-toggle-auto-hungry-state 0)
  ;; minor modes
  (auto-fill-mode 1)
  (c-turn-on-eldoc-mode)
  (gtags-mode 1)
  (hs-minor-mode 1)
  ;; local keys
  (local-set-key [return] 'newline-and-indent)
  )
(add-hook 'c-mode-common-hook 'igorb/c-mode-common-hook)
(add-hook 'c-mode-common-hook 'igorb/common-hook)
(add-hook 'c-mode-common-hook 'igorb/common-prog-hook)
(add-hook 'c-mode-common-hook 'igorb/gtags-common-hook)

(require 'info-look)
(info-lookup-add-help
 :mode 'c-mode
 :regexp "[^][()'\" \t\n]+"
 :ignore-case t
 :doc-spec '(("(libc)Symbol Index" nil nil nil)))

(defun fp-c-mode-routine ()
  (local-set-key "\M-q" 'rebox-comment))
(add-hook 'c-mode-hook 'fp-c-mode-routine)

(setq-default c-default-style (quote ((java-mode . "java") (other . "gnu"))))

(add-to-list 'auto-mode-alist '("\\.ipp$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))


;;
;;(require 'cuda-mode)

;;; emacs-rc-cmode.el ends here
