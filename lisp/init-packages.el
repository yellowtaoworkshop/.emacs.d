;;  __        __             __   ___
;; |__)  /\  /  ` |__/  /\  / _` |__
;; |    /~~\ \__, |  \ /~~\ \__> |___
;;                      __   ___        ___      ___
;; |\/|  /\  |\ |  /\  / _` |__   |\/| |__  |\ |  |
;; |  | /~~\ | \| /~~\ \__> |___  |  | |___ | \|  |


(when (>= emacs-major-version 24)
    (require 'package)
    (package-initialize)
    (setq package-archives '(
			     ("melpa-stable" . "https://stable.melpa.org/packages/")
			     ("melpa" . "https://melpa.org/packages/")
			     ("gnu" . "https://elpa.gnu.org/packages/"))))

(setq package-check-signature nil)

(require 'cl-lib)

;; ...
(defvar gavin/packages '(
			company
			hungry-delete
			undo-tree
			smooth-scrolling
			popup
			org-beautify-theme
			org
			goto-chg
			async
			ivy
			swiper
			counsel
			smex 
      smartparens
			popwin
			highlight-parentheses
			highlight-numbers
			expand-region
			yasnippet
			use-package
			diminish
			org-bullets
      winum
      hl-todo
      doom-modeline
			) "default package")

(setq package-selected-packages gavin/packages)

(defun gavin/package-installed-p ()
  (cl-loop for pkg in gavin/packages
	when (not (package-installed-p pkg)) do (cl-return nil)
	finally (cl-return t)))

(unless (gavin/package-installed-p)
  (message "Refreshing package database..")
  (package-refresh-contents)
  (dolist (pkg gavin/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

(use-package smooth-scrolling
  :ensure t
  :init
  (setq smooth-scroll-margin 3)
  :hook ((after-init . smooth-scrolling-mode)))

;;
(use-package highlight-parentheses
  :ensure t
  :hook ((after-init . highlight-parentheses-mode)))

;;
(use-package highlight-numbers
  :ensure t
  :hook ((prog-mode . highlight-numbers-mode)))

(use-package hungry-delete
  :ensure t
  :hook ((after-init . global-hungry-delete-mode)))

(use-package verilog-mode
  :ensure t) 

;;turn on auto complete 
(use-package company
  :ensure t
  :config
  (global-company-mode 1)
  ;; let company support verilog 
  (add-to-list 'company-keywords-alist (cons 'verilog-mode verilog-keywords)))

;; smartparens enable
(use-package smartparens
  :ensure t
  :config
  (smartparens-global-strict-mode t)
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
  (sp-local-pair 'verilog-mode    "'" nil :actions nil)
  (sp-local-pair 'verilog-mode    "`" nil :actions nil))

(use-package highlight-parentheses
  :ensure t
  :config
  (global-highlight-parentheses-mode t))

;; popwin enable
(use-package popwin
  :ensure t
  :config
  (popwin-mode t)
  (push '("*undo-tree*" :width 0.3 :position bottom) popwin:special-display-config))

(use-package yasnippet
  :ensure t
  :hook ((prog-mode . yas-global-mode)
         )
  )

(use-package undo-tree
  :ensure t
  :hook ((after-init . global-undo-tree-mode))
  :config
  (setq undo-tree-visualizer-diff t)
  (setq undo-tree-visualizer-timestamps t))

(use-package markdown-mode 
  :ensure t
  :defer t
  :config
  (setq markdown-fontify-code-blocks-natively t))

(use-package expand-region
  :ensure t)

(use-package hl-todo
  :ensure t
  :hook ((prog-mode . hl-todo-mode)
         (yaml-mode . hl-todo-mode))
  )

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq inhibit-compacting-font-caches t))

(use-package nerd-icons
  :ensure t)

(use-package nerd-icons-dired
  :ensure t
  :hook ((dired-mode . nerd-icons-dired-mode)))

(use-package nerd-icons-ibuffer
  :ensure t
  :hook ((ibuffer-mode . nerd-icons-ibuffer-mode)))

(use-package nerd-icons-completion
  :ensure t
  :hook ((company-mode . nerd-icons-completion-mode)))

;;(use-package nerd-icons-ivy
;;  :ensure t
;;  :hook ((after-init . nerd-icons-ivy-setup)))

(use-package nerd-icons-ivy-rich
  :ensure t
  :hook ((ivy-mode . nerd-icons-ivy-rich-mode))
  )

(use-package ivy-rich
  :ensure t
  :hook (nerd-icons-ivy-rich-mode . ivy-rich-mode))

;;
(use-package ivy
  :hook ((after-init . ivy-mode))
  :config
  (setq ivy-use-virtual-buffers t
        ivy-count-format "%d/%d "))

;;
(use-package vterm
  :ensure t
  :defer t)

(use-package vterm-toggle
  :ensure t
  :defer t)

(provide 'init-packages)
