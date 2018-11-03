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
			     ("gnu" . "http://mirrors.163.com/elpa/gnu/"))))

;; cl - Common Lisp Extension
(require 'cl)


;; ...
(defvar gavin/packages '(
			company
			;;auto-complete 
			hungry-delete
			undo-tree
			smooth-scrolling
			popup
			org-beautify-theme
			org
			goto-chg
			evil-surround
			evil-numbers
			evil-matchit
			evil
			async
			;swiper
			;counsel
                        smartparens
			popwin
			;swiper-helm
			helm
			helm-core
			helm-swoop
			expand-region
			yasnippet
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


;;Evil mode
(require 'evil)
(evil-mode 0)
;; load evil plugin
(require 'evil-numbers)
(require 'evil-surround)
(global-evil-surround-mode 1)
(require 'evil-matchit)
(global-evil-matchit-mode 1)


;;
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)
(setq smooth-scroll-margin 3)


;;
(helm-mode 1)
(require 'helm-swoop)
;;(require 'helm-smex)



;; make syntax hilight in org file 
;;(require 'org)
(setq org-src-fontify-natively t)

(require 'hungry-delete)
(global-hungry-delete-mode 1)

;;turn on auto complete 
(require 'company)
(global-company-mode 1)
(require 'verilog-mode)
;; let company support verilog 
(add-to-list 'company-keywords-alist (cons 'verilog-mode verilog-keywords))
;;(ac-config-default)


;; smartparens enable
(smartparens-global-strict-mode t)
(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)

;; popwin enable
(require 'popwin)
(popwin-mode 1)


(yas-global-mode 1)

;; the end of file
(provide 'init-packages)
