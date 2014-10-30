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

  ;;(add-to-list 'ac-sources 'ac-source-ghc-mod)
  )
(add-hook 'haskell-mode-hook 'igorb/haskell-mode-hook)

(defun unicode-symbol (name)
  "Translate a symbolic name for a Unicode character -- e.g., LEFT-ARROW                                      
 or GREATER-THAN into an actual Unicode character code. "
  (decode-char 'ucs (case name                                             
		      (left-arrow 8592)
		      (up-arrow 8593)
		      (double-right-arrow 8658)
		      (right-arrow 8594)
		      (down-arrow 8595)                                                
		      (double-vertical-bar #X2551)                  
		      (equal #X003d)
		      (not-equal #X2260)
		      (identical #X2261)
		      (not-identical #X2262)
		      (less-than #X003c)
		      (greater-than #X003e)
		      (less-than-or-equal-to #X2264)
		      (greater-than-or-equal-to #X2265)                        
		      (logical-and #X2227)
		      (logical-or #X2228)
		      (logical-neg #X00AC)                                                  
		      ('nil #X2205)
		      (horizontal-ellipsis #X2026)
		      (double-exclamation #X203C)
		      (prime #X2032)
		      (double-prime #X2033)
		      (for-all #X2200)
		      (there-exists #X2203)
		      (element-of #X2208)              
		      (square-root #X221A)
		      (squared #X00B2)
		      (cubed #X00B3)                                            
		      (lambdas #X03BB)
		      (alpha #X03B1)
		      (beta #X03B2)
		      (gamma #X03B3)
		      (compose 8853)
		      (delta #X03B4))))

(defun substitute-pattern-with-unicode (pattern symbol)
  "Add a font lock hook to replace the matched part of PATTERN with the                                       
     Unicode symbol SYMBOL looked up with UNICODE-SYMBOL."
  (font-lock-add-keywords
   nil `((,pattern 
	  (0 (progn (compose-region (match-beginning 1) (match-end 1)
				    ,(unicode-symbol symbol)
				    'decompose-region)
		    nil))))))

(defun substitute-patterns-with-unicode (patterns)
  "Call SUBSTITUTE-PATTERN-WITH-UNICODE repeatedly."
  (mapcar #'(lambda (x)
	      (substitute-pattern-with-unicode (car x)
					       (cdr x)))
	  patterns))

(defun haskell-unicode ()
  (substitute-patterns-with-unicode
   (list (cons "\\(<-\\)" 'left-arrow)
	 (cons "\\(-->\\)" 'double-right-arrow)
	 (cons "\\(->\\)" 'right-arrow)
	 (cons "\\(==\\)" 'identical)
	 (cons "\\(/=\\)" 'not-identical)
	 (cons "\\(()\\)" 'nil)
	 (cons "\\<\\(sqrt\\)\\>" 'square-root)
	 (cons "\\(&&\\)" 'logical-and)
	 (cons "\\(||\\)" 'logical-or)
	 ;;(cons "\\(.\\)" 'compose)
	 (cons "\\<\\(not\\)\\>" 'logical-neg)
	 (cons "\\(>\\)\\[^=\\]" 'greater-than)
	 (cons "\\(<\\)\\[^=\\]" 'less-than)
	 (cons "\\(>=\\)" 'greater-than-or-equal-to)
	 (cons "\\(<=\\)" 'less-than-or-equal-to)
	 (cons "\\<\\(alpha\\)\\>" 'alpha)
	 (cons "\\<\\(beta\\)\\>" 'beta)
	 (cons "\\<\\(gamma\\)\\>" 'gamma)
	 (cons "\\<\\(delta\\)\\>" 'delta)
	 (cons "\\(''\\)" 'double-prime)
	 (cons "\\('\\)" 'prime)
	 (cons "\\(!!\\)" 'double-exclamation)
	 (cons "\\(\\.\\.\\)" 'horizontal-ellipsis))))
;;(add-hook 'haskell-mode-hook 'haskell-unicode)

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
