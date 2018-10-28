
;; set the cursor type to bar
(setq-default cursor-type 'bar)

;; powerline mode-line
(require 'powerline)
(powerline-evil-theme)

;; hilight the current line
(global-hl-line-mode 1)

;;
(provide 'init-ui)
