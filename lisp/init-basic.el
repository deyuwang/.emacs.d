;;----------------------------------------------------------------------------
;; 一些基本设置（不含第三方库）
;;----------------------------------------------------------------------------
;;窗口初始大小
(setq initial-frame-alist '((top . 0) (left . 0) (width . 83) (height . 37)))

;;设置打开文件的缺省目录
;(setq default-directory "E:/")

;;去掉启动欢迎界面
(setq inhibit-startup-message t)

;;Ctrl+鼠标滚轮缩放字体
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;;不要总是没完没了的问yes or no, 为什么不能用 y/n
(fset 'yes-or-no-p 'y-or-n-p)

;;打开高亮 #M-x global-font-lock-mode
(global-font-lock-mode t)

;;示括号匹配
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;;显示列号
(setq column-number-mode t)
;;(setq line-number-mode nil)
;;在左侧显示行号
(global-linum-mode 'linum-mode)

;;set mark(进入选择文本模块）
(global-set-key (kbd "M-SPC") 'set-mark-command)

;;光标靠近鼠标的时候，让鼠标自动让开，别挡住视线
;(mouse-avoidance-mode 'animate)

;;平滑滚动, 在光标在最后一行的时候，继续下一行跳动的时候，有明显的跳动感觉
(setq scroll-margin 2 scroll-conservatively 10000)

;;禁止自动保存
;;(auto-save-mode t)


;;默认显示 80列就换行
(setq default-fill-column 80)

;;设置行间距
(setq-default line-spacing 2)

;;不要生成临时文件
(setq-default make-backup-files nil);

;;Ctrl+Z 在窗口模式下不最小化Eamcs
;;(if (eq window-system 'x) (global-set-key [(control z)] 'suspend-emacs))

;;高亮显示当前行
;(global-hl-line-mode)

;;在下面栏中显示时间
(display-time-mode 1)

;;使用24小时制
(setq display-time-24hr-format t)

;;光标为竖线
(setq-default cursor-type 'bar)

;;光标颜色
;(set-cursor-color "green")

;;背景颜色; 草绿色
;(set-background-color "#CBE8CF")

;;隐藏菜单栏、右侧的滚动条
;(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; 开启ido-mode
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-everywhere t)
(ido-mode 1)

;;buffer 窗口快捷
;;(global-set-key [F12] 'delete-other-windows);关闭其它窗口
(global-set-key "\M-9" 'kill-this-buffer);关闭当前buffe
(global-set-key "\M-0" 'delete-window); 关闭窗口

(global-set-key (kbd "<f5>") 'kmacro-call-macro);播放宏
(define-key  key-translation-map [f9] (kbd "C-x r l")) ;查看书签
(define-key  key-translation-map [f10] (kbd "C-x r m")) ;增加书签
;(define-key  key-translation-map [f11] (kbd "C-x"))
(define-key  key-translation-map [f12] (kbd "C-x"))

;; 光标所在行不变，上下滚动
(global-set-key "\M-p" '(lambda () (interactive) (scroll-down 1)))
(global-set-key "\M-n" '(lambda () (interactive) (scroll-up 1)))

;; 回车 改成回车并缩进
(global-set-key (kbd "RET") 'newline-and-indent)

;; 设置Tab为4个字符
(setq indent-tabs-mode nil)
(setq default-tab-width 4)
(setq tab-width 4)

;;Emacs顶部标题栏显示完整文件名
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


;; 可以补全各种内容
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


;;透明不透明
(global-set-key [(f8)] 'loop-alpha)
(setq alpha-list '((88 55) (100 100)))

(defun loop-alpha ()
  (interactive)
  (let ((h (car alpha-list)))
    ((lambda (a ab)
       (set-frame-parameter (selected-frame) 'alpha (list a ab))
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))) (car h) (car (cdr h)))
    (setq alpha-list (cdr (append alpha-list (list h))))))


;;自动备份
(setq
 backup-by-copying t ; 自动备份
 backup-directory-alist '(("." . "~/.emacs.d/auto-save-list")) ; 自动备份在目录"~/.emacs.d/auto-save-list"下
 delete-old-versions t ; 自动删除旧的备份文件
 kept-new-versions 6 ; 保留最近的6个备份文件
 kept-old-versions 2 ; 保留最早的2个备份文件(前两个是最早的，后4个是最近的)
 version-control t ; 多次备
 vc-make-backup-files t); 有版本控制也做备份

(setq make-backup-files t)

;; customization
(setq custom-file "~/.emacs.d/lisp/custom.el")
(load "~/.emacs.d/lisp/custom" t)

(provide 'init-basic)
