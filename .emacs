;; set init file for custom settings
(setq custom-file "~/.emacs.d/custom.el")

(when (equal system-type 'darwin)
  (setenv "PATH" (concat "/Users/igorb/Library/Haskell/bin:/opt/local/bin:/usr/local/bin:/usr/local/texlive/2008/bin/universal-darwin/:/Users/igorb/bin:/Users/igorb/exp/bin:" (getenv "PATH")))
  (setenv "DYLD_FALLBACK_LIBRARY_PATH" "/usr/lib:/opt/local/lib:/usr/X11R6/lib:~/exp/lib")
  (push "/opt/local/bin" exec-path)
  (push "/usr/local/bin" exec-path)
  (push "/Users/igorb/bin" exec-path)
  )
(when (string= (system-name) "igorb")
  (setenv "PATH" (concat "/home/igorb/.cabal/bin:" (getenv "PATH")))
  (push "/home/igorb/.cabal/bin" exec-path)
  (push "/home/igorb/exp/bin" exec-path)
  )

;; packages

(require 'package)
;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade.ferrier.me.uk/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(setq package-enable-at-startup nil)
(package-initialize)
(package-refresh-contents)

(defvar my-packages '(;better-defaults
                      abyss-theme
                      ac-cider
                      ahungry-theme
                      alect-themes
                      ample-theme
                      ample-zen-theme
                      async
                      auto-complete
                      auto-highlight-symbol
                      autumn-light-theme
                      basic-theme
                      c-eldoc
                      cask
                      cider
                      clojure-mode
                      cyberpunk-theme
                      dash
                      diff-hl
                      dired+
                      duplicate-thing
                      edts
                      epl
                      eproject
                      erlang
                      f
                      faff-theme
                      farmhouse-theme
                      gandalf-theme
                      ghc
                      git-commit
                      green-phosphor-theme
                      haskell-mode
                      helm
                      helm-core
                      hexrgb
                      hindent
                      hydandata-light-theme
                      js3-mode
                      leuven-theme
                      lush-theme
                      magit
                      magit-popup
                      majapahit-theme
                      markdown-mode
                      meacupla-theme
                      minimal-theme
                      org-beautify-theme
                      package-build
                      paper-theme
                      paredit
                      pastels-on-dark-theme
                      pkg-info
                      popup
                      professional-theme
                      projectile
                      queue
                      railscasts-theme
                      rainbow-delimiters
                      s
                      seq
                      shm
                      shut-up
                      smyx-theme
                      spacemacs-theme
                      spinner
                      tangotango-theme
                      with-editor
                      zonokai-theme                      
                      ))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))

(load "~/emacs/rc/emacs-rc-autocomplete.el")

;; add commonly used paths
(push "~/emacs/misc" load-path)
(push "~/.local/bin" load-path)
(push "~/usr/bin" load-path)
(push "~/projects/emacs-addons" load-path)
(push "~/emacs/programming" load-path)

;; load concrete packages

(load "~/emacs/rc/emacs-rc-cedet.el")
;;(load "~/emacs/rc/emacs-rc-erlang.el")

;;(load "~/emacs/rc/emacs-rc-mule.el")
(load "~/emacs/rc/emacs-rc-backups.el")
(load "~/emacs/rc/emacs-rc-misc-things.el")
(load "~/emacs/rc/emacs-rc-common-hooks.el")
(load "~/emacs/rc/emacs-rc-decor.el")
;(load "~/emacs/rc/emacs-rc-smex.el")
(load "~/emacs/rc/emacs-rc-kbd.el")
(load "~/emacs/rc/emacs-rc-info.el")
(load "~/emacs/rc/emacs-rc-osd.el")
;(load "~/emacs/rc/emacs-rc-yasnippet.el")
;; TODOs, etc.
(load "~/emacs/rc/emacs-rc-remember.el")
(load "~/emacs/rc/emacs-rc-org-mode.el")
;; text editing
(load "~/emacs/rc/emacs-rc-ispell.el")
(load "~/emacs/rc/emacs-rc-markdown.el")
;;(load "~/emacs/rc/emacs-rc-muse.el")
;;(load "~/emacs/rc/emacs-rc-tex.el")
(load "~/emacs/rc/emacs-rc-nxml.el")
(load "~/emacs/rc/emacs-rc-html.el")
;(load "~/emacs/rc/emacs-rc-wikis.el")
;; programming tools & languages
(load "~/emacs/rc/emacs-rc-prog-misc.el")
(load "~/emacs/rc/emacs-rc-flymake.el")
(load "~/emacs/rc/emacs-rc-gdb.el")
(load "~/emacs/rc/emacs-rc-ccmode.el")
(load "~/emacs/rc/emacs-rc-python.el")
;;(load "~/emacs/rc/emacs-rc-doxygen.el")
;(load "~/emacs/rc/emacs-rc-elisp.el")
;(load "~/emacs/rc/emacs-rc-ecb.el")
;(load "~/emacs/rc/emacs-rc-prolog.el")
(load "~/emacs/rc/emacs-rc-javascript.el")
(load "~/emacs/rc/emacs-rc-css.el")
;(load "~/emacs/rc/emacs-rc-scheme.el")
;;(load "~/emacs/rc/emacs-rc-ocaml.el")
;(load "~/emacs/rc/emacs-rc-lisp.el")
;(load "~/emacs/rc/emacs-rc-clojure.el")
;(load "~/emacs/rc/emacs-rc-slime.el")
(load "~/emacs/rc/emacs-rc-haskell.el")
;(load "~/emacs/rc/emacs-rc-scala.el")
(load "~/emacs/rc/emacs-rc-sh-mode.el")
(load "~/emacs/rc/emacs-rc-auto-insert.el")
(load "~/emacs/rc/emacs-rc-cmake.el")
;(load "~/emacs/rc/emacs-rc-distel.el")
;(load "~/emacs/rc/emacs-rc-octave.el")

