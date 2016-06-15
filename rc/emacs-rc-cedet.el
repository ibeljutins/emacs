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
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-highlight-mode)
(add-to-list 'semantic-default-submodes 'semantic-load-enable-excessive-code-helpers)
(add-to-list 'semantic-default-submodes 'global-semantic-tag-folding-mode)
;(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
;(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode)
;(add-to-list 'semantic-default-submodes 'semantic-load-enable-minimum-features)
;(add-to-list 'semantic-default-submodes 'global-semantic-show-unmatched-syntax-mode)
;(add-to-list 'semantic-default-submodes 'global-semantic-highlight-edits-mode)
;(add-to-list 'semantic-default-submodes 'global-semantic-show-parser-state-mode)

;; Activate semantic
(semantic-mode 1)

(require 'semantic/bovine/c)
(require 'semantic/bovine/gcc)
;(require 'semantic/bovine/clang)

(semantic-add-system-include "/usr/include/boost" 'c++-mode)
(semantic-add-system-include "/usr/include" 'c++-mode)
(semantic-add-system-include "/usr/include/c++/5" 'c++-mode)
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
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)
  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  ;(local-set-key (kbd "C-c <left>") 'semantic-tag-folding-fold-block)
  ;(local-set-key (kbd "C-c <right>") 'semantic-tag-folding-show-block)

  (add-to-list 'ac-sources 'ac-source-semantic)
  )
;(add-hook 'semantic-init-hooks 'igorb/cedet-hook)
(add-hook 'c-mode-common-hook 'igorb/cedet-hook)
(add-hook 'lisp-mode-hook 'igorb/cedet-hook)
(add-hook 'scheme-mode-hook 'igorb/cedet-hook)
(add-hook 'emacs-lisp-mode-hook 'igorb/cedet-hook)
(add-hook 'erlang-mode-hook 'igorb/cedet-hook)

;(defun igorb/c-mode-cedet-hook ()
;  (local-set-key "." 'semantic-complete-self-insert)
;  (local-set-key ">" 'semantic-complete-self-insert)
;  (local-set-key "\C-ct" 'eassist-switch-h-cpp)
;  (local-set-key "\C-xt" 'eassist-switch-h-cpp)
;  (local-set-key "\C-ce" 'eassist-list-methods)
;  (local-set-key "\C-c\C-r" 'semantic-symref)
;  (add-to-list 'ac-sources 'ac-source-gtags)
;  )
;(add-hook 'c-mode-common-hook 'igorb/c-mode-cedet-hook)

;(when (cedet-gnu-global-version-check t)
  (semanticdb-enable-gnu-global-databases 'c-mode t)
  (semanticdb-enable-gnu-global-databases 'c++-mode t)
;  )

;(when (cedet-ectag-version-check t)
;  (semantic-load-enable-primary-ectags-support))

;; SRecode
;(global-srecode-minor-mode 1)

;; EDE
(global-ede-mode 1)
(ede-enable-generic-projects)

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

;; Projects

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

(when (file-exists-p "~/projects/cisco/wood/README.md")
  (setq cpp-wood-project
        (ede-cpp-root-project "wood"
                              :file "~/projects/cisco/wood/README.md"
                              :system-include-path '("/usr/include"
                                                     "/usr/include/boost"
                                                     "/usr/include/c++/5")
                              :include-path '("./allshare/abstraction/api"
                                                     "./allshare/config/api"
                                                     "./allshare/dualindexmap/api"
                                                     "./allshare/fsm/api"
                                                     "./allshare/inc"
                                                     "./allshare/libttc/api"
                                                     "./allshare/responsebookkeeper/api"
                                                     "./allshare/svninfo/api"
                                                     "./allshare/testfsm/api"
                                                     "./allshare/ttlog/api"
                                                     "./allshare/ttlog/console/api"
                                                     "./allshare/ttlog/status/api"
                                                     "./allshare/ttnet/api"
                                                     "./functional/authentication/management/cdb_plugin_credentialmanager/api"
                                                     "./functional/cafe/static/cdb_plugin_cafe_xcommand/api"
                                                     "./functional/callusage/management/cdb_plugin_callusage/api"
                                                     "./functional/ciphersuite/management/cdb_plugin_ciphersuite/api"
                                                     "./functional/clusterdb/apps/management/cdb_plugin_cdb/api"
                                                     "./functional/collectd/management/cdb_plugin_collectd/api"
                                                     "./functional/conferencefactory/docs/source/api"
                                                     "./functional/conferencefactory/management/cdb_plugin_conferencefactory/api"
                                                     "./functional/conferencefactory/web/php/api"
                                                     "./functional/crashmonitor/api"
                                                     "./functional/crl_updater/management/cdb_plugin_crl_updater/api"
                                                     "./functional/cucmproxy/management/cdb_plugin_cucmproxy/api"
                                                     "./functional/cucmproxy/ts_plugins/ts_plugin_utils_lib/api"
                                                     "./functional/diagnostics/alarms/management/cdb_plugin_alarms/api"
                                                     "./functional/diagnostics/management/cdb_plugin_diagnostics/api"
                                                     "./functional/diagnostics/management/metric_plugin_diagnostics/api"
                                                     "./functional/diagnostics/management/mmonit_plugin_diagnostics/api"
                                                     "./functional/directorypolicy/management/cdb_plugin_directorypolicy/api"
                                                     "./functional/edgeconfigprovisioning/management/cdb_plugin_edgeconfigprovisioning/api"
                                                     "./functional/fail2ban/management/cdb_plugin_fail2ban_configuration/api"
                                                     "./functional/iptables/management/cdb_plugin_iptables_configuration/api"
                                                     "./functional/licensing/management/cdb_plugin_cloud_domains/api"
                                                     "./functional/licensing/management/cdb_plugin_licensemanager/api"
                                                     "./functional/licensing/management/cdb_plugin_licensing_options/api"
                                                     "./functional/linux/management/cdb_plugin_cba/api"
                                                     "./functional/linux/management/cdb_plugin_fips/api"
                                                     "./functional/linux/management/cdb_plugin_language/api"
                                                     "./functional/linux/management/cdb_plugin_login/api"
                                                     "./functional/linux/management/cdb_plugin_network/api"
                                                     "./functional/linux/management/cdb_plugin_snmp/api"
                                                     "./functional/linux/management/cdb_plugin_system/api"
                                                     "./functional/portforwarding/management/cdb_plugin_portforwarding/api"
                                                     "./functional/provisioning/common/management/cdb_plugin_common/api"
                                                     "./functional/provisioning/deviceprovisioning/management/cdb_plugin_deviceprovisioning/api"
                                                     "./functional/provisioning/findme/management/cdb_plugin_findme/api"
                                                     "./functional/provisioning/management/cdb_plugin_users/api"
                                                     "./functional/provisioning/phonebook/management/cdb_plugin_phonebook/api"
                                                     "./functional/provisioning/userpreference/management/cdb_plugin_userpreference/api"
                                                     "./functional/saml/metadata/cdb_plugin_saml_metadata/api"
                                                     "./functional/uch/management/cdb_plugin_uch/api"
                                                     "./functional/xcp/management/cdb_plugin_xcp/api"
                                                     "./product/oak/inc"
                                                     "./ppcmains/address_conversions/api"
                                                     "./ppcmains/alarm_manager/api"
                                                     "./ppcmains/alternatecloud/api"
                                                     "./ppcmains/assent/api"
                                                     "./ppcmains/bandwidthconversions/api"
                                                     "./ppcmains/bfcp/api"
                                                     "./ppcmains/bfcpnetworklogging/api"
                                                     "./ppcmains/bramble/findmeurimonitor/api"
                                                     "./ppcmains/bramble/framework/configuration/api"
                                                     "./ppcmains/bramble/framework/modulefactory/api"
                                                     "./ppcmains/bramble/listener/api"
                                                     "./ppcmains/bramble/presencerelay/api"
                                                     "./ppcmains/bramble/presencerelaymanager/api"
                                                     "./ppcmains/bramble/presencesubscriber/api"
                                                     "./ppcmains/bramble/presencetypes/api"
                                                     "./ppcmains/bramble/presenceuseragent/api"
                                                     "./ppcmains/bramble/statussync/api"
                                                     "./ppcmains/cdbconfigmgr/api"
                                                     "./ppcmains/cdbpersister/api"
                                                     "./ppcmains/cdbstatussync/api"
                                                     "./ppcmains/cdbutils/api"
                                                     "./ppcmains/cmdhandler/api"
                                                     "./ppcmains/codecs/api"
                                                     "./ppcmains/codecs/h323codecconversions/api"
                                                     "./ppcmains/com/api"
                                                     "./ppcmains/comcore/api"
                                                     "./ppcmains/commandcompletion/api"
                                                     "./ppcmains/common/filemonitor/api"
                                                     "./ppcmains/common/framework/commandmanager/api"
                                                     "./ppcmains/common/framework/configservices/api"
                                                     "./ppcmains/common/framework/eventdispatchers/iconfiginterest/api"
                                                     "./ppcmains/common/framework/eventdispatchers/iserviceobject/api"
                                                     "./ppcmains/common/framework/eventdispatchers/iserviceobjectcontroller/api"
                                                     "./ppcmains/common/fsmconfignotifier/api"
                                                     "./ppcmains/common/pidf/api"
                                                     "./ppcmains/common/sipreguac/api"
                                                     "./ppcmains/common/sipsubuac/api"
                                                     "./ppcmains/common/templates/api"
                                                     "./ppcmains/common/types/api"
                                                     "./ppcmains/comstdin/api"
                                                     "./ppcmains/configservicebroker/api"
                                                     "./ppcmains/contextlogging/api"
                                                     "./ppcmains/crypto/cryptoapi/api"
                                                     "./ppcmains/crypto/dh/api"
                                                     "./ppcmains/cuil/api"
                                                     "./ppcmains/cuil/oak/oakcommandhandlerfsm/api"
                                                     "./ppcmains/curlservice/api"
                                                     "./ppcmains/cvs/api"
                                                     "./ppcmains/dbusthreadmgr/api"
                                                     "./ppcmains/device/api"
                                                     "./ppcmains/dtmf/api"
                                                     "./ppcmains/event_manager/api"
                                                     "./ppcmains/exception/api"
                                                     "./ppcmains/extmanager/api"
                                                     "./ppcmains/forensics/api"
                                                     "./ppcmains/fsmwatchdog/api"
                                                     "./ppcmains/gk/api"
                                                     "./ppcmains/gk/gktest/api"
                                                     "./ppcmains/gk/linux_log_display/api"
                                                     "./ppcmains/gk/linux_time_zone/api"
                                                     "./ppcmains/gk/operlog/api"
                                                     "./ppcmains/gk/pooledobject/api"
                                                     "./ppcmains/gk/refcountedobject/api"
                                                     "./ppcmains/gkh323stack/api"
                                                     "./ppcmains/h264/api"
                                                     "./ppcmains/h323lib/api"
                                                     "./ppcmains/hdlc/api"
                                                     "./ppcmains/httpclient/api"
                                                     "./ppcmains/httpclientcurl/api"
                                                     "./ppcmains/instanceid/api"
                                                     "./ppcmains/ip/dns/api"
                                                     "./ppcmains/ip/sockhandler/api"
                                                     "./ppcmains/ivy/alarms/api"
                                                     "./ppcmains/ivy/application/factory/api"
                                                     "./ppcmains/ivy/application/interface/api"
                                                     "./ppcmains/ivy/application/manager/api"
                                                     "./ppcmains/ivy/application/transcoderpolicy/api"
                                                     "./ppcmains/ivy/application/transcoderpool/api"
                                                     "./ppcmains/ivy/b2bua/allowedmethods/api"
                                                     "./ppcmains/ivy/b2bua/callbridge/api"
                                                     "./ppcmains/ivy/b2bua/callconfig/api"
                                                     "./ppcmains/ivy/b2bua/callcontext/api"
                                                     "./ppcmains/ivy/b2bua/callcontext/factory/api"
                                                     "./ppcmains/ivy/b2bua/callsidecomponents/api"
                                                     "./ppcmains/ivy/b2bua/callstatus/api"
                                                     "./ppcmains/ivy/b2bua/content/api"
                                                     "./ppcmains/ivy/b2bua/desturirewriting/api"
                                                     "./ppcmains/ivy/b2bua/disconnectreason/api"
                                                     "./ppcmains/ivy/b2bua/duovideo/api"
                                                     "./ppcmains/ivy/b2bua/errordescription/api"
                                                     "./ppcmains/ivy/b2bua/listener/api"
                                                     "./ppcmains/ivy/b2bua/logging/api"
                                                     "./ppcmains/ivy/b2bua/mediacapabilities/api"
                                                     "./ppcmains/ivy/b2bua/offeranswer/sdp/api"
                                                     "./ppcmains/ivy/b2bua/sipheadermods/api"
                                                     "./ppcmains/ivy/b2bua/sipua/api"
                                                     "./ppcmains/ivy/b2bua/transcoder/api"
                                                     "./ppcmains/ivy/callresources/api"
                                                     "./ppcmains/ivy/framework/command/api"
                                                     "./ppcmains/ivy/framework/commandmanager/api"
                                                     "./ppcmains/ivy/framework/configuration/api"
                                                     "./ppcmains/ivy/framework/globalstatistics/api"
                                                     "./ppcmains/ivy/framework/modulefactory/api"
                                                     "./ppcmains/ivy/framework/serviceobjectcontroller/api"
                                                     "./ppcmains/ivy/framework/status/api"
                                                     "./ppcmains/ivy/ivy_common_test/api"
                                                     "./ppcmains/ivy/livenessmonitor/api"
                                                     "./ppcmains/ivy/lyncbroker/api"
                                                     "./ppcmains/ivy/management/cdb_plugin_b2buacommand/api"
                                                     "./ppcmains/ivy/management/cdb_plugin_b2buaservice/api"
                                                     "./ppcmains/ivy/mediaprocessors/api"
                                                     "./ppcmains/ivy/mediaprocessors/handler/api"
                                                     "./ppcmains/ivy/mediaprocessors/interface/api"
                                                     "./ppcmains/ivy/mergedrequestsmanager/api"
                                                     "./ppcmains/ivy/mrconfigurator/api"
                                                     "./ppcmains/ivy/peerinfo/api"
                                                     "./ppcmains/ivy/peersearchserver/api"
                                                     "./ppcmains/ivy/poisonstrategy/api"
                                                     "./ppcmains/ivy/proxy/api"
                                                     "./ppcmains/ivy/remoterdp/api"
                                                     "./ppcmains/ivy/routeheaderstrategy/api"
                                                     "./ppcmains/ivy/search/api"
                                                     "./ppcmains/ivy/searchandforward/api"
                                                     "./ppcmains/ivy/semaphore/api"
                                                     "./ppcmains/ivy/sipmsgdsp/api"
                                                     "./ppcmains/ivy/sipregistrationclient/api"
                                                     "./ppcmains/ivy/siptranshandler/api"
                                                     "./ppcmains/ivy/statussync/api"
                                                     "./ppcmains/ivy/threadeddispatcher/api"
                                                     "./ppcmains/ivy/threadeddispatcher/interface/api"
                                                     "./ppcmains/ivy/threadeddispatchertimer/api"
                                                     "./ppcmains/ivy/ticksource/api"
                                                     "./ppcmains/ivy/transactionhandlermap/api"
                                                     "./ppcmains/ivy/transcodermanagerclient/api"
                                                     "./ppcmains/ivy/turnserverpool/api"
                                                     "./ppcmains/licenseman/api"
                                                     "./ppcmains/lincfg/api"
                                                     "./ppcmains/loglevelmonitor/api"
                                                     "./ppcmains/logsetting/api"
                                                     "./ppcmains/media/filtermanagement/api"
                                                     "./ppcmains/mediacaps/api"
                                                     "./ppcmains/mediarouting/api"
                                                     "./ppcmains/mediarouting/mrtest/api"
                                                     "./ppcmains/mimeparser/api"
                                                     "./ppcmains/miscutil/api"
                                                     "./ppcmains/mrapi/api"
                                                     "./ppcmains/oak/_build/oak/stringencoderssupport_sdk.tar/include"
                                                     "./ppcmains/oak/addressing/api"
                                                     "./ppcmains/oak/alias/api"
                                                     "./ppcmains/oak/auth/api"
                                                     "./ppcmains/oak/bandwidth/api"
                                                     "./ppcmains/oak/callidregistry/api"
                                                     "./ppcmains/oak/calls/api"
                                                     "./ppcmains/oak/calls/h323/api"
                                                     "./ppcmains/oak/calls/h323/msg/api"
                                                     "./ppcmains/oak/calls/iwf/api"
                                                     "./ppcmains/oak/calls/responsecode/api"
                                                     "./ppcmains/oak/calls/responsecode/sip/api"
                                                     "./ppcmains/oak/callserialnumber/api"
                                                     "./ppcmains/oak/clouddomain/api"
                                                     "./ppcmains/oak/commandmanager/api"
                                                     "./ppcmains/oak/config_validator/api"
                                                     "./ppcmains/oak/diag/api"
                                                     "./ppcmains/oak/diag/_build/oak/app/api"
                                                     "./ppcmains/oak/dns_resolver/api"
                                                     "./ppcmains/oak/dns_resolver/uri_resolver/api"
                                                     "./ppcmains/oak/domain/api"
                                                     "./ppcmains/oak/edgemanager/api"
                                                     "./ppcmains/oak/extappstatus/api"
                                                     "./ppcmains/oak/interfacebroker/api"
                                                     "./ppcmains/oak/interfacebroker/unittest/api"
                                                     "./ppcmains/oak/license/api"
                                                     "./ppcmains/oak/listener/h323/api"
                                                     "./ppcmains/oak/management/cdb_plugin_call/api"
                                                     "./ppcmains/oak/management/cdb_plugin_edgemanager/api"
                                                     "./ppcmains/oak/management/cdb_plugin_externalmanager/api"
                                                     "./ppcmains/oak/management/cdb_plugin_h323_configuration/api"
                                                     "./ppcmains/oak/management/cdb_plugin_registration/api"
                                                     "./ppcmains/oak/management/cdb_plugin_resourceusage/api"
                                                     "./ppcmains/oak/management/cdb_plugin_sip_configuration/api"
                                                     "./ppcmains/oak/management/cdb_plugin_sipservice/api"
                                                     "./ppcmains/oak/management/cdb_plugin_traversal_configuration/api"
                                                     "./ppcmains/oak/management/cdb_plugin_vcs_configuration/api"
                                                     "./ppcmains/oak/mediasession/api"
                                                     "./ppcmains/oak/misc/api"
                                                     "./ppcmains/oak/netlog/api"
                                                     "./ppcmains/oak/nonce/api"
                                                     "./ppcmains/oak/ntlm/api"
                                                     "./ppcmains/oak/oaktest/api"
                                                     "./ppcmains/oak/objectcontrol/api"
                                                     "./ppcmains/oak/pattern_matching/api"
                                                     "./ppcmains/oak/policy/api"
                                                     "./ppcmains/oak/presence/PUA/api"
                                                     "./ppcmains/oak/presence/Server/api"
                                                     "./ppcmains/oak/registrations/api"
                                                     "./ppcmains/oak/replication/api"
                                                     "./ppcmains/oak/resourceusage/api"
                                                     "./ppcmains/oak/samba_helpers/api"
                                                     "./ppcmains/oak/search/api"
                                                     "./ppcmains/oak/search/history/api"
                                                     "./ppcmains/oak/sipservice/common/api"
                                                     "./ppcmains/oak/sipservice/serviceproxy/api"
                                                     "./ppcmains/oak/sipservice/serviceserver/api"
                                                     "./ppcmains/oak/sourcealiasrewriting/api"
                                                     "./ppcmains/oak/specieset/api"
                                                     "./ppcmains/oak/status/api"
                                                     "./ppcmains/oak/status/debug/api"
                                                     "./ppcmains/oak/status/dumper/api"
                                                     "./ppcmains/oak/status/idmgr/api"
                                                     "./ppcmains/oak/status/infovisitor/api"
                                                     "./ppcmains/oak/status/items/api"
                                                     "./ppcmains/oak/status/logger/api"
                                                     "./ppcmains/oak/status/pathvisitedhandler/api"
                                                     "./ppcmains/oak/status/tree/api"
                                                     "./ppcmains/oak/status/visitor/api"
                                                     "./ppcmains/oak/statussync/api"
                                                     "./ppcmains/oak/testapps/thinclient/api"
                                                     "./ppcmains/oak/transforms/api"
                                                     "./ppcmains/oak/unittest_helpers/api"
                                                     "./ppcmains/oak/userpolicyclient/api"
                                                     "./ppcmains/oak/uuid_wrapper/api"
                                                     "./ppcmains/oak/zones/api"
                                                     "./ppcmains/openssl-taa/api"
                                                     "./ppcmains/optionkey/api"
                                                     "./ppcmains/optionkeymonitor/api"
                                                     "./ppcmains/parsetext/api"
                                                     "./ppcmains/platform/api"
                                                     "./ppcmains/policyruleset/api"
                                                     "./ppcmains/portpool/api"
                                                     "./ppcmains/rdp/api"
                                                     "./ppcmains/readlinecommandcompletion/api"
                                                     "./ppcmains/releasekey/api"
                                                     "./ppcmains/rfc_parsers/EDCS1438945_ms/api"
                                                     "./ppcmains/rfc_parsers/EDCS956684_iX/api"
                                                     "./ppcmains/rfc_parsers/cisco_sdpext/api"
                                                     "./ppcmains/rfc_parsers/ms_sdpext/api"
                                                     "./ppcmains/rfc_parsers/rfc2616/api"
                                                     "./ppcmains/rfc_parsers/rfc2806/api"
                                                     "./ppcmains/rfc_parsers/rfc3261/api"
                                                     "./ppcmains/rfc_parsers/rfc3407/api"
                                                     "./ppcmains/rfc_parsers/rfc3515/api"
                                                     "./ppcmains/rfc_parsers/rfc3605/api"
                                                     "./ppcmains/rfc_parsers/rfc3890/api"
                                                     "./ppcmains/rfc_parsers/rfc3891/api"
                                                     "./ppcmains/rfc_parsers/rfc3986/api"
                                                     "./ppcmains/rfc_parsers/rfc4145/api"
                                                     "./ppcmains/rfc_parsers/rfc4566/api"
                                                     "./ppcmains/rfc_parsers/rfc4566/tests/api"
                                                     "./ppcmains/rfc_parsers/rfc4568/api"
                                                     "./ppcmains/rfc_parsers/rfc4572/api"
                                                     "./ppcmains/rfc_parsers/rfc4574/api"
                                                     "./ppcmains/rfc_parsers/rfc4583/api"
                                                     "./ppcmains/rfc_parsers/rfc4585_rtcpfb/api"
                                                     "./ppcmains/rfc_parsers/rfc4796/api"
                                                     "./ppcmains/rfc_parsers/rfc5104_ramsupdates/api"
                                                     "./ppcmains/rfc_parsers/rfc5245/api"
                                                     "./ppcmains/rfc_parsers/rfc5245/tests/api"
                                                     "./ppcmains/rfc_parsers/rfc5285/api"
                                                     "./ppcmains/rfc_parsers/rfc5506/api"
                                                     "./ppcmains/rfc_parsers/rfc5761/api"
                                                     "./ppcmains/rfc_parsers/rfc5888_mid/api"
                                                     "./ppcmains/rfc_parsers/rfc_helpers/api"
                                                     "./ppcmains/rshell/api"
                                                     "./ppcmains/rtcp/api"
                                                     "./ppcmains/rtp/api"
                                                     "./ppcmains/rtp/srtp/api"
                                                     "./ppcmains/sdpmsg/api"
                                                     "./ppcmains/serialno/api"
                                                     "./ppcmains/sip/api"
                                                     "./ppcmains/sip/assentparsing/api"
                                                     "./ppcmains/sip/bfcplogmanager/api"
                                                     "./ppcmains/sip/icelib/api"
                                                     "./ppcmains/sip/icelibtypes/api"
                                                     "./ppcmains/sip/offeranswer/api"
                                                     "./ppcmains/sip/sdpsrtpencryption/api"
                                                     "./ppcmains/sip/sipidentity/signature/api"
                                                     "./ppcmains/sip/sipidentity/sipmsg++/api"
                                                     "./ppcmains/sip/sipoutbound/api"
                                                     "./ppcmains/sip/sipproxy/_build/oak/app"
                                                     "./ppcmains/sip/sipproxy/api"
                                                     "./ppcmains/sip/siptraversal/api"
                                                     "./ppcmains/sip/siptraversal/siptravtest/api"
                                                     "./ppcmains/sip/siptrlay/api"
                                                     "./ppcmains/sip/siptrnsp/api"
                                                     "./ppcmains/sipmedialib/api"
                                                     "./ppcmains/sipmsg++/api"
                                                     "./ppcmains/sipmsg/_build/ivy/ivy/api"
                                                     "./ppcmains/sipmsg/api"
                                                     "./ppcmains/softwarestring/api"
                                                     "./ppcmains/statsdclient/api"
                                                     "./ppcmains/stun/api"
                                                     "./ppcmains/sysadm/api"
                                                     "./ppcmains/sysadm/sysadmoak"
                                                     "./ppcmains/timerlist/api"
                                                     "./ppcmains/ttbignum/api"
                                                     "./ppcmains/winbindservice/api"
                                                     "./ppcmains/xacli/api"
                                                     "./ppcmains/xml/api"
                                                     "./ppcmains/xmlappl/api"
                                                     "./product/ivy/inc"
                                                     "./product/oak/status/api"
                                                     "./product/xcp-vcs/xcp/src/third_party/jload3/doc/api"
                                                     )
                              :compile-command "cd Debug && build/bld -t oak -j 100 --distcc"
                              )))

;; Setup JAVA....
;(require 'semantic/db-javap)

;; example of java-root project

;; (ede-ant-project "Lucene" 
;; 		       :file "~/work/lucene-solr/lucene-4.0.0/build.xml"
;; 		       :srcroot '("core/src")
;; 		       :classpath (cedet-files-list-recursively "~/work/lucene-solr/lucene-4.0.0/" ".*\.jar$")
;; 		       )
