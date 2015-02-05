
(require 'auto-complete-config)

(add-to-list 'ac-dictionary-directories
			 "~/.emacs.d/site-lisp/auto-complete/ac-dict")

(ac-config-default)

;; Ctrl+�س�����
;(setq ac-auto-start nil) ;auto complete using clang is CPU sensitive
;(ac-set-trigger-key "<C-return>")

;; backspace��ɾ�����Ծɿ��Դ���ac��ȫ
(setq ac-trigger-commands
      (cons 'backward-delete-char-untabify ac-trigger-commands))

(provide 'init-auto-complete)
