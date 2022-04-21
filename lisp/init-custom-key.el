;; reset windows manager key
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-below)
(global-set-key (kbd "M-3") 'split-window-right)

;; realize C-a/C-x in vim
;;(with-eval-after-load 'evil-numbers
;;  (define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
;;  (define-key evil-visual-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
;;  (define-key evil-normal-state-map (kbd "C-b") 'evil-numbers/dec-at-pt)
;;  (define-key evil-visual-state-map (kbd "C-b") 'evil-numbers/dec-at-pt))


;; for helm blinding key
(with-eval-after-load 'ivy 
  (global-set-key (kbd "M-x") #'counsel-M-x)
  (global-set-key (kbd "C-x C-f") #'counsel-find-file)
  (global-set-key (kbd "C-x b") #'counsel-switch-buffer)
  (global-set-key (kbd "C-h f") #'counsel-describe-function)
  (global-set-key (kbd "C-h v") #'counsel-describe-variable)
  (with-eval-after-load 'swiper 
    ;; Change the keybinds to whatever you like :)
    (global-set-key (kbd "M-s") 'swiper)
    (global-set-key (kbd "C-c M-s") 'swiper-multi)
    (global-set-key (kbd "C-x M-s") 'swiper-all)
    ;; When doing isearch, hand the word over to helm-swoop
    (define-key isearch-mode-map (kbd "M-s") 'swiper-from-isearch)
    ;; From helm-swoop to helm-multi-swoop-all
    ))


(with-eval-after-load 'company
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil))


;; set recent file list bind ket to C-x C-r
(with-eval-after-load 'recentf
  (global-set-key (kbd "C-x C-r") 'counsel-recentf))

(with-eval-after-load 'expand-region
  (global-set-key (kbd "C-=") 'er/expand-region))

(with-eval-after-load 'yasnippet
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  (define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand))

;;org-mode key binding
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

;;buffer management
(global-set-key (kbd "C-x C-b") 'ibuffer)

(provide 'init-custom-key)
