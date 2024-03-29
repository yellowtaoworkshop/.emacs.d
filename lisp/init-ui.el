
;; set the cursor type to bar
(setq-default cursor-type 'bar)

;(require 'spaceline-config)
;(setq spaceline-window-numbers-unicode nil)
;(setq spaceline-workspace-numbers-unicode nil)
;(spaceline-emacs-theme)

;; hilight the current line
(global-hl-line-mode nil)

;; turn off the tool bar
(tool-bar-mode -1)

(require 'winum)
(setq winum-auto-setup-mode-line t)
(winum-mode)

(require 'diminish)
(diminish 'eldoc-mode)
(diminish 'undo-tree-mode)
(diminish 'helm-mode)
(diminish 'company-mode "ac")
(diminish 'smartparens-mode "sp")

;(add-hook 'verilog-mode-hook #'tree-sitter-mode)
;(add-hook 'verilog-mode-hook #'tree-sitter-hl-mode)

;(set-background-color "#C7EDCC")

;;
(provide 'init-ui)
