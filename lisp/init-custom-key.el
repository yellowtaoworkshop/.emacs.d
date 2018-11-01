
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


;; for swiper blinding key
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)


;; set recent file list bind ket to C-x C-r
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
(provide 'init-custom-key)
