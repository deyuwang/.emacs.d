
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
(set-cursor-color "green")

;; (if t ;(is-at-night)
;; 	(load-theme 'solarized-dark t)
;; 	(load-theme 'solarized-light t))


(provide 'init-theme)
