;;; emacs-nodewebkit.el --- Integration nodewebkit
;;; nodewebkit: https://github.com/shama/nodewebkit

;; Copyright (C) 2012  Taiki SUGAWARA

;; Author: Deyu Wang <wangdeyu97@163.com>
;; Keywords: url
;; URL: https://github.com/deyuwang/emacs-nw.el

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:
(require 'shell)
(require 'url-util)
(require 'request)


(defvar temp-file "~/request.html")
(defvar auto-doc-reg "request\\.html$")
(defvar base-url "http://127.0.0.1:13678")
(defvar nw-server-path "~/.emacs.d/emacs-nw/emacs-nw-server")


(defun encodeUrl(url)
  (url-hexify-string
   (encode-coding-string url 'utf-8)))

(defun decodeUrl(url)
  (decode-coding-string 
   (url-unhex-string (string-to-unibyte url)) 'utf-8))


(defun pull-doc()
  "Get and write browser's content to file: ~/request.html"
  (interactive)
  (request
   (concat base-url "/content")
   :parser 'buffer-string
   :success
   (function* (lambda (&key data &allow-other-keys)
				(when data
				  (find-file temp-file)
					(erase-buffer)
					(insert data))))))


(defun pull-doc-insert()
  "Insert browser's content to current buffer"
  (interactive)
  (request
   (concat base-url "/content")
   :parser 'buffer-string
   :success
   (function* (lambda (&key data &allow-other-keys)
				(when data
				  (with-current-buffer (current-buffer)
					(erase-buffer)
					(insert data)))))))

(defun push-doc()
  "Push current-buffer to browser"
  (interactive)
  (request
   (concat base-url "/content")
   :type "PUT"
   :data (concat "content=" (buffer-string))
   :success (function*
			 (lambda (&key data &allow-other-keys)
			   (message "set ok")))))

;; Eval js in browser
(global-set-key (kbd "<f6>") 'push-js)
(defun push-js()
  "Execute js"
  (interactive)
  (request
   (concat base-url "/js")
   :type "PUT"
   :data (concat "js=" (encodeUrl (buffer-string)))
   :success (function*
			 (lambda (&key data &allow-other-keys)
			   (message "exec js ok.")))))

(defun run-doc-server()
  ""
  (interactive)
  (progn
	(shell-cd nw-server-path)
	(shell-command "nw ./ &")))

;;Auto push ~/request.html
(add-hook 'after-save-hook (lambda() (auto-deploy-to-webkit)))

(defun auto-deploy-to-webkit()
  ""
  (interactive)
  (if (string-match auto-doc-reg buffer-file-name)
	  (progn
		(message "ok")
		(push-doc))))

(provide 'emacs-nw)
;;; emacs-nw.el ends here
