(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp/eim")

(require 'package)
;(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; We include the org repository for completeness, but don't normally
;; use it.
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))

;;; Also use Melpa for most packages
(add-to-list 'package-archives `("melpa" . ,(if (< emacs-major-version 24)
                                                "http://melpa.org/packages/"
                                              "https://melpa.org/packages/")))

;(package-initialize)


(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
;; Calls (package-initialize)
(require 'init-elpa)      ;; Machinery for installing required packages
(require 'init-exec-path) ;; Set up $PATH


(if (eq system-type 'windows-nt)
	(require 'init-windows-nt)
  (require 'init-linux))

(require 'init-basic)
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

(require 'wdy-funs)

(server-start)
(setq default-tab-width 4); default-tab-width is an obsolete

(provide 'put)
