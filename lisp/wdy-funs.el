
;; 自己写的一些小函数
;; http://ergoemacs.org/emacs/emacs.html

;; emacs -Q --script abc.el 123
;; (message "input argument are %s" argv)

(defun wdy-now ()
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

(defun wdy-org-insert-style-inner ()
  "插入org-mode的html css文件"
  (interactive)
  (insert "#+INCLUDE: ~/.emacs.d/org-style/red/style_inner.css"))

(defun wdy-org-begin ()
  "开始写org文档, 默认插入标题，引入样式"
  (interactive)
  (progn
	(goto-char (point-min))
	(insert "#+TITLE: \n")
	(insert "#+OPTIONS: ^:nil \n") ;; 禁用下划线表示下标
	(insert "#+INCLUDE: ~/.emacs.d/org-style/red/style_inner.css")))

(defun wdy-org-insert-and-copy-style ()
  "插入org-mode样式饮用，并把样式文件复制到当前文件目录下"
  (interactive)
  (progn
  	(insert "#+INCLUDE: ~/.emacs.d/org-style/red/setup.org")
	(copy-file "~/.emacs.d/org-style/red/style.css" default-directory)))

;; win或者command键+鼠标左键打开光标所在位置的文件
(global-set-key (kbd "s-<mouse-1>") 'wdy-open-file-at-cursor)

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
;;(global-set-key "\C-c\ \C-r" 'wdy-open-funs-el)


;; (defun wdy-speak (string)
;;   "朗读文本"
;;   (with-temp-file "~/speak.vbs"
;;     (progn
;;       (save-excursion
;;       (insert "CreateObject(\"SAPI.SpVoice\").Speak ")
;;       (insert (concat "\"" string "\""))
;;       (start-process-shell-command  "spvoice" nil "wscript ~/speak.vbs")))))

;; (defun wdy-speak-region (start end)
;;   "朗读选中的文本中的单词"
;;   (interactive "r")
;;   (save-excursion
;;     (let ((text (buffer-substring start end)))
;;       (with-temp-buffer "*speak*"
;; 			(progn
;; 			  (insert text)
;; 			  (goto-char  (point-min))
;; 			  (while (search-forward-regexp "['\"]" nil 'move) 
;; 			    (replace-match "引号"))
;; 			  (goto-char  (point-min))
;; 			  (while (search-forward-regexp "(" nil 'move) 
;; 			    (replace-match "左括号"))
;; 			  (goto-char  (point-min))
;; 			  (while (search-forward-regexp ")" nil 'move) 
;; 			    (replace-match "右括号"))
;; 			  (goto-char  (point-min))
;; 			  (while (search-forward-regexp "[\\\\]" nil 'move) 
;; 			    (replace-match "反斜杠"))			  
;; 			  (goto-char  (point-min))
;; 			  (while (search-forward-regexp "[\n\r]" nil 'move) 
;; 			    (replace-match ","))
;; 			  (wdy-speak (buffer-string)))))))

;; (defun wdy-date ()
;;   "语音播报日期时间"
;;   (interactive)
;;   (wdy-speak (format-time-string "%m月%d号%a%H点%M分")))


(defun wdy-auto-export-html ()
  "自己网站主页下的org文件，修改保存后，自动发布成html文件"
  (interactive)
  (if (string-match "wangdeyu\\.com.*\\.org"
		    (buffer-file-name (current-buffer)))
      (org-html-export-to-html)))

;(add-hook 'after-save-hook 'wdy-auto-export-html)


(defun wdy-open-jtopo-site()
  (interactive)
  (setq httpd-root "d:\\temp\\jtopo-new-site")
  (setq httpd-port 9090)
  (httpd-start)
  (browse-url (concat "http://localhost:9090/index.html")))


;; 默认的日记文件
(setq diary-file "~/.emacs.d/diary.gpg")

(defun wdy-open-file-at-cursor ()
  "Open the file path under cursor.
If there is text selection, uses the text selection for path.
If the path starts with “http://”, open the URL in browser.
Input path can be {relative, full path, URL}.
Path may have a trailing “:‹n›” that indicates line number. If so, jump to that line number.
If path does not have a file extension, automatically try with “.el” for elisp files.
This command is similar to `find-file-at-point' but without prompting for confirmation.
URL `http://ergoemacs.org/emacs/emacs_open_file_path_fast.html'"
  (interactive)
  (let ((-path (if (use-region-p)
                   (buffer-substring-no-properties (region-beginning) (region-end))
                 (let (p0 p1 p2)
                   (setq p0 (point))
                   ;; chars that are likely to be delimiters of full path, e.g. space, tabs, brakets.
                   (skip-chars-backward "^  \"\t\n`'|()[]{}<>〔〕“”〈〉《》【】〖〗«»‹›·。\\`")
                   (setq p1 (point))
                   (goto-char p0)
                   (skip-chars-forward "^  \"\t\n`'|()[]{}<>〔〕“”〈〉《》【】〖〗«»‹›·。\\'")
                   (setq p2 (point))
                   (goto-char p0)
                   (buffer-substring-no-properties p1 p2)))))
    (if (string-match-p "\\`https?://" -path)
        (browse-url -path)
      (progn ; not starting “http://”
        (if (string-match "^\\`\\(.+?\\):\\([0-9]+\\)\\'" -path)
            (progn
              (let (
                    (-fpath (match-string 1 -path))
                    (-line-num (string-to-number (match-string 2 -path))))
                (if (file-exists-p -fpath)
                    (progn
                      (find-file -fpath)
                      (goto-char 1)
                      (forward-line (1- -line-num)))
                  (progn
                    (when (y-or-n-p (format "file doesn't exist: 「%s」. Create?" -fpath))
                      (find-file -fpath))))))
          (progn
            (if (file-exists-p -path)
                (find-file -path)
              (if (file-exists-p (concat -path ".el"))
                  (find-file (concat -path ".el"))
                (when (y-or-n-p (format "file doesn't exist: 「%s」. Create?" -path))
                  (find-file -path ))))))))))


(defun wyd-what-hexadecimal-value ()
  "Prints the decimal value of a hexadecimal string under cursor.
Samples of valid input:

  ffff
  0xffff
  #xffff
  FFFF
  0xFFFF
  #xFFFF

Test cases
  64*0xc8+#x12c 190*0x1f4+#x258
  100 200 300   400 500 600"
  (interactive )

  (let (inputStr tempStr p1 p2 )
    (save-excursion
      (search-backward-regexp "[^0-9A-Fa-fx#]" nil t)
      (forward-char)
      (setq p1 (point) )
      (search-forward-regexp "[^0-9A-Fa-fx#]" nil t)
      (backward-char)
      (setq p2 (point) ) )

    (setq inputStr (buffer-substring-no-properties p1 p2) )

    (let ((case-fold-search nil) )
      (setq tempStr (replace-regexp-in-string "^0x" "" inputStr )) ; C, Perl, …
      (setq tempStr (replace-regexp-in-string "^#x" "" tempStr )) ; elisp …
      (setq tempStr (replace-regexp-in-string "^#" "" tempStr ))  ; CSS …
      )

    (message "Hex %s is %d" tempStr (string-to-number tempStr 16 ) )
    ))

(provide 'wdy-funs)
