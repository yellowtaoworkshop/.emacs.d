;; reset windows manager key
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-below)
(global-set-key (kbd "M-3") 'split-window-right)

;; realize C-a/C-x in vim
(with-eval-after-load 'evil-numbers
  (define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
  (define-key evil-visual-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-b") 'evil-numbers/dec-at-pt)
  (define-key evil-visual-state-map (kbd "C-b") 'evil-numbers/dec-at-pt))


;; for helm blinding key
(with-eval-after-load 'helm
  (global-set-key (kbd "M-x") #'helm-M-x)
  (global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
  (global-set-key (kbd "C-x C-f") #'helm-find-files)
  (global-set-key (kbd "C-x b") #'helm-buffers-list)
  (with-eval-after-load 'helm-swoop
    ;; Change the keybinds to whatever you like :)
    (global-set-key (kbd "M-s") 'helm-swoop)
    (global-set-key (kbd "M-S") 'helm-swoop-back-to-last-point)
    (global-set-key (kbd "C-c M-s") 'helm-multi-swoop)
    (global-set-key (kbd "C-x M-s") 'helm-multi-swoop-all)
    ;; When doing isearch, hand the word over to helm-swoop
    (define-key isearch-mode-map (kbd "M-s") 'helm-swoop-from-isearch)
    ;; From helm-swoop to helm-multi-swoop-all
    (define-key helm-swoop-map (kbd "M-s") 'helm-multi-swoop-all-from-helm-swoop)
    ;; When doing evil-search, hand the word over to helm-swoop
    ;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)
    ;; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode
    (define-key helm-swoop-map (kbd "M-m") 'helm-multi-swoop-current-mode-from-helm-swoop)
    ;; Move up and down like isearch
    (define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
    (define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
    (define-key helm-multi-swoop-map (kbd "C-r") 'helm-previous-line)
    (define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)))


(with-eval-after-load 'company
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil))


;; set recent file list bind ket to C-x C-r
(with-eval-after-load 'recentf
  (global-set-key (kbd "C-x C-r") 'recentf-open-files))

(with-eval-after-load 'expand-region
  (global-set-key (kbd "C-=") 'er/expand-region))

(with-eval-after-load 'yasnippet
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  (define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand))

(provide 'init-custom-key)
