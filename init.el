;;------------------------�������ÿ�ʼ------------------------
(add-to-list 'load-path "~/.emacs.d/lisp")

;;���ڳ�ʼ��С
(setq initial-frame-alist '((top . 0) (left . 0) (width . 80) (height . 37)))

;;���ô��ļ���ȱʡĿ¼
;(setq default-directory "E:/")

;;ȥ��������ӭ����
(setq inhibit-startup-message t)

;;Ctrl+��������������
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;;��Ҫ����û��û�˵���yes or no, Ϊʲô������ y/n
(fset 'yes-or-no-p 'y-or-n-p)

;;�򿪸��� #M-x global-font-lock-mode
(global-font-lock-mode t)

;;ʾ����ƥ��
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;;��ʾ�к�
(setq column-number-mode t)
;;(setq line-number-mode nil)
;;�������ʾ�к�
(global-linum-mode 'linum-mode)

;;set mark(����ѡ���ı�ģ�飩
(global-set-key (kbd "M-SPC") 'set-mark-command)

;;��꿿������ʱ��������Զ��ÿ�����ס����
;(mouse-avoidance-mode 'animate)

;;ƽ������, �ڹ�������һ�е�ʱ�򣬼�����һ��������ʱ�������Ե������о�
(setq scroll-margin 2 scroll-conservatively 10000)

;;��ֹ�Զ�����
;;(auto-save-mode t)


;;Ĭ����ʾ 80�оͻ���
;(setq default-fill-column 80)

;;�����м��
;(setq-default line-spacing 2)

;;��Ҫ������ʱ�ļ�
(setq-default make-backup-files nil);

;;Ctrl+Z �ڴ���ģʽ�²���С��Eamcs
;(if (eq window-system 'x) (global-set-key [(control z)] 'suspend-emacs))

;;������ʾ��ǰ��
;(global-hl-line-mode)

;;������������ʾʱ��
(display-time-mode 1)

;;ʹ��24Сʱ��
(setq display-time-24hr-format t)

;;���Ϊ����
(setq-default cursor-type 'bar)

;;�����ɫ
;(set-cursor-color "green")

;;������ɫ; ����ɫ
;(set-background-color "#CBE8CF")

;;���ز˵������Ҳ�Ĺ�����
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; ����ido-mode
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-everywhere t)
(ido-mode 1)

;;buffer ���ڿ��
;;(global-set-key [F12] 'delete-other-windows);�ر���������
(global-set-key "\M-9" 'kill-this-buffer);�رյ�ǰbuffe
(global-set-key "\M-0" 'delete-window); �رմ���

(global-set-key (kbd "<f5>") 'kmacro-call-macro);���ź�
(define-key  key-translation-map [f9] (kbd "C-x r l")) ;�鿴��ǩ
(define-key  key-translation-map [f10] (kbd "C-x r m")) ;������ǩ
;(define-key  key-translation-map [f11] (kbd "C-x"))
(define-key  key-translation-map [f12] (kbd "C-x"))

;; ��������в��䣬���¹���
(global-set-key "\M-p" '(lambda () (interactive) (scroll-down 1)))
(global-set-key "\M-n" '(lambda () (interactive) (scroll-up 1)))

;; �س� �ĳɻس�������
(global-set-key (kbd "RET") 'newline-and-indent)

;; ����TabΪ4���ַ�
(setq indent-tabs-mode nil)
(setq default-tab-width 4)
(setq tab-width 4)

;;Emacs������������ʾ�����ļ���
;(setq frame-title-format " %b")
(defun frame-title-string ()
  "Return the file name of current buffer, using ~ if under home directory"
  (let
      ((fname (or (buffer-file-name (current-buffer))(buffer-name))))
	;;let body
	(when (string-match (getenv "HOME") fname)
	  (setq fname (replace-match "~" t t fname)))
	fname))
(setq frame-title-format '("" system-name "  File: "(:eval (frame-title-string))))


;; ���Բ�ȫ��������
(global-set-key [(meta ?/)] 'hippie-expand)
(setq hippie-expand-try-functions-list
	  '(try-expand-line
		try-expand-line-all-buffers
		try-expand-list
		try-expand-list-all-buffers
		try-expand-dabbrev
		try-expand-dabbrev-visible
		try-expand-dabbrev-all-buffers
		try-expand-dabbrev-from-kill
		try-complete-file-name
		try-complete-file-name-partially
		try-complete-lisp-symbol
		try-complete-lisp-symbol-partially
		try-expand-whole-kill))
;;------------------------��չ���ÿ�ʼ------------------------
;;͸����͸��
(global-set-key [(f8)] 'loop-alpha)
(setq alpha-list '((88 55) (100 100)))

(defun loop-alpha ()
  (interactive)
  (let ((h (car alpha-list)))
    ((lambda (a ab)
       (set-frame-parameter (selected-frame) 'alpha (list a ab))
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))) (car h) (car (cdr h)))
    (setq alpha-list (cdr (append alpha-list (list h))))))

;; �ڵ�ǰ���д򿪵�buffer���滻�ַ���-
(defun query-replace-regexp-in-open-buffers (arg1 arg2)
  "query-replace in all open files"
  (interactive "sRegexp:\nsReplace with:")
  (mapcar
   (lambda (x)
     (find-file x)
     (save-excursion
       (goto-char (point-min))
       (query-replace-regexp arg1 arg2)))
   (delq
    nil
    (mapcar
     (lambda (x)
       (buffer-file-name x))
     (buffer-list)))))

;; �ڵ�ǰ���д򿪵�buffer���滻�ַ���
(defun query-replace-in-open-buffers (arg1 arg2)
  "query-replace in all open files"
  (interactive "sRegexp:\nsReplace with:")
  (mapcar
   (lambda (x)
     (find-file x)
     (save-excursion
       (goto-char (point-min))
       (query-replace arg1 arg2)))
   (delq
    nil
    (mapcar
     (lambda (x)
       (buffer-file-name x))
     (buffer-list)))))

;;----- �ı��в���-��ʼ---------
;;Alt+���¼����ƶ�һ������
;;move line up down
(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg))
        (forward-line -1))
      (move-to-column column t)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

(global-set-key [M-up] 'move-text-up)
(global-set-key [M-down] 'move-text-down)

;;Alt+w ���ƹ������һ���У�Alt+k�����Ƶ�ǰ�й����������
;; Smart copy, if no region active, it simply copy the current whole line
(defadvice kill-line
  (before check-position activate)
  (if (member major-mode
			  '(emacs-lisp-mode scheme-mode lisp-mode c-mode c++-mode objc-mode js-mode latex-mode plain-tex-mode))
	  (if (and (eolp) (not (bolp)))
		  (progn (forward-char 1) (just-one-space 0) (backward-char 1)))))

 (defadvice kill-ring-save (before slick-copy activate compile)
   "When called interactively with no active region, copy a single line instead."
   (interactive (if mark-active (list (region-beginning) (region-end))
				  (message "Copied line")
					(list (line-beginning-position) (line-beginning-position 2)))))

 (defadvice kill-region (before slick-cut activate compile)
   "When called interactively with no active region, kill a single line instead."
   (interactive (if mark-active (list (region-beginning) (region-end)) (list (line-beginning-position) (line-beginning-position 2)))))

;; Copy line from point to the end, exclude the line break
(defun qiang-copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (point) (line-end-position))
  (line-beginning-position (+ 1 arg)))
(global-set-key (kbd "M-k") 'qiang-copy-line)

;; Alt+;ע�͡���ע��
(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command. If no region is selected and current line is not blank and we are not at the end of the line, then comment current line. Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'qiang-comment-dwim-line)
;;----- �ı��в���-����---------

;;--------------------��չ���ý���---------------

;;package
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)


;;------------------- ����������ʼ --------------
(add-to-list 'load-path "~/.emacs.d/lisp/single-el")
(add-to-list 'load-path "~/.emacs.d/lisp/cl-lib")
(add-to-list 'load-path "~/.emacs.d/lisp/auto-complete")
(add-to-list 'load-path "~/.emacs.d/lisp/popup-el")
(add-to-list 'load-path "~/.emacs.d/lisp/yasnippet")
(add-to-list 'load-path "~/.emacs.d/lisp/js2-mode")
(add-to-list 'custom-theme-load-path "~/.emacs.d/lisp/themes")
(add-to-list 'load-path "~/.emacs.d/lisp/highlight-parentheses.el")
(add-to-list 'load-path "~/.emacs.d/lisp/emacs-request")
(add-to-list 'load-path "~/.emacs.d/lisp/emacs-nw")



;; --------------- �Զ���� -----------------------

;; auto-complate
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/lisp/auto-complete/ac-dict")
(ac-config-default)

;; Ctrl+�س�����
;(setq ac-auto-start nil) ;auto complete using clang is CPU sensitive
;(ac-set-trigger-key "<C-return>")
;; backspace��ɾ�����Ծɿ��Դ���ac��ȫ
(setq ac-trigger-commands
      (cons 'backward-delete-char-untabify ac-trigger-commands))

;; -------------- �ı�ģ�� --------------------
(require 'yasnippet)
(yas-global-mode 1)
(add-hook 'prog-mode-hook
          '(lambda ()
             (yas-minor-mode)))

(add-to-list 'yas/root-directory "~/.emacs.d/lisp/yasnippet-snippets")
(yas/initialize)


;;js2-mode
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;;theme
;(load-theme 'graham t)
;ҹ������ڹ�˾��ʱ��ʹ�ð�ɫ����
(defun get-hour ()
  (string-to-int (format-time-string "%H" (current-time))))

(defun is-at-night ()
  (or (< (get-hour) 5)
	  (>= (get-hour) 19)))

(defun is-weekend ()
  (> (string-to-int (format-time-string "%u" (current-time))) 5 ))

(defun is-at-home ()
  (or (is-at-night) (is-weekend)))

(defun is-at-company()
  (not (is-at-home)))

(if (is-at-night)
;	(load-theme 'graham t))
	(load-theme 'deeper-blue t))

;;emacs-nodewebketls
(require 'emacs-nw)

;;highlight-parentheses.el
(require 'highlight-parentheses)

;;sr-speedbar
(require 'sr-speedbar)
;; ��ʹ��ͼ��  
(setq speedbar-use-images nil)    
;; speedbar�Ŀ��  
(setq sr-speedbar-width 25) 
;; �ŵ����ȥ  
(setq sr-speedbar-right-side nil) 
(global-set-key (kbd "<f7>") (lambda()    
                               (interactive)    
                               (sr-speedbar-toggle)))
;(add-hook 'after-init-hook '(lambda () (sr-speedbar-toggle)));;������������

;;youdao
(require 'youdao)
(setf youdao-key-from "mysite123") 
(setf youdao-key "1212400033")
(global-set-key (kbd "C-c C-v") 'youdao-translate-word)


;; �����Լ��������ű�
(load-file "~/.emacs.d/wdy/init.el")

;;hide region
(require 'hide-region)
(global-set-key (kbd "C-c r") 'hide-region-hide)
(global-set-key (kbd "C-c R") 'hide-region-unhide)


;; hide lines
(require 'hide-lines)
(global-set-key (kbd "C-c l") 'hide-lines)
(global-set-key (kbd "C-c L") 'show-all-invisible)

;;�Զ�����
(setq
 backup-by-copying t ; �Զ�����
 backup-directory-alist '(("." . "~/.emacs.d/auto-save-list")) ; �Զ�������Ŀ¼"~/.emacs.d/auto-save-list"��
 delete-old-versions t ; �Զ�ɾ���ɵı����ļ�
 kept-new-versions 6 ; ���������6�������ļ�
 kept-old-versions 2 ; ���������2�������ļ�(ǰ����������ģ���4���������)
 version-control t ; ��α�
 vc-make-backup-files t); �а汾����Ҳ������

(setq make-backup-files t)

;; customization
(setq custom-file "~/.emacs.d/lisp/custom.el")
(load "~/.emacs.d/lisp/custom" t)


;; window-switch
(require 'window-numbering)
(setq window-numbering-assign-func
      (lambda () (when (equal (buffer-name) "*Calculator*") 9)))
(window-numbering-mode)

;; smex
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;;old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(provide 'init)