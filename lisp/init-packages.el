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
    company
    vundo
    ;;diminish
    ;;doom-modeline
    expand-region
    goto-chg
    highlight-numbers
    highlight-parentheses
    hl-todo
    ;;hungry-delete
    markdown-mode
    moe-theme
    org
    org-beautify-theme
    org-bullets
    popup
    popwin
    projectile
    smartparens
    vterm
    vterm-toggle
    winum
    gcmh
    magit
    orderless
    consult
    vertico
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
(use-package smartparens
  :defer t
  :hook (prog-mode text-mode markdown-mode)
  :ensure t
  :config
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
  (sp-local-pair 'verilog-mode    "'" nil :actions nil)
  (sp-local-pair 'verilog-mode    "`" nil :actions nil))

;; popwin enable
(use-package popwin
  :hook (emacs-startup . popwin-mode))

(use-package yasnippet
  :config
  (yas-reload-all)
  :hook (prog-mode . yas-minor-mode))

(use-package vundo
  :bind ("C-x u" . vundo)
  :defer t
  :config
  (setq vundo-glyph-alist vundo-unicode-symbols))

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
(use-package nerd-icons-mode-line
  :ensure t
  :vc (:url "https://github.com/grolongo/nerd-icons-mode-line")
  :custom
  (nerd-icons-mode-line-v-adjust 0.1) ; default value
  (nerd-icons-mode-line-size 1.0) ; default value
  :hook (emacs-startup . nerd-icons-mode-line-global-mode))

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

;;(use-package ivy
;;  :hook (emacs-startup . ivy-mode)
;;  :config
;;  (setq ivy-use-virtual-buffers t
;;        ivy-count-format "%d/%d "))

;; Enable Vertico.
(use-package vertico
  ;;:custom
  ;; (vertico-scroll-margin 0) ;; Different scroll margin
  ;; (vertico-count 20) ;; Show more candidates
  ;; (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  ;; (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  ;;:init
  :hook (emacs-startup . vertico-mode))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

(use-package orderless
  :ensure t
  :demand t
  :config
  (defun +orderless--consult-suffix ()
    "Regexp which matches the end of string with Consult tofu support."
    (if (boundp 'consult--tofu-regexp)
        (concat consult--tofu-regexp "*\\'")
      "\\'"))
  ;; Recognizes the following patterns:
  ;; * .ext (file extension)
  ;; * regexp$ (regexp matching at end)
  (defun +orderless-consult-dispatch (word _index _total)
    (cond
     ;; Ensure that $ works with Consult commands, which add disambiguation suffixes
     ((string-suffix-p "$" word)
      `(orderless-regexp . ,(concat (substring word 0 -1) (+orderless--consult-suffix))))
     ;; File extensions
     ((and (or minibuffer-completing-file-name
               (derived-mode-p 'eshell-mode))
           (string-match-p "\\`\\.." word))
      `(orderless-regexp . ,(concat "\\." (substring word 1) (+orderless--consult-suffix))))))

  ;; Define orderless style with initialism by default
  (orderless-define-completion-style +orderless-with-initialism
    (orderless-matching-styles '(orderless-initialism orderless-literal orderless-regexp)))

  ;; Certain dynamic completion tables (completion-table-dynamic) do not work
  ;; properly with orderless. One can add basic as a fallback.  Basic will only
  ;; be used when orderless fails, which happens only for these special
  ;; tables. Also note that you may want to configure special styles for special
  ;; completion categories, e.g., partial-completion for files.
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        ;;; Enable partial-completion for files.
        ;;; Either give orderless precedence or partial-completion.
        ;;; Note that completion-category-overrides is not really an override,
        ;;; but rather prepended to the default completion-styles.
        ;; completion-category-overrides '((file (styles orderless partial-completion))) ;; orderless is tried first
        completion-category-overrides '((file (styles partial-completion)) ;; partial-completion is tried first
                                        ;; enable initialism by default for symbols
                                        (command (styles +orderless-with-initialism))
                                        (variable (styles +orderless-with-initialism))
                                        (symbol (styles +orderless-with-initialism)))
        orderless-component-separator #'orderless-escapable-split-on-space ;; allow escaping space with backslash!
        orderless-style-dispatchers (list #'+orderless-consult-dispatch
                                          #'orderless-kwd-dispatch
                                          #'orderless-affix-dispatch)))
;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  ;; The :init section is always executed.
  :init
  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))

;; Example configuration for Consult
(use-package consult
  ;; Replace bindings. Lazily loaded by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g r" . consult-grep-match)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)                  ;; Alternative: consult-fd
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))
  ;; The :init configuration is always executed (Not lazy)
  :init
  ;; Tweak the register preview for `consult-register-load',
  ;; `consult-register-store' and the built-in commands.  This improves the
  ;; register formatting, adds thin separator lines, register sorting and hides
  ;; the window mode line.
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep consult-man
   consult-bookmark consult-recent-file consult-xref
   consult-source-bookmark consult-source-file-register
   consult-source-recent-file consult-source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (keymap-set consult-narrow-map (concat consult-narrow-key " ?") #'consult-narrow-help)
)

(use-package projectile
  :defer 2
  :config
  (projectile-mode 1))

(use-package winum
  :hook (emacs-startup . winum-mode)
  :config
  (setq winum-auto-setup-mode-line t))

(use-package p4
  :vc (:url  "https://github.com/JohnC32/perforce-emacs")
  :after prog-mode
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

(use-package gcmh
  :ensure t
  :hook (emacs-startup . gcmh-mode)
  :config
  (setq gcmh-idle-delay 1))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-c M-g" . magit-dispatch-popup)))

(use-package consult-yasnippet
  :ensure t
  :after yas-minor-mode)

(provide 'init-packages)
