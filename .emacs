
;;------------------------�������ÿ�ʼ------------------------
(add-to-list 'load-path "~/.emacs.d")

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
(setq column-number-mode 0)
;(setq line-number-mode t)
;;�������ʾ�к�
(global-linum-mode 'linum-mode)

;;set mark(����ѡ���ı�ģ�飩
(global-set-key (kbd "M-SPC") 'set-mark-command)

;;��꿿������ʱ��������Զ��ÿ�����ס����
;(mouse-avoidance-mode 'animate)

;;ƽ������, �ڹ�������һ�е�ʱ�򣬼�����һ��������ʱ�������Ե������о�
(setq scroll-margin 2 scroll-conservatively 10000)

;;��ֹ�Զ�����
(auto-save-mode nil)

;;Ĭ����ʾ 80�оͻ���
(setq default-fill-column 80)

;;�����м��
(setq-default line-spacing 2)

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
;(menu-bar-mode nil)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;;buffer ���ڿ��
;(global-set-key [f10] 'split-window-vertically);F10�ָ��
;(global-set-key [f11] 'delete-other-windows);F11 �ر���������
;(global-set-key [C-return] 'kill-this-buffer);C-return�رյ�ǰbuffer

(global-set-key (kbd "<f5>") 'kmacro-call-macro);���ź�
(define-key  key-translation-map [f9] (kbd "C-x r l")) ;�鿴��ǩ
(define-key  key-translation-map [f10] (kbd "C-x r m")) ;������ǩ
(define-key  key-translation-map [f11] (kbd "C-x"))
(define-key  key-translation-map [f12] (kbd "C-c"))


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

;;------------------------��չ���ÿ�ʼ------------------------
;;͸����͸��
(global-set-key [(f8)] 'loop-alpha)
(setq alpha-list '((88 55) (100 100)))

(defun loop-alpha ()
  (interactive)
  (let ((h (car alpha-list)))
    ((lambda (a ab)
       (set-frame-parameter (selected-frame) 'alpha (list a ab))
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))
       ) (car h) (car (cdr h)))
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
;;----- �ı��в���-����---------

;;--------------------��չ���ý���---------------



;;------------------- ����������ʼ --------------
(add-to-list 'load-path "~/.emacs.d/cl-lib")
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(add-to-list 'load-path "~/.emacs.d/popup-el")
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(add-to-list 'load-path "~/.emacs.d/js2-mode")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/highlight-parentheses.el")
(add-to-list 'load-path "~/.emacs.d/emacs-request")
(add-to-list 'load-path "~/.emacs.d/emacs-nw")

;;package
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)


;; --------------- �Զ���� -----------------------

;; auto-complate
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
(ac-config-default)

;; Ctrl+�س�����
(setq ac-auto-start nil) ;auto complete using clang is CPU sensitive
(ac-set-trigger-key "<C-return>")
;; backspace��ɾ�����Ծɿ��Դ���ac��ȫ
(setq ac-trigger-commands
      (cons 'backward-delete-char-untabify ac-trigger-commands))

;; -------------- �ı�ģ�� --------------------
(require 'yasnippet)
(yas-global-mode 1)
(add-hook 'prog-mode-hook
          '(lambda ()
             (yas-minor-mode)))

(add-to-list 'yas/root-directory "~/.emacs.d/yasnippet-snippets")
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
  (> (get-hour) 19))

(defun is-weekend ()
  (> (string-to-int (format-time-string "%u" (current-time))) 5 ))

(defun is-at-home ()
  (or (is-at-night) (is-weekend)))

(defun is-at-company()
  (not (is-at-home)))

(if (is-at-night)
	(load-theme 'graham t))

;;emacs-nodewebketls
(require 'emacs-nw)

;;highlight-parentheses.el
(require 'highlight-parentheses)

;; �����Լ��������ű�
(load-file "~/.emacs.d/wdy/init.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-safe-themes (quote ("730277652b2e8eeb072604bc779a5782f7a4fbc0cf7803c69601b4be8a681d87" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
