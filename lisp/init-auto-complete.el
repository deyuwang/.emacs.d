
(require 'auto-complete-config)

(add-to-list 'ac-dictionary-directories
			 "~/.emacs.d/site-lisp/auto-complete/ac-dict")

(ac-config-default)

;; Ctrl+回车触发
;(setq ac-auto-start nil) ;auto complete using clang is CPU sensitive
;(ac-set-trigger-key "<C-return>")

;; backspace的删除后仍旧可以触发ac补全
(setq ac-trigger-commands
      (cons 'backward-delete-char-untabify ac-trigger-commands))

(provide 'init-auto-complete)
