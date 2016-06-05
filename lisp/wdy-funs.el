
;; 自己写的一些小函数
;; http://ergoemacs.org/emacs/emacs.html

;; emacs -Q --script abc.el 123
;; (message "input argument are %s" argv)

(defun now ()
  "插入当前时间"
  (interactive)
  (insert (format-time-string "[%Y-%m-%d, %a]")))

(defun wdy-buffer-replace (buff oldstr newstr)
  "替换指定buffer中所有指定字符"
  (switch-to-buffer buf)
  (goto-char (point-min)) 
  (while (search-forward oldstr) 
    (replace-match newstr)))


(defun wdy-insert-word (buf word)
  "向指定buffer头部插入一个指定单词"
  (switch-to-buffer buf)
  (insert word)
  (save-buffer)
  (kill-buffer buf))


(defun wdy-kill-word-first (buf word)  
  "删除指定buffer头部的第一个指定单词"
  (switch-to-buffer buf)
  (goto-char (point-min))
  (mark-word)
  (if (string= word
	       (buffer-substring
		(region-beginning) (region-end)))
      (kill-word 1))
  (save-buffer)
  (kill-buffer buf))

(defun wdy-edit-files (dir match word)
  "批量将指定目录下，扩展名的文件头部插入一个单词"
  (mapcar
   `(lambda (fname)
      (let ((buf (find-file fname)))
	(wdy-insert-word buf word)))
   (directory-files dir t match)))

(defun wdy-unedit-files (dir match word)
  "批量删除指定目录下，扩展名的文件头部的个单词"
  (mapcar
   `(lambda (fname)
      (let ((buf (find-file fname)))
	(wdy-kill-word-first buf word)))
   (directory-files dir t match)))


(defun wdy-run-httpd-in-current-path()
  "把当前buff文件所在目录作为webserver的root路径"
  (message (file-name-directory (buffer-file-name (current-buffer))))
  (setq httpd-root (file-name-directory (buffer-file-name (current-buffer))))
  (setq httpd-port 9090)
  (httpd-start))


(defun wdy-browser-in-server-web()
  "以http服务形式打开当前文件"
  (interactive)
  (wdy-run-httpd-in-current-path)
  (browse-url (concat "http://localhost:9090/" (buffer-name (current-buffer)))))

(defun wdy-open-in-system ()
  "在当前系统中打开文件所在目录"
  (interactive)
  (let ((dir (file-name-directory (buffer-file-name (current-buffer)))))
    (w32-shell-execute "open" dir)))

(defun wdy-open-funs-el ()
  (interactive)
  (find-file "~/.emacs.d/lisp/wdy-funs.el"))

(defun wdy-open-basic-el ()
  (interactive)
  (find-file "~/.emacs.d/lisp/init-basic.el"))


;; (defun hello () 
;;   (save-excursion
;;     (goto-char (point-min))
;;     (if (string= "Fri"
;; 		 (substring (buffer-string) 0 3))
;; 	(progn 
;; 	  (delete-char 24)
;; 	  (insert (current-time-string))
;;     (run-with-timer 1 nil 'hello)))))



;;(shell-command "explorer d:")
;(global-set-key "\C-c\ \C-r" 'wdy-open-funs-el)

(defun wdy-speak (str)
  "朗读文本"
  (with-temp-file "~/speak.vbs"
  (insert "CreateObject(\"SAPI.SpVoice\").Speak ")
  (insert (concat "\"" str "\"")))
  (shell-command "wscript ~/speak.vbs"))


(defun wdy-speak-region (start end)
  "朗读选中的文本"
  (interactive "r")
  (wdy-speak
   (buffer-substring start end)))


;; (while (= 0 (forward-word))
;;   (let ((str (buffer-substring-no-properties (line-beginning-position) (line-end-position))))
;;   (insert (concat str "\n"))))


(defun auto-export-html ()
  "主页下的org文件，修改后，自动生成html文件"
  (interactive)
  (if (string-match "wangdeyu\\.com.*\\.org"
		    (buffer-file-name (current-buffer)))
      (org-html-export-to-html)))
(add-hook 'after-save-hook 'auto-export-html)


;; 默认的日记文件
(setq diary-file "~/.emacs.d/diary.gpg")

(provide 'wdy-funs)
