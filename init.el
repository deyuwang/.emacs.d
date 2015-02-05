
(add-to-list 'load-path "~/.emacs.d/lisp")

(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp/eim")
(add-to-list 'load-path "~/.emacs.d/site-lisp/cl-lib")
(add-to-list 'load-path "~/.emacs.d/site-lisp/auto-complete")
(add-to-list 'load-path "~/.emacs.d/site-lisp/popup-el")
(add-to-list 'load-path "~/.emacs.d/site-lisp/yasnippet")
(add-to-list 'load-path "~/.emacs.d/site-lisp/js2-mode")
(add-to-list 'load-path "~/.emacs.d/site-lisp/highlight-parentheses")

(require 'init-basic)
(require 'init-text)

; 3rd lib
(require 'init-theme)
(require 'init-auto-complete)
(require 'init-yasnippet)
(require 'init-javascript)
(require 'init-speedbar)
(require 'init-window-numbering)
(require 'init-hide-region)
(require 'init-hide-lines)
(require 'init-smex)
(require 'init-youdao)
(require 'init-highlight-parentheses)

(if (eq system-type 'windows-nt)
	(require 'init-windows-nt)
  	(require 'init-linux))


(provide 'init)
