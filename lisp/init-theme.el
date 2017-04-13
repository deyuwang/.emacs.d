
;根据时间、地点自动切换主题
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

(load-theme 'misterioso t)

;; (if (is-at-night)
;;     (load-theme 'solarized-dark t)
;;   (load-theme 'solarized-light t))

(defadvice text-scale-increase (around all-buffers (arg) activate)
    (dolist (buffer (buffer-list))
      (with-current-buffer buffer
        ad-do-it)))

(set-cursor-color "green")
(provide 'init-theme)


