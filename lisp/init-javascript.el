(require 'js2-mode)
(require 'ac-js2)
(require 'nodejs-repl)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

(add-hook 'js2-mode-hook 'ac-js2-mode)

;;(setq ac-js2-external-libraries '("full/path/to/a-library.js"))
;;(function(){var d=document;var s=d.createElement('script');s.src='http://localhost:8080/skewer';d.body.appendChild(s);})()

;;Nodejs
(defun js-eval-region(start end)
  "Send region to `nodejs-repl' process."
  (interactive "r")
  (save-selected-window
    (save-excursion (nodejs-repl)))
  (comint-send-region (get-process nodejs-repl-process-name)
                      start end))

(defun js-eval-last-sexp()
  "Send region to `nodejs-repl' process."
  (interactive)
  (js-eval-region
   (save-excursion (backward-sexp) (point)) (point)))


(defun js-eval-buffer ()
  "Send region to `nodejs-repl' process."
  (interactive)
  (save-selected-window
	(js-eval-region (point-min) (point-max))))


(provide 'init-javascript)
