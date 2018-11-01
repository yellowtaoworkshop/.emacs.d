(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(company-backends
   (quote
    ((company-keywords company-dabbrev-code company-abbrev company-etags)
     company-ispell company-eclim company-abbrev company-semantic company-capf company-dabbrev)))
 '(company-files-exclusions t)
 '(company-idle-delay 0.3)
 '(company-minimum-prefix-length 3)
 '(custom-enabled-themes (quote (molokai)))
 '(helm-completing-read-handlers-alist
   (quote
    ((describe-function . helm-completing-read-symbols)
     (describe-variable . helm-completing-read-symbols)
     (describe-symbol . helm-completing-read-symbols)
     (debug-on-entry . helm-completing-read-symbols)
     (find-function . helm-completing-read-symbols)
     (disassemble . helm-completing-read-symbols)
     (trace-function . helm-completing-read-symbols)
     (trace-function-foreground . helm-completing-read-symbols)
     (trace-function-background . helm-completing-read-symbols)
     (find-tag . helm-completing-read-default-find-tag)
     (org-capture . helm-org-completing-read-tags)
     (org-set-tags . helm-org-completing-read-tags)
     (ffap-alternate-file)
     (tmm-menubar)
     (find-file)
     (find-file-read-only . ido)
     (find-file-at-point . helm-completing-read-sync-default-handler)
     (ffap . helm-completing-read-sync-default-handler)
     (execute-extended-command)
     (dired-do-rename . helm-read-file-name-handler-1)
     (dired-do-copy . helm-read-file-name-handler-1)
     (dired-do-symlink . helm-read-file-name-handler-1)
     (dired-do-relsymlink . helm-read-file-name-handler-1)
     (dired-do-hardlink . helm-read-file-name-handler-1))))
 '(custom-safe-themes
   (quote
    ("e297f54d0dc0575a9271bb0b64dad2c05cff50b510a518f5144925f627bb5832" "c3c0a3702e1d6c0373a0f6a557788dfd49ec9e66e753fb24493579859c8e95ab" default)))
 '(display-line-numbers-type (quote relative))
 '(display-time-mode t)
 '(global-display-line-numbers-mode t)
 '(ido-mode (quote both) nil (ido))
 '(inhibit-startup-screen t)
 '(line-number-mode nil)
 '(package-selected-packages
   (quote
    (hungry-delete undo-tree smooth-scrolling popup org-beautify-theme org goto-chg evil-surround evil-numbers evil-matchit evil async swiper martparens popwin)))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(verilog-case-indent 4)
 '(verilog-indent-level 4)
 '(verilog-indent-level-behavioral 4)
 '(verilog-indent-level-declaration 4)
 '(verilog-indent-level-module 4))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 143 :width normal))))
 '(company-preview ((t (:foreground "gray"))))
 '(company-preview-common ((t (:inherit nil :foreground "dim gray"))))
 '(company-scrollbar-bg ((t (:background "white"))))
 '(company-scrollbar-fg ((t (:background "gray"))))
 '(company-tooltip ((t (:background "dim gray" :foreground "white"))))
 '(company-tooltip-common ((t (:underline t))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-common :foreground "black"))))
 '(company-tooltip-selection ((t (:background "cyan3" :foreground "black")))))

