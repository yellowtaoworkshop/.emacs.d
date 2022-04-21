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
			     ("melpa-stable" . "http://mirrors.163.com/elpa/melpa-stable/")
			     ("melpa" . "http://mirrors.163.com/elpa/melpa/")
			     ("gnu" . "http://mirrors.163.com/elpa/gnu/"))))

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

(require 'smooth-scrolling)
(smooth-scrolling-mode 1)
(setq smooth-scroll-margin 3)

;;
(require 'highlight-parentheses)
(highlight-parentheses-mode t)

;;
(require 'highlight-numbers)
(highlight-numbers-mode t)



;; make syntax hilight in org file 
;;(require 'org)
(setq org-src-fontify-natively t)

(require 'hungry-delete)
(global-hungry-delete-mode 1)

;;turn on auto complete 
(require 'company)
(global-company-mode 1)
(require 'verilog-mode)
;; let company support verilog 
(add-to-list 'company-keywords-alist (cons 'verilog-mode verilog-keywords))
;;(ac-config-default)

;; smartparens enable
(smartparens-global-strict-mode t)
(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
(sp-local-pair 'verilog-mode    "'" nil :actions nil)
(sp-local-pair 'verilog-mode    "`" nil :actions nil)

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

(yas-global-mode 1)

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode t)
  (setq undo-tree-visualizer-diff t)
  (setq undo-tree-visualizer-timestamps t))

(use-package markdown-mode 
  :ensure t
  :config
  (setq markdown-fontify-code-blocks-natively t))

;;(add-to-list 'load-path "~/.emacs.d/elpa/livdedown-20190316.2016/")
;(require 'livedown)

(use-package expand-region
  :ensure t)

(use-package hl-todo
  :ensure t
  :hook ((prog-mode . hl-todo-mode)
         (yaml-mode . hl-todo-mode)))

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq inhibit-compacting-font-caches t))
;(use-package tree-sitter
;  :ensure t)

;(use-package tree-sitter-langs
;  :ensure t)

(use-package all-the-icons
  :ensure t)

(use-package all-the-icons-dired
  :ensure t
  :hook ((dired-mode . all-the-icons-dired-mode)))

(use-package all-the-icons-ibuffer
  :ensure t
  :init (all-the-icons-ibuffer-mode t))

(use-package all-the-icons-completion
  :ensure t
  :init (all-the-icons-completion-mode t))

(use-package all-the-icons-ivy
  :ensure t
  :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup))

(use-package all-the-icons-ivy-rich
  :ensure t
  ;;  :init (all-the-icons-ivy-rich-mode t)
  )

(use-package ivy-rich
  :ensure t
  ;;  :init (ivy-rich-mode t)
  )

;;
(use-package ivy
  :config
  (setq ivy-use-virtual-buffers t
        ivy-count-format "%d/%d "))

(provide 'init-packages)

