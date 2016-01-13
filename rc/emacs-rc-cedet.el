;;; emacs-rc-cedet.el ---

(custom-set-faces
'(semantic-tag-boundary-face ((t (:overline "#bbbbbb")))))

;(load-file "~/projects/cedet/cedet-devel-load.el")
;(load-file "~/projects/cedet/contrib/cedet-contrib-load.el")
;(add-to-list 'load-path "~/projects/cedet/contrib/")
;(add-to-list  'Info-directory-list "~/projects/cedet/doc/info")

(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
;(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
;(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-highlight-mode)
;;(add-to-list 'semantic-default-submodes 'semantic-load-enable-minimum-features)
(add-to-list 'semantic-default-submodes 'semantic-load-enable-excessive-code-helpers)
(add-to-list 'semantic-default-submodes 'global-semantic-tag-folding-mode)
;;(add-to-list 'semantic-default-submodes 'global-semantic-show-unmatched-syntax-mode)
;;(add-to-list 'semantic-default-submodes 'global-semantic-highlight-edits-mode)
;;(add-to-list 'semantic-default-submodes 'global-semantic-show-parser-state-mode)

;; Activate semantic
(semantic-mode 1)

(require 'semantic/bovine/c)
(require 'semantic/bovine/gcc)
;;(require 'semantic/bovine/clang)

(semantic-add-system-include "/usr/include/boost" 'c++-mode)
(semantic-add-system-include "/usr/include" 'c++-mode)
(semantic-add-system-include "/usr/include/netinet" 'c++-mode)
(semantic-add-system-include "/usr/include/net" 'c++-mode)
(semantic-add-system-include "/usr/include/arpa" 'c++-mode)
(semantic-add-system-include "/usr/include/sys" 'c++-mode)
(semantic-add-system-include "/usr/include/linux" 'c++-mode)

(require 'cedet-files)

;; loading contrib...
;(require 'eassist)

;; customisation of modes
(defun igorb/cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
  ;;
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)

  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
;;  (local-set-key (kbd "C-c <left>") 'semantic-tag-folding-fold-block)
;;  (local-set-key (kbd "C-c <right>") 'semantic-tag-folding-show-block)

  (add-to-list 'ac-sources 'ac-source-semantic)
  )
;; (add-hook 'semantic-init-hooks 'igorb/cedet-hook)
(add-hook 'c-mode-common-hook 'igorb/cedet-hook)
(add-hook 'lisp-mode-hook 'igorb/cedet-hook)
(add-hook 'scheme-mode-hook 'igorb/cedet-hook)
(add-hook 'emacs-lisp-mode-hook 'igorb/cedet-hook)
(add-hook 'erlang-mode-hook 'igorb/cedet-hook)

(defun igorb/c-mode-cedet-hook ()
 ;; (local-set-key "." 'semantic-complete-self-insert)
 ;; (local-set-key ">" 'semantic-complete-self-insert)
  (local-set-key "\C-ct" 'eassist-switch-h-cpp)
  (local-set-key "\C-xt" 'eassist-switch-h-cpp)
  (local-set-key "\C-ce" 'eassist-list-methods)
  (local-set-key "\C-c\C-r" 'semantic-symref)

  (add-to-list 'ac-sources 'ac-source-gtags)
  )
(add-hook 'c-mode-common-hook 'igorb/c-mode-cedet-hook)

;(when (cedet-gnu-global-version-check t)
;  (semanticdb-enable-gnu-global-databases 'c-mode t)
;  (semanticdb-enable-gnu-global-databases 'c++-mode t))

;(when (cedet-ectag-version-check t)
;  (semantic-load-enable-primary-ectags-support))

;; SRecode
;(global-srecode-minor-mode 1)

;; EDE
;(global-ede-mode 1)
;(ede-enable-generic-projects)

;; helper for boost setup...
(defun c++-setup-boost (boost-root)
  (when (file-accessible-directory-p boost-root)
    (let ((cfiles (cedet-files-list-recursively boost-root "\\(config\\|user\\)\\.hpp")))
      (dolist (file cfiles)
        (add-to-list 'semantic-lex-c-preprocessor-symbol-file file)))))


;; EDE functions
(defun igorb/ede-get-local-var (fname var)
  "fetch given variable var from :local-variables of project of file fname"
  (let* ((current-dir (file-name-directory fname))
         (prj (ede-current-project current-dir)))
    (when prj
      (let* ((ov (oref prj local-variables))
            (lst (assoc var ov)))
        (when lst
          (cdr lst))))))

;; setup compile package
(require 'compile)
(setq compilation-disable-input nil)
(setq compilation-scroll-output t)
(setq mode-compile-always-save-buffer-p t)

(defun igorb/compile ()
  "Saves all unsaved buffers, and runs 'compile'."
  (interactive)
  (save-some-buffers t)
  (let* ((fname (or (buffer-file-name (current-buffer)) default-directory))
	 (current-dir (file-name-directory fname))
         (prj (ede-current-project current-dir)))
    (if prj
	(project-compile-project prj)
	(compile compile-command))))
(global-set-key [f9] 'igorb/compile)

;;
(defun igorb/gen-std-compile-string ()
  "Generates compile string for compiling CMake project in debug mode"
  (let* ((current-dir (file-name-directory
                       (or (buffer-file-name (current-buffer)) default-directory)))
         (prj (ede-current-project current-dir))
         (root-dir (ede-project-root-directory prj)))
    (concat "cd " root-dir "; make -j2")))

;;
(defun igorb/gen-cmake-debug-compile-string ()
  "Generates compile string for compiling CMake project in debug mode"
  (let* ((current-dir (file-name-directory
                       (or (buffer-file-name (current-buffer)) default-directory)))
         (prj (ede-current-project current-dir))
         (root-dir (ede-project-root-directory prj))
         (subdir "")
         )
    (when (string-match root-dir current-dir)
      (setf subdir (substring current-dir (match-end 0))))
    (concat "cd " root-dir "Debug/" "; make -j3")))

;;; Projects

;; cpp-tests project definition
(when (file-exists-p "~/projects/lang-exp/cpp/CMakeLists.txt")
  (setq cpp-tests-project
	(ede-cpp-root-project "cpp-tests"
			      :file "~/projects/lang-exp/cpp/CMakeLists.txt"
			      :system-include-path '("/home/igorb/exp/include"
						     boost-base-directory)
			      :compile-command "cd Debug && make -j2"
			      )))

(when (file-exists-p "~/projects/squid-gsb/README")
  (setq squid-gsb-project
	(ede-cpp-root-project "squid-gsb"
			      :file "~/projects/squid-gsb/README"
			      :system-include-path '("/home/igorb/exp/include"
						     boost-base-directory)
			      :compile-command "cd Debug && make -j2"
			      )))

;; Setup JAVA....
;(require 'semantic/db-javap)

;; example of java-root project

;; (ede-ant-project "Lucene" 
;; 		       :file "~/work/lucene-solr/lucene-4.0.0/build.xml"
;; 		       :srcroot '("core/src")
;; 		       :classpath (cedet-files-list-recursively "~/work/lucene-solr/lucene-4.0.0/" ".*\.jar$")
;; 		       )