;; VCS & DVCS
;(load "~/emacs/rc/emacs-rc-mercurial.el")
;(load "~/emacs/rc/emacs-rc-dvc.el")
(load "~/emacs/rc/emacs-rc-git.el")
(load "~/emacs/rc/emacs-rc-vcs-misc.el")

;; WWW, IM, social networking & blogging
;(load "~/emacs/rc/emacs-rc-twitter.el")
;(load "~/emacs/rc/emacs-rc-jabber.el")
(load "~/emacs/rc/emacs-rc-w3.el")
;(load "~/emacs/rc/emacs-rc-erc.el")
(load "~/emacs/rc/emacs-rc-w3m.el")
;(load "~/emacs/rc/emacs-rc-eblogger.el")
;(load "~/emacs/rc/emacs-rc-lj.el")

;;(load "~/emacs/rc/emacs-rc-epg.el")
(load "~/emacs/rc/emacs-rc-server.el")
;(load "~/emacs/rc/emacs-rc-ess.el")
(load "~/emacs/rc/emacs-rc-pretty-lambda.el")
;(load "~/emacs/rc/emacs-rc-sdcv.el")
(load "~/emacs/rc/emacs-rc-iswitchb.el")

;;(load "~/emacs/rc/emacs-rc-timeclock.el")
;;(load "~/emacs/rc/emacs-rc-autocomplete.el")
;;(load "~/emacs/rc/emacs-rc-gclient.el")
;; (load "~/emacs/rc/emacs-rc-.el")
;; (load "~/emacs/rc/emacs-rc-.el")

(defun igorb/get-short-hostname ()
  (let* ((sys-name (system-name))
         (idx (string-match "\\." sys-name)))
    (if idx
        (substring sys-name 0 idx)
      sys-name)))

(let* ((fname (concat "~/emacs/rc/emacs-rc-local-" (igorb/get-short-hostname) ".el")))
  (when (file-exists-p fname)
    (load fname)))

(load "~/emacs/rc/emacs-rc-desktop.el")

;;(load "~/emacs/passwords.el.gpg")

(load custom-file 'noerror)

;; for org-mode
(setq comment-start nil)

;; for emacs-jabber
;;(define-key ctl-x-map "\C-j" jabber-global-keymap)

;; Default encoding
(setq file-name-coding-system 'utf-8)

;; Switch windows with M-<ARROW>
(windmove-default-keybindings 'meta)


;;; IBuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(setq ibuffer-formats
      '((mark modified read-only " "
              (name 30 30 :left :elide) " "
              (size 9 -1 :right) " "
              (mode 16 16 :left :elide) " " filename-and-process)
        (mark " " (name 16 -1) " " filename)))

;; Use human readable Size column instead of original one
;(define-ibuffer-column size-h
;  (:name "Size" :inline t)
;  (cond
;   ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
;   ((> (buffer-size) 100000) (format "%7.0fk" (/ (buffer-size) 1000.0)))
;   ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
;   (t (format "%8d" (buffer-size)))))

;;; Modify the default ibuffer-formats
;(setq ibuffer-formats
;      '((mark modified read-only " "
;	      (name 18 18 :left :elide)
;	      " "
;	      (size-h 9 -1 :right)
;	      " "
;	      (mode 16 16 :left :elide)
;	      " "
;	      filename-and-process)))

;(setq main-line-separator-style 'chamfer14)
(setq main-line-separator-style 'arrow14)
;(setq main-line-separator-style 'slant-right)

(defcustom main-line-color1 "#666666"
  "Mainline color background 1"
  :group 'main-line)

(defcustom main-line-color2 "#333333"
  "Mainline color background 2"
  :group 'main-line)

(require 'main-line)

(setq browse-url-browser-function 'eww-browse-url)

(require 'powerline)

;; Compilation ANSI colors
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
