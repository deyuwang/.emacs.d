(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp/eim")

(require 'package)
(setq package-archives  
       '(("gnu"          . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/") 
         ("melpa"        . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") 
         ("melpa-stable" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable/") 
         ("org"          . "https://mirrors.tuna.tsinghua.edu.cn/elpa/org/") 
         ("marmalade"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/marmalade/"))) 

(package-initialize)



(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
;; Calls (package-initialize)
(require 'init-elpa)      ;; Machinery for installing required packages
(require 'init-exec-path) ;; Set up $PATH


(if (eq system-type 'windows-nt)
	(require 'init-windows-nt)
  (require 'init-linux))

(require 'init-text)
(require 'init-theme)
(require 'init-auto-complete)
(require 'init-yasnippet)
(require 'init-evil)
(require 'init-javascript)
(require 'init-window-numbering)
(require 'init-helm)
(require 'init-youdao-dictionary)
(require 'ox-freemind)
(require 'init-git)

;; (require 'init-speedbar)
;; (require 'init-hide-region)
;; (require 'init-hide-lines)
;; (require 'init-highlight-parentheses)

(require 'init-basic)
(require 'wdy-funs)

(server-start)
(setq default-tab-width 4); default-tab-width is an obsolete

(provide 'put)
(put 'upcase-region 'disabled nil)
