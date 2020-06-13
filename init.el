
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; bind f2 to open init.el
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "<f2>") 'open-my-init-file)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; set coustm.el file path
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Package Management
(require 'init-packages)

;; change the ui
(require 'init-ui)

;;
(require 'init-better-default)

(require 'init-org)

;;
(require 'init-custom-key)

