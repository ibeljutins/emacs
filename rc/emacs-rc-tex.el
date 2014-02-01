;;; emacs-rc-tex.el ---

;; Copyright (C) 2014 Igor Bel
;;
;; Author: igorb@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(setenv "TEXINPUTS"
        (concat (getenv "TEXINPUTS")
                ":/home/igorb/tex/styles//:/home/igorb/projects/fprog/journal-issues/class//"))

;(require 'tex-site)
(setq-default TeX-master nil)
(setq TeX-parse-self t)
(setq TeX-auto-save t)
(setq TeX-default-mode 'latex-mode)
(setq TeX-open-quote "``")
(setq TeX-close-quote "''")

;(autoload 'turn-on-bib-cite "bib-cite")

(defun igorb/TeX-keymap ()
  (local-set-key [(meta i)]
                 '(lambda ()
                    (interactive)
                    (insert "\n\\item "))))

(defun igorb/texinfo-hook ()
  (local-set-key [delete]  'delete-char)
  (setq delete-key-deletes-forward t))
(add-hook 'texinfo-mode-hook 'igorb/texinfo-hook)

(defun igorb/tex-mode-hook ()
  (local-set-key "\\" 'TeX-electric-macro)
;  (turn-on-bib-cite)
  (igorb/TeX-keymap)
;  (setq bib-cite-use-reftex-view-crossref t)
  )
(add-hook 'TeX-mode-hook 'igorb/tex-mode-hook)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)

;; CDLaTeX mode
;(autoload 'cdlatex-mode "cdlatex" "CDLaTeX Mode" t)
;(autoload 'turn-on-cdlatex "cdlatex" "CDLaTeX Mode" nil)
;(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex) ; with AUCTeX LaTeX mode
;(add-hook 'latex-mode-hook 'turn-on-cdlatex)
                                        ; with Emacs latex mode

;;; emacs-rc-tex.el ends here
