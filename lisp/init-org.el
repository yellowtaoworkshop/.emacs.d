(autoload 'org-agenda "org-agenda" nil t)
(autoload 'org-capture "org-capture" nil t)
(autoload 'org-store-link "org" nil t)

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
                                 ("wl" "for long time work" entry (file+headline "~/Documents/Org/workGtd.org" "Duration Work Tasks")
                                  "** TODO %? [%]\n%i*** TODO ")
                                 ("wd" "for daily work" entry (file+headline "~/Documents/Org/workGtd.org" "Daily Work Tasks")
                                  "** TODO %? [%]\n   - [ ] ")
                                 ("l" "Learn Tasks")
                                 ("ll" "for long time learning" entry (file+headline "~/Documents/Org/learnGtd.org" "Duration Learning Tasks")
                                  "** TODO %? [/]\n%i*** TODO ")
                                 ("ld" "for daily learning" entry (file+headline "~/Documents/Org/learnGtd.org" "Daily Learning Tasks")
                                  "** TODO %? [/]\n   - [ ] "))
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
