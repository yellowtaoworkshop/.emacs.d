
;; Emacs minibuffer configurations. so that we can enable the vertico
(use-package emacs
  :custom
  ;; Enable context menu. `vertico-multiform-mode' adds a menu in the minibuffer
  ;; to switch display modes.
  (context-menu-mode t)
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Do not allow the cursor in the minibuffer prompt
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))

;; turn off the auto save
(setq auto-save-defaults nil)

;; turn off the backup
(setq make-backup-files nil)

;;
(setq recentf-max-menu-items 50)
(setq recentf-auto-cleanup 'never)
(setq recentf-exclude '("/tmp/" "/slowfs" "/ssh:" "/sudo:" 'file-remote-p))
(add-hook 'emacs-startup-hook
          (lambda ()
            (recentf-mode 1)))

;; Speed up file opening by preventing synchronous VC (Git) checks
(setq vc-handled-backends nil)

;; make the selection part can be deleted when insert
(delete-selection-mode 1)

(add-hook 'before-save-hook 'time-stamp)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq auto-revert-avoid-polling t)
            (setq auto-revert-verbose nil)
            (global-auto-revert-mode 1)))

;;
(provide 'init-better-default)
