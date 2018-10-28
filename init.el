
;; bind f2 to open init.el
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "<f2>") 'open-my-init-file)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path "~/.emacs.d/lisp/theme/")
(add-to-list 'load-path "~/.emacs.d/lisp/theme/powerline")
(add-to-list 'custom-theme-load-path "~/.emacs.d/lisp/theme/")

;; set coustm.el file path
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Package Management
(require 'init-packages)

;;
(require 'init-better-default)
;;
(require 'init-ui)

;;
(require 'init-custom-key)
