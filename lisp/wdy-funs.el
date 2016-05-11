;; 自己写的一些小函数

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


(defun wdy-open-funs-el ()
  "开始编辑自己的函数库"
  (interactive)
  (find-file "~/.emacs.d/lisp/wdy-funs.el"))


;;(shell-command "explorer d:")
;(global-set-key "\C-c\ \C-r" 'wdy-open-funs-el)



(provide 'wdy-funs)
