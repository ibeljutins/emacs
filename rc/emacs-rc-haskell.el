;;; emacs-rc-haskell.el ---

;; Copyright (C) 2014 Igor Bel
;;
;; Author: igorb@gmail.com
;; Version: $Id: emacs-rc-haskell.el,v 0.0 2014/01/28 08:58:32 igorb Exp $
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet


;;(add-to-list 'load-path "~/projects/haskell-mode")
;;(load "~/projects/haskell-mode/haskell-site-file.el")

;;(require 'haskell-checkers)

(add-to-list 'auto-mode-alist '("\\.hsc$" . haskell-mode))

(autoload 'ghc-init "ghc" nil t)

(eval-after-load 'flycheck '(require 'flycheck-hdevtools))

(custom-set-variables
 '(haskell-program-name "ghci")
 '(inferior-haskell-wait-and-jump t)
; '(hs-lint-replace-with-suggestions t)
 )

;; this gets called by outline to determine the level. Just use the length of the whitespace
(defun hsk-outline-level ()
  (let (buffer-invisibility-spec)
    (save-excursion
	 (skip-chars-forward "\t ")
	 (current-column))))

(defun igorb/haskell-mode-hook ()
  (ghc-init)
  (flymake-mode)
  (turn-on-haskell-doc-mode)
  (turn-on-haskell-indent)
  ;;(turn-on-haskell-ghci)
  (turn-on-eldoc-mode)
  (turn-on-haskell-indentation)
  (local-set-key [return] 'newline-and-indent)
  (local-set-key "\C-cl" 'hs-lint)
  (local-set-key "\C-ch" 'haskell-hoogle)
  (local-set-key "\C-c\C-h" 'haskell-hayoo)
  (setq tab-width 4)
  ;; outline uses this regexp to find headers. I match lines with no indent and indented
  ;; some lines, such as "--" ... "class"
  (setq outline-regexp "^[^\t ].*\\|^.*[\t ]+\\(where\\|of\\|do\\|in\\|if\\|then\\|else\\|let\\|module\\|import\\|deriving\\|instance\\|class\\)[\t\n ]")
  ;; enable our level computation
  (setq outline-level 'hsk-outline-level)
  ;; do not use their \C-c@ prefix, too hard to type. Note this overides some python mode bindings
  ;;(setq outline-minor-mode-prefix "C-c")
  ;; turn on outline mode
  (outline-minor-mode t)
  ;; initially hide all but the headers
  ;;(hide-body)
;;  (turn-on-haskell-simple-indent)
  (setq haskell-font-lock-symbols t)

  (add-to-list 'ac-sources 'ac-source-ghc-mod)
  )
(add-hook 'haskell-mode-hook 'igorb/haskell-mode-hook)

(require 'haskell-interactive-mode)
(defun igorb/hs-interactive-hook ()
  (local-set-key (kbd "C-<up>")
		 '(lambda () (haskell-interactive-mode-history-toggle 1)))
  (local-set-key (kbd "C-<down>")
		 '(lambda () (haskell-interactive-mode-history-toggle -1)))
  )
(add-hook 'haskell-interactive-mode-hook 'igorb/hs-interactive-hook)

;;
(add-to-list 'exec-path "~/.cabal/bin")

;;; emacs-rc-haskell.el ends here
