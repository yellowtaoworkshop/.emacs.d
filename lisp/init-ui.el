
;; set the cursor type to bar
(setq-default cursor-type 'bar)

;(require 'spaceline-config)
;(setq spaceline-window-numbers-unicode nil)
;(setq spaceline-workspace-numbers-unicode nil)
;(spaceline-emacs-theme)

;; hilight the current line
(global-hl-line-mode -1)

;; turn off the tool bar
(tool-bar-mode -1)

;(add-hook 'verilog-mode-hook #'tree-sitter-mode)
;(add-hook 'verilog-mode-hook #'tree-sitter-hl-mode)

;(set-background-color "#C7EDCC")


(if (display-graphic-p)
    (condition-case nil
        (load-theme 'moe-light t)
      (error nil))
  (menu-bar-mode 0))

(provide 'init-ui)
