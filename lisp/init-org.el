(autoload 'org-agenda "org-agenda" nil t)
(autoload 'org-capture "org-capture" nil t)
(autoload 'org-store-link "org" nil t)

(defun gavin/org-capture-gtd-dir ()
  "Return `~/Documents/Org/YYYY/Qn/' for today, creating directories if needed.
Qn is Q1–Q4 from the calendar month."
  (let* ((root (expand-file-name "~/Documents/Org/"))
         (year (format-time-string "%Y"))
         (month (string-to-number (format-time-string "%m")))
         (q (1+ (/ (1- month) 3)))
         (dir (expand-file-name (format "%s/Q%d" year q) root)))
    (unless (file-directory-p dir)
      (make-directory dir t))
    dir))

(defun gavin/org-capture-work-file ()
  "Work GTD file under the current year/quarter Org tree."
  (expand-file-name "workGtd.org" (gavin/org-capture-gtd-dir)))

(defun gavin/org-capture-learn-file ()
  "Learn GTD file under the current year/quarter Org tree."
  (expand-file-name "learnGtd.org" (gavin/org-capture-gtd-dir)))

(defun gavin/org-capture--english-month-title ()
  "English full month name for today (January … December)."
  (nth (1- (string-to-number (format-time-string "%m")))
       '("January" "February" "March" "April" "May" "June"
         "July" "August" "September" "October" "November" "December")))

(defun gavin/org-capture--goto-month-heading ()
  "Ensure a level-1 \"* MONTH\" headline exists; point on that line.
Task type is not on this line — use \\=`:Duration:\\=' / \\=`:Daily:\\=' on the
captured \\=`** TODO\\=' line in `org-capture-templates' (Org tags on headlines)."
  (require 'org)
  (unless (derived-mode-p 'org-mode)
    (org-mode))
  (let ((month-title (gavin/org-capture--english-month-title)))
    (widen)
    (goto-char (point-min))
    (when (org-before-first-heading-p)
      (insert (format "* %s\n" month-title)))
    (unless (org-find-exact-headline-in-buffer month-title nil t)
      (goto-char (point-max))
      (unless (bolp) (insert "\n"))
      (insert (format "* %s\n" month-title))
      (org-find-exact-headline-in-buffer month-title nil t))
    (org-back-to-heading t)
    (when (fboundp 'org-fold-show-all)
      (org-fold-show-all))
    (beginning-of-line)
    (unless (org-at-heading-p)
      (org-back-to-heading t)
      (beginning-of-line))
    (widen)))

(defun gavin/org-capture-goto-work-duration ()
  (gavin/org-capture--goto-month-heading))

(defun gavin/org-capture-goto-work-daily ()
  (gavin/org-capture--goto-month-heading))

(defun gavin/org-capture-goto-learn-duration ()
  (gavin/org-capture--goto-month-heading))

(defun gavin/org-capture-goto-learn-daily ()
  (gavin/org-capture--goto-month-heading))

(defun gavin/org-capture--gtd-filename-p (file)
  "Non-nil if FILE is our work/learn GTD capture file (any directory layout)."
  (and file
       (member (file-name-nondirectory file) '("workGtd.org" "learnGtd.org"))))

(defun gavin/org-capture--fix-gtd-place-entry ()
  "Run as :before `org-capture-place-entry'.

`org-capture-place-entry' runs with the indirect CAPTURE buffer current — not
necessarily `org-capture-get' :buffer.  When :target-entry-p is wrongly nil,
Org jumps to `point-max' and skips the target headline.

We force :target-entry-p and a bol position on the \\=`* Month\\=' headline using
`current-buffer', which matches where insertion actually happens.

Indirect capture buffers have \\=`buffer-file-name\\=' nil; use the base buffer's
name (same as Org's file+function target).

Also force \\=`:insert-here\\=' to nil so Org uses the child-of-heading branch and
\\=`** TODO\\=' templates become headline 2 under the month, not another level-1
headline."
  (when (and (fboundp 'org-capture-get) (fboundp 'org-capture-put)
             (org-capture-get :exact-position))
    (let ((file (or (buffer-file-name)
                    (and (buffer-base-buffer)
                         (buffer-file-name (buffer-base-buffer)))
                    (let ((b (org-capture-get :buffer)))
                      (and b (buffer-file-name b))))))
      (when (gavin/org-capture--gtd-filename-p file)
        (org-capture-put :insert-here nil)
        (save-excursion
          (widen)
          (when (fboundp 'org-fold-show-all)
            (org-fold-show-all))
          (unless (derived-mode-p 'org-mode)
            (org-mode))
          (goto-char (org-capture-get :exact-position))
          (unless (org-at-heading-p)
            (org-back-to-heading t))
          (beginning-of-line)
          (when (org-at-heading-p)
            (org-capture-put :exact-position (point))
            (org-capture-put :target-entry-p t)))))))

(defun gavin/org-mode-setup ()
  (when (require 'org-bullets nil t)
    (org-bullets-mode 1)))

;; TODO workflow state
;; TODO      - for the work need to be done in today
;; WIP       - for the work is working in progress, you can finished it today or in the future
;; SCHEDULED - for the work that will be done in the future and it not started at all

(with-eval-after-load 'org
  (add-hook 'org-mode-hook #'gavin/org-mode-setup)
  (setq org-hide-emphasis-markers t
        org-todo-keywords '((sequence "TODO" "WIP" "|" "DONE")
                             (sequence "TODO" "SCHEDULED" "|" "DONE")
                             (sequence "FIXME" "FIXING" "|" "FIXED")
                             (sequence "|" "CANCELED"))
        org-capture-templates '(("w" "Work Tasks")
                                 ("wl" "for long time work" entry
                                  (file+function gavin/org-capture-work-file
                                                 gavin/org-capture-goto-work-duration)
                                  "** TODO %? [%] :Duration:\n%i*** TODO ")
                                 ("wd" "for daily work" entry
                                  (file+function gavin/org-capture-work-file
                                                 gavin/org-capture-goto-work-daily)
                                  "** TODO %? [%] :Daily:\n   - [ ] ")
                                 ("l" "Learn Tasks")
                                 ("ll" "for long time learning" entry
                                  (file+function gavin/org-capture-learn-file
                                                 gavin/org-capture-goto-learn-duration)
                                  "** TODO %? [/] :Duration:\n%i*** TODO ")
                                 ("ld" "for daily learning" entry
                                  (file+function gavin/org-capture-learn-file
                                                 gavin/org-capture-goto-learn-daily)
                                  "** TODO %? [/] :Daily:\n   - [ ] "))
        org-src-fontify-natively t)
  (font-lock-add-keywords
   'org-mode
   '(("^ *\\([-+*]\\) "
      (0 (prog1 ()
           (compose-region (match-beginning 1) (match-end 1) "•"))))))
  (custom-set-faces
   '(org-level-1 ((t (:inherit outline-1 :height 1.0))))
   '(org-level-2 ((t (:inherit outline-2 :height 1.0))))
   '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
   '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
   '(org-level-5 ((t (:inherit outline-5 :height 1.0))))))

;;(with-eval-after-load 'org-capture
;;  (advice-add 'org-capture-place-entry :before #'gavin/org-capture--fix-gtd-place-entry))

(with-eval-after-load 'ox-latex
  (setq org-latex-pdf-process
        '("latexmk -pdflatex='pdflatex -interaction nonstopmode' -pdf -bibtex -f %f"))
  (unless (boundp 'org-latex-classes)
    (setq org-latex-classes nil))
  (add-to-list 'org-latex-classes
               '("ethz"
                 "\\documentclass[a4paper,11pt,titlepage]{memoir}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{fixltx2e}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{rotating}
\\usepackage[normalem]{ulem}
\\usepackage{amsmath}
\\usepackage{textcomp}
\\usepackage{marvosym}
\\usepackage{wasysym}
\\usepackage{amssymb}
\\usepackage{hyperref}
\\usepackage{mathpazo}
\\usepackage{color}
\\usepackage{enumerate}
\\definecolor{bg}{rgb}{0.95,0.95,0.95}
\\tolerance=1000
      [NO-DEFAULT-PACKAGES]
      [PACKAGES]
      [EXTRA]
\\linespread{1.1}
\\hypersetup{pdfborder=0 0 0}"
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (add-to-list 'org-latex-classes
               '("article"
                 "\\documentclass[11pt,a4paper]{article}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{fixltx2e}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{rotating}
\\usepackage[normalem]{ulem}
\\usepackage{amsmath}
\\usepackage{textcomp}
\\usepackage{marvosym}
\\usepackage{wasysym}
\\usepackage{amssymb}
\\usepackage{hyperref}
\\usepackage{mathpazo}
\\usepackage{color}
\\usepackage{enumerate}
\\definecolor{bg}{rgb}{0.95,0.95,0.95}
\\tolerance=1000
      [NO-DEFAULT-PACKAGES]
      [PACKAGES]
      [EXTRA]
\\linespread{1.1}
\\hypersetup{pdfborder=0 0 0}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")))
  (add-to-list 'org-latex-classes
               '("ebook"
                 "\\documentclass[11pt, oneside]{memoir}
\\setstocksize{9in}{6in}
\\settrimmedsize{\\stockheight}{\\stockwidth}{*}
\\setlrmarginsandblock{2cm}{2cm}{*} % Left and right margin
\\setulmarginsandblock{2cm}{2cm}{*} % Upper and lower margin
\\checkandfixthelayout
% Much more laTeX code omitted
"
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}"))))

(provide 'init-org)
