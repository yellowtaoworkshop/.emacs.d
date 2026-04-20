
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


(defun gavin/graphic-sensitive-cfg (frame)
  (with-selected-frame frame 
    (if (display-graphic-p)
      (progn 
        ;; disable the scroll bar and load the moe light them with no error
        ;; in case on that there is no theme
        (scroll-bar-mode 0)
        (menu-bar-mode 1)
        (condition-case nil
            ;; (load-theme 'moe-light t)
            (load-theme 'apropospriate-light t)
          (error nil)))
    (progn 
      ;; disable the menu bar and load the dark theme
      (menu-bar-mode 0)
      (condition-case nil
          (load-theme  'apropospriate-dark t)
        (error nil))))))

(mapc #'gavin/graphic-sensitive-cfg (frame-list))
(add-hook 'after-make-frame-functions #'gavin/graphic-sensitive-cfg)

;;(add-hook 'window-setup-hook (lambda () (gavin/graphic-sensitive-cfg (selected-frame))))
 
(provide 'init-ui)
