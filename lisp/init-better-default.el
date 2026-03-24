
;; turn off the auto save
(setq auto-save-defaults nil)

;; turn off the backup
(setq make-backup-files nil)

;;
(setq recentf-max-menu-items 25)
(add-hook 'emacs-startup-hook
          (lambda ()
            (recentf-mode 1)))

;; make the selection part can be deleted when insert
(delete-selection-mode 1)

(add-hook 'before-save-hook 'time-stamp)

(add-hook 'emacs-startup-hook 'global-auto-revert-mode)

;;
(provide 'init-better-default)
