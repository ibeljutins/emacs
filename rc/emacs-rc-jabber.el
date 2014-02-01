;;; emacs-rc-jabber.el ---

;; Copyright (C) 2014 Igor Bel
;;
;; Author: igorb@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;;(add-to-list 'load-path "~/emacs/emacs-jabber")
;;(require 'jabber)
(require 'jabber-bookmarks)

(defun igorb/jabber-connect-hook (jc)
  (jabber-send-presence "" "I'm online" 10)
  (let* ((state-data (fsm-get-state-data jc))
         (server (plist-get state-data :server)))
    (message "%s" server)
    (if (string-equal server "gmail.com")
        (progn
;;          (jabber-groupchat-join jc "devil@conference.jabber.ru" "igorb")
;;          (jabber-groupchat-join jc "haskell@conference.jabber.ru" "igorb")
;;          (jabber-groupchat-join jc "lisp@conference.jabber.ru" "igorb")
;;          (jabber-groupchat-join jc "emacs@conference.jabber.ru" "igorb")
;;          (jabber-groupchat-join jc "icfpc@conference.jabber.ru" "igorb")
;;          (jabber-groupchat-join jc "wax@conference.jabber.ru" "igorb")
;;          (jabber-groupchat-join jc "erlang@conference.jabber.ru" "igorb")
;;          (jabber-groupchat-join jc "clojure@conference.jabber.ru" "igorb")
          ))))
(add-hook 'jabber-post-connect-hooks 'igorb/jabber-connect-hook)

(defun igorb/jabber-chat-hook ()
  (auto-fill-mode -1)
  (flyspell-mode -1))
(add-hook 'jabber-chat-mode-hook 'igorb/jabber-chat-hook)

(require 'jabber-chatbuffer)
(eval-after-load "jabber-chatbuffer"
  (progn
    (define-key jabber-chat-mode-map "\r" 'newline)
    (define-key jabber-chat-mode-map [return] 'newline)
    (define-key jabber-chat-mode-map [C-return] 'jabber-chat-buffer-send)
    t))

(setq jabber-history-enabled t)
(setq jabber-use-global-history nil)
(setq jabber-roster-show-bindings nil)
(setq jabber-vcard-avatars-retrieve nil)

(require 'jabber-autoaway)
(add-hook 'jabber-post-connect-hook 'jabber-autoaway-start)

(setq jabber-alert-info-message-hooks (quote (jabber-info-echo)))
(setq jabber-alert-message-hooks (quote (jabber-message-beep jabber-message-scroll)))
(setq jabber-alert-presence-hooks (quote (jabber-presence-update-roster)))
(setq jabber-nickname "igorb")
(setq jabber-resource (concat "at-"
                              (if (string-equal (system-name) "igorb")
                                  "work"
                                "home")))

(setq jabber-chat-buffer-show-avatar nil)

(custom-set-variables
 '(jabber-auto-reconnect t)
 '(jabber-groupchat-buffer-format "*-jg-%n-*")
 '(jabber-roster-buffer "*-jroster-*")
 '(jabber-roster-line-format " %c %-25n %u %-8s  %S")
 '(jabber-chat-buffer-format "*-jc-%n-*")
 '(jabber-muc-private-buffer-format "*-jmuc-priv-%g-%n-*")
 '(jabber-rare-time-format "%e %b %Y %H:00")
 )

(custom-set-faces
 '(jabber-chat-prompt-system ((t (:foreground "darkgreen" :weight bold))))
 )

(setq fsm-debug nil)

;;; emacs-rc-jabber.el ends here
