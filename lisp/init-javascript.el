

(require 'js2-mode)
(require 'ac-js2)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

(add-hook 'js2-mode-hook 'ac-js2-mode)

;(setq ac-js2-external-libraries '("full/path/to/a-library.js"))
;(function(){var d=document;var s=d.createElement('script');s.src='http://localhost:8080/skewer';d.body.appendChild(s);})()

(provide 'init-javascript)
