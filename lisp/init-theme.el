
(add-to-list 'custom-theme-load-path "~/.emacs.d/lisp/themes")

;(load-theme 'graham t)
;ҹ������ڹ�˾��ʱ��ʹ�ð�ɫ����
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


(provide 'init-theme)
