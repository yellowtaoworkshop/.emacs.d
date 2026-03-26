;;  __        __             __   ___
;; |__)  /\  /  ` |__/  /\  / _` |__
;; |    /~~\ \__, |  \ /~~\ \__> |___
;;                      __   ___        ___      ___
;; |\/|  /\  |\ |  /\  / _` |__   |\/| |__  |\ |  |
;; |  | /~~\ | \| /~~\ \__> |___  |  | |___ | \|  |


(when (>= emacs-major-version 24)
  (require 'package)
  (setq package-archives '(("melpa-stable" . "https://stable.melpa.org/packages/")
                           ("melpa" . "https://melpa.org/packages/")
                           ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize))

(setq package-check-signature nil)

(require 'cl-lib)

;; ...
(defvar gavin/packages
  '(nerd-icons
    nerd-icons-dired
    nerd-icons-ibuffer
    ;;nerd-icons-ivy-rich
    async
    company
    counsel
    ;;diminish
    ;;doom-modeline
    expand-region
    goto-chg
    highlight-numbers
    highlight-parentheses
    hl-todo
    ;;hungry-delete
    ivy
    ;;ivy-rich
    markdown-mode
    moe-theme
    org
    org-beautify-theme
    org-bullets
    p4
    popup
    popwin
    projectile
    smartparens
    smex
    swiper
    undo-tree
    use-package
    vterm
    vterm-toggle
    winum
    yasnippet)
  "Packages installed by `gavin/bootstrap-packages'.")

(defun gavin/bootstrap-packages ()
  "Install packages listed in `gavin/packages'."
  (interactive)
  (let ((missing-packages (cl-remove-if #'package-installed-p gavin/packages)))
    (if (null missing-packages)
        (message "All configured packages are already installed.")
      (message "Refreshing package database...")
      (package-refresh-contents)
      (dolist (pkg missing-packages)
        (message "Installing %s..." pkg)
        (package-install pkg))
      (message "Bootstrap complete. Restart Emacs to load new packages."))))

(unless (require 'use-package nil t)
  (defmacro use-package (&rest _args) nil)
  (message "Package setup skipped. Run M-x gavin/bootstrap-packages to install dependencies."))

(setq use-package-always-ensure t
      use-package-expand-minimally t
      use-package-verbose nil)

(use-package highlight-parentheses
  :hook ((prog-mode . highlight-parentheses-mode)
         (emacs-lisp-mode . highlight-parentheses-mode)))

(use-package highlight-numbers
  :hook (prog-mode . highlight-numbers-mode))

;;(use-package hungry-delete
;;  :hook (emacs-startup . global-hungry-delete-mode))

(use-package verilog-mode
  :defer t
  :ensure t
  :after
  (company-keywords)
  :config
  (add-to-list 'company-keywords-alist (cons 'verilog-mode verilog-keywords)))

;;turn on auto complete 
(use-package company
  :init
  (setq company-idle-delay 0.8
        company-minimum-prefix-length 3
        company-files-exclusions '(".git/" ".svn/" ".hg/")
        company-backends '((company-capf company-keywords company-dabbrev-code)))
  :hook
  (prog-mode . company-mode))

;; smartparens enable
;;(use-package smartparens
;;  :hook (emacs-startup . smartparens-global-strict-mode)
;;  :config
;;  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
;;  (sp-local-pair 'verilog-mode    "'" nil :actions nil)
;;  (sp-local-pair 'verilog-mode    "`" nil :actions nil))

;; popwin enable
(use-package popwin
  :hook (emacs-startup . popwin-mode))

(use-package yasnippet
  :hook (emacs-startup . yas-global-mode))

(use-package undo-tree
  :hook (emacs-startup . global-undo-tree-mode)
  :config
  (setq undo-tree-visualizer-timestamps t))

(use-package markdown-mode 
  :defer t
  :config
  (setq markdown-fontify-code-blocks-natively t))

(use-package expand-region
  :defer t
  :commands er/expand-region)

(use-package hl-todo
  :hook ((prog-mode . hl-todo-mode)
         (yaml-mode . hl-todo-mode)))

;;(use-package doom-modeline
;;  :hook (emacs-startup . doom-modeline-mode)
;;  :config
;;  (setq inhibit-compacting-font-caches t))
;;(use-package nerd-icons-mode-line
;;  :ensure t
;;;;:vc (:url "https://github.com/grolongo/nerd-icons-mode-line")
;;  :custom
;;  (nerd-icons-mode-line-v-adjust 0.1) ; default value
;;  (nerd-icons-mode-line-size 1.0) ; default value
;;  :hook (emacs-startup . nerd-icons-mode-line-global-mode))

(use-package nerd-icons
  :defer t
  :custom
  (nerd-icons-font-family "JetBrainsMono Nerd Font Mono"))

(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

;;(use-package nerd-icons-completion
;;  :defer t
;;  :config (nerd-icons-completion-mode))

;;(use-package nerd-icons-ivy-rich
;;  :defer t
;;  :hook (emacs-startup . nerd-icons-ivy-rich-mode))
;;
;;(use-package ivy-rich
;;  :hook (emacs-startup . ivy-rich-mode))

(use-package ivy
  :hook (emacs-startup . ivy-mode)
  :config
  (setq ivy-use-virtual-buffers t
        ivy-count-format "%d/%d "))

(use-package projectile
  :defer 2
  :config
  (projectile-mode 1))

;;(use-package diminish
;;  :defer 1
;;  :config
;;  (with-eval-after-load 'eldoc
;;    (diminish 'eldoc-mode))
;;  (with-eval-after-load 'undo-tree
;;    (diminish 'undo-tree-mode))
;;  (with-eval-after-load 'company
;;    (diminish 'company-mode "ac"))
;;  (with-eval-after-load 'smartparens
;;    (diminish 'smartparens-mode "sp")))

(use-package winum
  :hook (emacs-startup . winum-mode)
  :config
  (setq winum-auto-setup-mode-line t))

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
  :defer t
  )

(use-package vterm
  :defer t
  )

(use-package vterm-toggle
  :defer t
  )

(use-package verilog-ext
  :hook ((verilog-mode . verilog-ext-mode))
  :init
   ;; Can also be set through `M-x RET customize-group RET verilog-ext':
   ;;  - Verilog Ext Feature List (provides info of different features)
   ;; Comment out/remove the ones you do not need
  (setq verilog-ext-feature-list
        '(font-lock
          xref
          capf
          hierarchy
          eglot
          lsp
          flycheck
          beautify
          navigation
          template
          formatter
          compilation
          imenu
          which-func
          hideshow
          typedefs
          time-stamp
          block-end-comments
          company-keywords
          ports))
  :config
  (verilog-ext-mode-setup))

(provide 'init-packages)
