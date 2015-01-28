

;;--------------------���Ի����ַ�������(utf-8)------------------
;(set-language-environment 'Chinese-GB)
;(set-keyboard-coding-system 'utf-8)
;(set-clipboard-coding-system 'utf-8)
;(set-terminal-coding-system 'utf-8)
;(set-buffer-file-coding-system 'utf-8)
;(set-default-coding-systems 'utf-8)
;(set-selection-coding-system 'utf-8)
;(modify-coding-system-alist 'process "*" 'utf-8)
;(setq default-process-coding-system '(utf-8 . utf-8))
;(setq-default pathname-coding-system 'utf-8)
;(set-file-name-coding-system 'utf-8)
;(setq ansi-color-for-comint-mode t)
;(setq file-name-coding-system 'utf-8)
;(setq path-name-coding-system 'utf-8)

;(if (eq system-type 'windows-nt) (setq file-name-coding-system 'gbk))

;;Ĭ������
(set-default-font "Courier New-12")

;;����ճ�����������
;(set-clipboard-coding-system 'euc-cn)

;;Tramp Զ��(����plink.exe�ڵ�ǰpath�ɷ���)
(require 'tramp) 
(setq tramp-default-method "plink")

(setq default-directory "e:/workspace/")



;--------------------Latex-------------------------
;; (add-hook 'org-mode-hook 
;; 		  (lambda () (setq truncate-lines nil)))

;; (require 'org-install)
;; (require 'org-latex)

;; ;; ʹ��xelatexһ������PDF
;; (setq org-latex-to-pdf-process
;; '("xelatex -interaction nonstopmode %f" "xelatex -interaction nonstopmode %f"))

;; ;; codeִ����Ӧ��Eval code without confirm��
;; (setq org-confirm-babel-evaluate nil)

;; ;; Auctex
;; (setq TeX-auto-save t)
;; (setq TeX-parse-self t)
;; (setq-default TeX-master nil)
;; (defun org-mode-article-modes ()
;;   (reftex-mode t)
;;   (and (buffer-file-name)
;;        (file-exists-p (buffer-file-name))
;;        (reftex-parse-all)))

;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (if (member "REFTEX" org-todo-keywords-1)
;;                 (org-mode-article-modes))))

;; (unless (boundp 'org-export-latex-classes)
;;   (setq org-export-latex-classes nil))

;; (add-to-list 'org-export-latex-classes
;;              '("cn-article"
;; 			   "
;; \\documentclass[10pt,a4paper]{article}
;; \\usepackage{graphicx}
;; \\usepackage{xcolor}
;; \\usepackage{xeCJK}
;; \\usepackage{lmodern}
;; \\usepackage{verbatim}
;; \\usepackage{fixltx2e}
;; \\usepackage{longtable}
;; \\usepackage{float}
;; \\usepackage{tikz}
;; \\usepackage{wrapfig}
;; \\usepackage{soul}
;; \\usepackage{textcomp}
;; \\usepackage{listings}
;; \\usepackage{geometry}
;; \\usepackage{algorithm}
;; \\usepackage{algorithmic}
;; \\usepackage{marvosym}
;; \\usepackage{wasysym}
;; \\usepackage{latexsym}
;; \\usepackage{natbib}
;; \\usepackage{fancyhdr}
;; \\usepackage[xetex,colorlinks=true,CJKbookmarks=true,
;; linkcolor=blue,
;; urlcolor=blue,
;; menucolor=blue]{hyperref}
;; \\usepackage{fontspec,xunicode,xltxtra}
;; \\setmainfont[BoldFont=Adobe Heiti Std]{Adobe Song Std}  
;; \\setsansfont[BoldFont=Adobe Heiti Std]{AR PL UKai CN}  
;; \\setmonofont{Bitstream Vera Sans Mono}  
;; \\newcommand\\fontnamemono{AR PL UKai CN}%�ȿ�����
;; \\newfontinstance\\MONO{\\fontnamemono}
;; \\newcommand{\\mono}[1]{{\\MONO #1}}
;; \\setCJKmainfont[Scale=0.9]{Adobe Heiti Std}%��������
;; \\setCJKmonofont[Scale=0.9]{Adobe Heiti Std}
;; \\hypersetup{unicode=true}
;; \\geometry{a4paper, textwidth=6.5in, textheight=10in,
;; marginparsep=7pt, marginparwidth=.6in}
;; \\definecolor{foreground}{RGB}{220,220,204}%ǳ��
;; \\definecolor{background}{RGB}{62,62,62}%ǳ��
;; \\definecolor{preprocess}{RGB}{250,187,249}%ǳ��
;; \\definecolor{var}{RGB}{239,224,174}%ǳ��ɫ
;; \\definecolor{string}{RGB}{154,150,230}%ǳ��ɫ
;; \\definecolor{type}{RGB}{225,225,116}%ǳ��
;; \\definecolor{function}{RGB}{140,206,211}%ǳ����
;; \\definecolor{keyword}{RGB}{239,224,174}%ǳ��ɫ
;; \\definecolor{comment}{RGB}{180,98,4}%���ɫ
;; \\definecolor{doc}{RGB}{175,215,175}%ǳǦ��
;; \\definecolor{comdil}{RGB}{111,128,111}%���
;; \\definecolor{constant}{RGB}{220,162,170}%�ۺ�
;; \\definecolor{buildin}{RGB}{127,159,127}%��Ǧ��
;; \\punctstyle{kaiming}
;; \\title{}
;; \\fancyfoot[C]{\\bfseries\\thepage}
;; \\chead{\\MakeUppercase\\sectionmark}
;; \\pagestyle{fancy}
;; \\tolerance=1000
;; [NO-DEFAULT-PACKAGES]
;; [NO-PACKAGES]"
;; ("\\section{%s}" . "\\section*{%s}")
;; ("\\subsection{%s}" . "\\subsection*{%s}")
;; ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;; ("\\paragraph{%s}" . "\\paragraph*{%s}")
;; ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; ;; ʹ��Listings�����ʽ��Դ����(ֻ�ǰѴ������listing����������������Ҫ���������)
;; (setq org-export-latex-listings t)

;; ;; Options for \lset command��reference to listing Manual)
;; (setq org-export-latex-listings-options
;;       '(
;;         ("basicstyle" "\\color{foreground}\\small\\mono")           ; Դ����������ʽ
;;         ("keywordstyle" "\\color{function}\\bfseries\\small\\mono") ; �ؼ���������ʽ
;;         ("identifierstyle" "\\color{doc}\\small\\mono")
;;         ("commentstyle" "\\color{comment}\\small\\itshape")         ; ��ע��ʽ
;;         ("stringstyle" "\\color{string}\\small")                    ; �ַ�����ʽ
;;         ("showstringspaces" "false")                                ; �ַ����ո���ʾ
;;         ("numbers" "left")                                          ; �к���ʾ
;;         ("numberstyle" "\\color{preprocess}")                       ; �к���ʽ
;;         ("stepnumber" "1")                                          ; �кŵ���
;;         ("backgroundcolor" "\\color{background}")                   ; ����򱳾�ɫ
;;         ("tabsize" "4")                                             ; TAB��Ч�ո���
;;         ("captionpos" "t")                                          ; ����λ�� top or buttom(t|b)
;;         ("breaklines" "true")                                       ; �Զ�����
;;         ("breakatwhitespace" "true")                                ; ֻ�ڿո����
;;         ("showspaces" "false")                                      ; ��ʾ�ո�
;;         ("columns" "flexible")                                      ; ����ʽ
;;         ("frame" "single")                                          ; �������Ӱ��
;;         ("frameround" "tttt")                                       ; ����� Բ��
;;         ("framesep" "0pt")
;;         ("framerule" "8pt")
;;         ("rulecolor" "\\color{background}")
;;         ("fillcolor" "\\color{white}")
;;         ("rulesepcolor" "\\color{comdil}")
;;         ("framexleftmargin" "10mm")
;;         ))

;; ;; Make Org use ido-completing-read for most of its completing prompts.
;; (setq org-completion-use-ido t)

;; ;; ����Babel����֧��
;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((R . t)
;;    (emacs-lisp . t)
;;    (matlab . t)
;;    (C . t)
;;    (perl . t)
;;    (sh . t)
;;    (ditaa . t)
;;    (python . t)
;;    (haskell . t)
;;    (dot . t)
;;    (latex . t)
;;    (js . t)
;;    ))

;; ;; ����Beamer������
;; ;; allow for export=>beamer by placing #+LaTeX_CLASS: beamer in org files
;; ;;-----------------------------------------------------------------------------
;; (add-to-list 'org-export-latex-classes
;;              ;; beamer class, for presentations
;;              '("beamer"
;;                "
;; \\documentclass[11pt,professionalfonts]{beamer}
;; \\mode
;; \\usetheme{{{{Warsaw}}}}
;; %\\usecolortheme{{{{beamercolortheme}}}}
;; \\beamertemplateballitem
;; \\setbeameroption{show notes}
;; \\usepackage{graphicx}
;; \\usepackage{tikz}
;; \\usepackage{xcolor}
;; \\usepackage{xeCJK}
;; \\usepackage{amsmath}
;; \\usepackage{lmodern}
;; \\usepackage{fontspec,xunicode,xltxtra}
;; \\usepackage{polyglossia}
;; \\setmainfont{Times New Roman}
;; \\setCJKmainfont{DejaVu Sans YuanTi}
;; \\setCJKmonofont{DejaVu Sans YuanTi Mono}
;; \\usepackage{verbatim}
;; \\usepackage{listings}
;; \\institute{{{{beamerinstitute}}}}
;; \\subject{{{{beamersubject}}}}"
;;                ("\\section{%s}" . "\\section*{%s}")
;;                ("\\begin{frame}[fragile]\\frametitle{%s}"
;;                 "\\end{frame}"
;;                 "\\begin{frame}[fragile]\\frametitle{%s}"
;;                 "\\end{frame}")))

;; (setq ps-paper-type 'a4
;;       ps-font-size 16.0
;;       ps-print-header nil
;;       ps-landscape-mode nil)


;; ʹ��
;; ����������pdf��org�ļ���ʼλ�ü������´��룺

;; #+LATEX_CLASS: cn-article
;; ����cn-article�����ϴ���:

;; (add-to-list 'org-export-latex-classes
;;              '("cn-article"
;; �����ҵ�����(��Ȼ��Ҳ���Ըĳ��Լ���)��ͬ���ڵ����ɻõ�Ƭ��org�ļ���ʼλ�ñ������

;; #��LATEX_CLASS: beamer



;; (add-to-list 'org-export-latex-classes
;;                   '("cjk-article"
;;                     "\\documentclass{article}
;;  [NO-DEFAULT-PACKAGES]
;;  [PACKAGES]
;;  [EXTRA]"
;;          ("\\section{%s}" . "\\section*{%s}")
;;          ("\\subsection{%s}" . "\\subsection*{%s}")
;;          ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;;          ("\\paragraph{%s}" . "\\paragraph*{%s}")
;;          ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; (setq org-export-latex-packages-alist '(
;;     (""   "CJK"   t)
;;     (""     "indentfirst"  nil)
;;     ("pdftex"     "graphicx"  t)
;;     (""     "fancyhdr" nil)
;;     ("CJKbookmarks=true"     "hyperref"  nil)
;; "%% Define a museincludegraphics command, which is
;; %%   able to handle escaped special characters in image filenames.
;; \\def\\museincludegraphics{%
;;   \\begingroup
;;   \\catcode`\\\|=0
;;   \\catcode`\\\\=12
;;   \\catcode`\\\#=12
;;   \\includegraphics[width=0.75\\textwidth]
;; }"))
