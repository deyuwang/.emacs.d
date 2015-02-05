


;;导出成laxt，替换
;\documentclass{ctexart}


(add-hook 'speedbar-mode-hook
          '(lambda ()
             (message "Hello")))

;;学习Elisp用

(define-prefix-command '存-map)
(global-set-key (kbd "存") '存-map)
(define-key 存-map (kbd "盘") 'save-buffer)

(define-prefix-command '提-map)
(global-set-key (kbd "提") '提-map)
(define-key 存-map (kbd "交") 'save-buffer)


;绑定中文命令
;现在我举一个例子来说明 prefix command 是如何工作的。我们可以 把中文的 存盘 两个字绑定到save-buffer. 这样你用中文输入法 敲入“存盘”两个字时，就可以把当前 buffer 保存起来。
(define-prefix-command '存-map)
(global-set-key (kbd "存") '存-map)
(define-key 存-map (kbd "盘") 'save-buffer)
;有趣吧？你可以猜到这里面是怎么回事吧？太简单了是不是？当你输 入“存”的时候，看到 minibuffer 是这样：
;../images/bind-cun.png
;这是因为我们把“存”这个字绑定到了 存-map 这个 prefix-command. 当读到“存”的时候，Emacs 就会等待下一条命令， 这个命令是定义在 存-map 这个 map 里的。它读到“盘”，就会执 行 save-buffer 了。
;不过注意，你真的要在文档里输入“存盘”两个字就得先打 C-q 了。 刚才我就打了好多次 C-q，真累啊。还是用一些不常用的词组比较好， 或者加一个 ctrl 什么的前缀，就像这个，"C-z 存盘"。
(define-prefix-command 'ctl-z-map)
(global-set-key (kbd "C-z") 'ctl-z-map)
(define-key ctl-z-map (kbd "存盘") 'save-buffer)

;看我们更 bt 一点:
(define-prefix-command 'ctl-z-map)
(global-set-key (kbd "C-z") 'ctl-z-map)
(define-key ctl-z-map (kbd "给我存盘啦！") 'save-buffer)
;嗨哟！yes sir!!

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
  (interactive "sRegexp:\nsReplace with:") ;;交互
  (mapcar
   (lambda (x)
     (find-file x)             ;; 相当于C-x C-f （这里是切换）
     (save-excursion           ;; 将当前的一些状态保存起来（光标位置、buff等等），等执行完内容后，恢复
       (goto-char (point-min)) ;; 将光标移动到文档最开始的位置
       (query-replace-regexp arg1 arg2))) ;; 执行查询替换
   (delq                     ;; 过滤掉列表中为nil的元素
    nil
    (mapcar                  ;; 相当于map
     (lambda (x)
       (buffer-file-name x)) ;; 获取buffer的文件名和路径（临时的获取不到为nil）
     (buffer-list)))))       ;; 获取所有buffer

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
	  (if (and (eolp) (not (bolp))) ;;eolp 光标是否在行尾; bolp光标是否在行首
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




;; Insert a file and convert it to an org table
(defun aleblanc/insert-file-as-org-table (filename)
  "Insert a file into the current buffer at point, and convert it to an org table."
  (interactive (list (ido-read-file-name "csv file: ")))
  (let* ((start (point))
    (end (+ start (nth 1 (insert-file-contents filename)))))
    (org-table-convert-region start end)
    ))


;;org-mode导出PDF
修改
\documentclass{ctexart}
\hypersetup{
    CJKbookmarks=true, //增加这么一行
书签乱码：gbk2uni 

org-mode的中文Beamer幻灯片模板
http://www.douban.com/note/270383500/
中文:
http://hahack.tk/org-beamer-cn/

;; org-mode导出PDF中文问题（article/beamer)
修改：ox-beamer.el、ox-latex.el

\documentclass
\usepackage{CJK} 插入该行

\hypersetup{
CJKbookmarks=true, 插入该行
 pdfkeywords={},

\begin{document}
\begin{CJK*}{GBK}{song}插入一行：

\end{CJK*} 插入一行
\end{document}
