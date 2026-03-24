(setq package-enable-at-startup nil)

(defvar gavin/original-file-name-handler-alist file-name-handler-alist)
(defvar gavin/original-gc-cons-threshold gc-cons-threshold)
(defvar gavin/original-gc-cons-percentage gc-cons-percentage)

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      file-name-handler-alist nil)

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold gavin/original-gc-cons-threshold
                  gc-cons-percentage gavin/original-gc-cons-percentage
                  file-name-handler-alist gavin/original-file-name-handler-alist)))
