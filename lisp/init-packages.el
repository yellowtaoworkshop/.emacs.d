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
			     ("gnu" . "http://mirrors.163.com/elpa/gnu/")))

;; cl - Common Lisp Extension
(require 'cl)


;; ...
(defvar gavin/packages '(
			company
			hungry-delete
			undo-tree
			smpooth-scrolling
			popup
			org-beautify-theme
			org
			goto-chg
			evil-surround
			evil-numbers
			evil-matchit
			evil
			async
			helm
			helm-core
			smartparens
			) "default package")

(setq package-selected-packages gavin/packages)

(defun gavin/package-installed-p ()
  (loop for pkg in gavin/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (gavin/package-installed-p)
  (message "Refreshing package database..")
  (package-refresh-contents)
  (dolist (pkg gavin/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;; the end of file
(provide 'init-packages)
