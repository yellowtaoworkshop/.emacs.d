
;; set the cursor type to bar
(setq-default cursor-type 'bar)

(require 'spaceline-config)
(setq spaceline-window-numbers-unicode t)
(setq spaceline-workspace-numbers-unicode t)
(spaceline-emacs-theme)

;; hilight the current line
(global-hl-line-mode 1)

;; turn off the tool bar
(tool-bar-mode -1)

(require 'winum)
(setq winum-auto-setup-mode-line nil)
(winum-mode)

(require 'diminish)
(diminish 'eldoc-mode)
(diminish 'undo-tree-mode)
(diminish 'helm-mode)
(diminish 'company-mode "ac")
(diminish 'smartparens-mode "sp")

;; Org mode beautifly
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-hide-emphasis-markers t)

(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-+*]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.0))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
)
;;
(provide 'init-ui)
