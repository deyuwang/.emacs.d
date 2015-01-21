
;;------------------------基本设置开始------------------------
(add-to-list 'load-path "~/.emacs.d")

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
(setq column-number-mode 0)
;(setq line-number-mode t)
;;在左侧显示行号
(global-linum-mode 'linum-mode)

;;set mark(进入选择文本模块）
(global-set-key (kbd "M-SPC") 'set-mark-command)

;;光标靠近鼠标的时候，让鼠标自动让开，别挡住视线
;(mouse-avoidance-mode 'animate)

;;平滑滚动, 在光标在最后一行的时候，继续下一行跳动的时候，有明显的跳动感觉
(setq scroll-margin 2 scroll-conservatively 10000)

;;禁止自动保存
(auto-save-mode nil)

;;默认显示 80列就换行
(setq default-fill-column 80)

;;设置行间距
(setq-default line-spacing 2)

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
;(menu-bar-mode nil)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;;buffer 窗口快捷
;(global-set-key [f10] 'split-window-vertically);F10分割窗口
;(global-set-key [f11] 'delete-other-windows);F11 关闭其它窗口
;(global-set-key [C-return] 'kill-this-buffer);C-return关闭当前buffer

(global-set-key (kbd "<f5>") 'kmacro-call-macro);播放宏
(define-key  key-translation-map [f9] (kbd "C-x r l")) ;查看书签
(define-key  key-translation-map [f10] (kbd "C-x r m")) ;增加书签
(define-key  key-translation-map [f11] (kbd "C-x"))
(define-key  key-translation-map [f12] (kbd "C-c"))


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

;;------------------------扩展设置开始------------------------
;;透明不透明
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
;;----- 文本行操作-结束---------

;;--------------------扩展设置结束---------------



;;------------------- 第三方包开始 --------------
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


;; --------------- 自动完成 -----------------------

;; auto-complate
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/ac-dict")
(ac-config-default)

;; Ctrl+回车触发
(setq ac-auto-start nil) ;auto complete using clang is CPU sensitive
(ac-set-trigger-key "<C-return>")
;; backspace的删除后仍旧可以触发ac补全
(setq ac-trigger-commands
      (cons 'backward-delete-char-untabify ac-trigger-commands))

;; -------------- 文本模板 --------------------
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
;夜晚或者在公司的时候使用暗色背景
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

;; 加载自己的其他脚本
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
