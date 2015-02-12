;;----------------------------------------------------------------------------
;; һЩ�������ã������������⣩
;;----------------------------------------------------------------------------
;;���ڳ�ʼ��С
(setq initial-frame-alist '((top . 0) (left . 0) (width . 83) (height . 37)))

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
(setq default-fill-column 80)

;;�����м��
(setq-default line-spacing 2)

;;��Ҫ������ʱ�ļ�
(setq-default make-backup-files nil);

;;Ctrl+Z �ڴ���ģʽ�²���С��Eamcs
;;(if (eq window-system 'x) (global-set-key [(control z)] 'suspend-emacs))

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
;(menu-bar-mode 0)
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

(provide 'init-basic)
