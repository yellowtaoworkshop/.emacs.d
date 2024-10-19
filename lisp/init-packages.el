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
      vterm
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
  :defer t
  :ensure t
  :after
  (company-keywords)
  :config
  (add-to-list 'company-keywords-alist (cons 'verilog-mode verilog-keywords)))

;;turn on auto complete 
(use-package company
  :ensure t
  :hook
  (prog-mode . company-mode)
    ;; let company support verilog
  ;;:config
  ;;(add-to-list 'company-keywords-alist (cons 'verilog-mode verilog-keywords))
  )

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
  ;;(push '("*undo-tree*" :width 0.3 :position bottom) popwin:special-display-config)
  )

(use-package yasnippet
  :ensure t
  :hook ((prog-mode . yas-global-mode)
         )
  )

(use-package undo-tree
  :ensure t
  :hook ((after-init . global-undo-tree-mode))
  :config
  ;;(setq undo-tree-visualizer-diff t)
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

(use-package all-the-icons
  :ensure t)

(use-package all-the-icons-dired
  :ensure t
  :hook ((dired-mode . all-the-icons-dired-mode)))

(use-package all-the-icons-ibuffer
  :ensure t
  :hook ((ibuffer-mode . all-the-icons-ibuffer-mode)))

(use-package all-the-icons-completion
  :ensure t
  :hook ((company-mode . all-the-icons-completion-mode)))

(use-package all-the-icons-ivy
  :ensure t
  :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup))

;;(use-package all-the-icons-ivy-rich
;;  :ensure t
;;  :hook ((ivy-mode . all-the-icons-ivy-rich-mode))
;;  )

;;(use-package ivy-rich
;;  :ensure t
;;  :hook (ivy-mode . ivy-rich-mode)
;;  )

;;
(use-package ivy
  :hook ((after-init . ivy-mode))
  :config
  (setq ivy-use-virtual-buffers t
        ivy-count-format "%d/%d "))

(use-package projectile
  :ensure t
  :init (projectile-mode 1))

;(use-package lsp-mode
;  :init
;  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
;  (setq lsp-keymap-prefix "C-c l")
;  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
;         (verilog-mode . lsp)
;         ;; if you want which-key integration
;         (lsp-mode . lsp-enable-which-key-integration))
;  :commands lsp)
;
;; if you are ivy user
;(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;(use-package lsp-treemacs :commands lsp-treemacs-errors-list)
;(use-package lsp-ui :commands lsp-ui-mode)
;
;
;(require 'lsp-verilog)
;
;(custom-set-variables
;  '(lsp-clients-svlangserver-launchConfiguration "/global/apps/vcs_2021.09-SP2/bin/vlogan -sverilog +lint +warn")
;  ;'(lsp-clients-svlangserver-formatCommand "/tools/verible-verilog-format")
;  )

;(add-hook 'verilog-mode-hook #'lsp-deferred)
(use-package p4
  :ensure t)

(use-package vterm
  :defer t
  :ensure t)

(use-package vterm-toggle
  :defer t
  :ensure t)

;;(use-package verilog-ext
;;  :after verilog-mode
;;  :demand
;;  :hook ((verilog-mode . verilog-ext-mode))
;;  :init
;;   ;; Can also be set through `M-x RET customize-group RET verilog-ext':
;;   ;;  - Verilog Ext Feature List (provides info of different features)
;;   ;; Comment out/remove the ones you do not need
;;  (setq verilog-ext-feature-list
;;        '(font-lock
;;          xref
;;          capf
;;          hierarchy
;;          eglot
;;          lsp
;;          flycheck
;;          beautify
;;          navigation
;;          template
;;          formatter
;;          compilation
;;          imenu
;;          which-func
;;          hideshow
;;          typedefs
;;          time-stamp
;;          block-end-comments
;;          company-keywords
;;          ports))
;;  :config
;;  (verilog-ext-mode-setup))

(provide 'init-packages)
