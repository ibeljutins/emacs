;;; emacs-rc-ruby.el ---
;; Copyright (C) 2014 Igor Bel

(add-to-list 'load-path "~/emacs/emacs-rails")

(defun try-complete-abbrev (old)
  (if (expand-abbrev) t nil))

(setq hippie-expand-try-functions-list
			'(try-complete-abbrev
				try-complete-file-name
				try-expand-dabbrev))

(require 'rails)

;;	(turn-on-eldoc-mode)

;;; emacs-rc-ruby.el ends here
