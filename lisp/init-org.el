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


;; TODO workflow state
;; TODO      - for the work need to be done in today
;; WIP       - for the work is working in progress, you can finished it today or in the future
;; SCHEDULED - for the work that will be done in the future and it not started at all
;; 

(setq org-todo-keywords
      '((sequence "TODO" "WIP" "|" "DONE")
	(sequence "TODO" "SCHEDULED" "|" "DONE")
	(sequence "FIXME" "FIXING" "|" "FIXED")
	(sequence "|" "CANCELED")))

;; org capture setting
(setq org-capture-templates
      '(("w" "Work Tasks")
	("wl" "for long time work" entry (file+headline "~/Documents/Org/workGtd.org" "Duration Work Tasks")
	 "** TODO %? [%]\n%i*** TODO ")
	("wd" "for daily work" entry (file+headline "~/Documents/Org/workGtd.org" "Daily Work Tasks")
	 "** TODO %? [%]\n   - [ ] ")
	("l" "Learn Tasks")
	("ll" "for long time learning" entry (file+headline "~/Documents/Org/learnGtd.org" "Duration Learning Tasks")
	 "** TODO %? [/]\n%i*** TODO ")
	("ld" "for daily learning" entry (file+headline "~/Documents/Org/learnGtd.org" "Daily Learning Tasks")
	 "** TODO %? [/]\n   - [ ] ")))

;; make syntax hilight in org file 
;;(require 'org)
(setq org-src-fontify-natively t)

(provide 'init-org)

