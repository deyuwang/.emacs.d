;;----------------------------------------------------------------------------
;; 文本操作的一些函数
;;----------------------------------------------------------------------------

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


(provide 'init-text)
