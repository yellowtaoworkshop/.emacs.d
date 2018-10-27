
;; bound f2 to open init.el
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "<f2>") 'open-my-init-file)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path "~/.emacs.d/lisp/theme/")
(add-to-list 'load-path "~/.emacs.d/lisp/theme/powerline")
(add-to-list 'custom-theme-load-path "~/.emacs.d/lisp/theme/")

;; set coustm.el file path
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Package Management
(require 'init-packages)

;;Evil mode
(require 'evil)
(evil-mode 0)

;; load evil plugin
(require 'evil-numbers)

(require 'evil-surround)
(global-evil-surround-mode 1)


(require 'evil-matchit)
(global-evil-matchit-mode 1)

;;
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)
(setq smooth-scroll-margin 3)
;;
;;(require 'molokai-theme-kit)
(require 'powerline)
(powerline-evil-theme)

;;
(require 'init-custom-key)

;;
(require 'helm-config)
(helm-mode 1)

(require 'org)
(setq org-src-fontify-natively t)

(require 'hungry-delete)
(global-hungry-delete-mode 1)

;;turn on auto complete 
(global-company-mode 1)



(require 'recentf)
(recentf-mode 1)
(setq recentf-ma-menu-items 25)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

(require 'smartparens-config)
(smartparens-global-mode t)


(delete-selection-mode 1)

(global-hl-line-mode 1)
