;;; emacs-rc-nxml.el --- customisation of nXML-mode

;; Copyright (C) 2014 Igor Bel
;;
;; Author: igorb@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;; NXML mode

(defun igorb/nxml-mode-hook ()
  (local-set-key "\C-c/" 'nxml-finish-element)
  (auto-fill-mode -1)
  (rng-validate-mode)
  (unify-8859-on-decoding-mode)
  (setq ispell-skip-html t)
  (hs-minor-mode 1)
  )
(add-hook 'nxml-mode-hook 'igorb/nxml-mode-hook)
(add-hook 'nxml-mode-hook 'igorb/common-hook)

(add-to-list
 'auto-mode-alist
 (cons (concat "\\."
               (regexp-opt
                '("xml" "xsd" "sch" "rng" "xslt" "svg" "rss" "rdf" "msbuildproj") t) "\\'")
       'nxml-mode))
(push '("<\\?xml" . nxml-mode) magic-mode-alist)

;; (add-to-list 'load-path "~/emacs/docbook-menu")
;; (require 'docbk-menu)
;; (add-hook 'nxml-mode-hook 'docbook-menu-mode)

(custom-set-variables
 '(nxml-auto-insert-xml-declaration-flag nil)
 '(nxml-attribute-indent 2)
 '(nxml-bind-meta-tab-to-complete-flag t)
 '(nxml-slash-auto-complete-flag t)
)

(add-to-list 'hs-special-modes-alist
             '(nxml-mode
               "\\|<[^/>]&>\\|<[^/][^>]*[^/]>"
               ""
               nil))

;;; emacs-nxml.el ends here
