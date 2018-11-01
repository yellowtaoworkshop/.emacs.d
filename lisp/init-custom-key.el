;; reset windows manager key
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-below)
(global-set-key (kbd "M-3") 'split-window-right)

;; realize C-a/C-x in vim
(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(define-key evil-visual-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)

(define-key evil-normal-state-map (kbd "C-b") 'evil-numbers/dec-at-pt)
(define-key evil-visual-state-map (kbd "C-b") 'evil-numbers/dec-at-pt)


;; for helm blinding key
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)


;; set recent file list bind ket to C-x C-r
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
(provide 'init-custom-key)
