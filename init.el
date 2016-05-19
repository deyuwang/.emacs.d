(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp/eim")

(require 'package)
(add-to-list 'package-archives
			 '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(require 'init-basic)
(require 'init-text)

; 3rd lib
(require 'init-theme)
(require 'init-auto-complete)
(require 'init-yasnippet)
(require 'init-javascript)
(require 'init-window-numbering)
(require 'init-smex)
(require 'init-youdao-dictionary)
(require 'init-evil)

(require 'ox-freemind)


(if (eq system-type 'windows-nt)
	(require 'init-windows-nt)
  	(require 'init-linux))

(if (eq system-type 'windows-nt)
	(require 'init-git))

;; (require 'init-speedbar)
;; (require 'init-hide-region)
;; (require 'init-hide-lines)
;; (require 'init-highlight-parentheses)

(require 'wdy-funs)

(provide 'init)
