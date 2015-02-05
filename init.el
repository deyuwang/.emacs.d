;;------------------------基本设置开始------------------------
(add-to-list 'load-path "~/.emacs.d/lisp")

;;窗口初始大小
(setq initial-frame-alist '((top . 0) (left . 0) (width . 80) (height . 37)))

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
;(setq default-fill-column 80)

;;设置行间距
;(setq-default line-spacing 2)

;;不要生成临时文件
(setq-default make-backup-files nil);

;;Ctrl+Z 在窗口模式下不最小化Eamcs
;(if (eq window-system 'x) (global-set-key [(control z)] 'suspend-emacs))

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
(menu-bar-mode 0)
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
;;------------------------扩展设置开始------------------------
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

;; 在当前所有打开的buffer中替换字符串-
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

;; 在当前所有打开的buffer中替换字符串
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

;;----- 文本行操作-开始---------
;;Alt+上下键，移动一行内容
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

;;Alt+w 复制光标所在一整行，Alt+k，复制当前行光标后面的内容
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

;; Alt+;注释、反注释
(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command. If no region is selected and current line is not blank and we are not at the end of the line, then comment current line. Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'qiang-comment-dwim-line)
;;----- 文本行操作-结束---------

;;--------------------扩展设置结束---------------

;;package
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)


;;------------------- 第三方包开始 --------------
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



;; --------------- 自动完成 -----------------------

;; auto-complate
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/lisp/auto-complete/ac-dict")
(ac-config-default)

;; Ctrl+回车触发
;(setq ac-auto-start nil) ;auto complete using clang is CPU sensitive
;(ac-set-trigger-key "<C-return>")
;; backspace的删除后仍旧可以触发ac补全
(setq ac-trigger-commands
      (cons 'backward-delete-char-untabify ac-trigger-commands))

;; -------------- 文本模板 --------------------
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
;夜晚或者在公司的时候使用暗色背景
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
;; 不使用图标  
(setq speedbar-use-images nil)    
;; speedbar的宽度  
(setq sr-speedbar-width 25) 
;; 放到左边去  
(setq sr-speedbar-right-side nil) 
(global-set-key (kbd "<f7>") (lambda()    
                               (interactive)    
                               (sr-speedbar-toggle)))
;(add-hook 'after-init-hook '(lambda () (sr-speedbar-toggle)));;开启程序即启用

;;youdao
(require 'youdao)
(setf youdao-key-from "mysite123") 
(setf youdao-key "1212400033")
(global-set-key (kbd "C-c C-v") 'youdao-translate-word)


;; 加载自己的其他脚本
(load-file "~/.emacs.d/wdy/init.el")

;;hide region
(require 'hide-region)
(global-set-key (kbd "C-c r") 'hide-region-hide)
(global-set-key (kbd "C-c R") 'hide-region-unhide)


;; hide lines
(require 'hide-lines)
(global-set-key (kbd "C-c l") 'hide-lines)
(global-set-key (kbd "C-c L") 'show-all-invisible)

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