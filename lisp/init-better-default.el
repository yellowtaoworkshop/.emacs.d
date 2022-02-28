
;; turn off the auto save
(setq auto-save-defaults nil)

;; turn off the backup
(setq make-backup-files nil)

;;
(require 'recentf)
(recentf-mode 1)
(setq recentf-ma-menu-items 25)

;; make the selection part can be deleted when insert
(delete-selection-mode 1)

(add-hook 'before-save-hook 'time-stamp)

(global-auto-revert-mode 1)

;;
(provide 'init-better-default)
