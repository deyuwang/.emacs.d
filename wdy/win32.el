

;;--------------------语言环境字符集设置(utf-8)------------------
;(set-language-environment 'Chinese-GB)
;(set-keyboard-coding-system 'utf-8)
;(set-clipboard-coding-system 'utf-8)
;(set-terminal-coding-system 'utf-8)
;(set-buffer-file-coding-system 'utf-8)
;(set-default-coding-systems 'utf-8)
;(set-selection-coding-system 'utf-8)
;(modify-coding-system-alist 'process "*" 'utf-8)
;(setq default-process-coding-system '(utf-8 . utf-8))
;(setq-default pathname-coding-system 'utf-8)
;(set-file-name-coding-system 'utf-8)
;(setq ansi-color-for-comint-mode t)
;(setq file-name-coding-system 'utf-8)
;(setq path-name-coding-system 'utf-8)

;(if (eq system-type 'windows-nt) (setq file-name-coding-system 'gbk))

;;默认字体
;(set-default-font "Courier New-12")

;;汉字粘贴乱码的问题
;(set-clipboard-coding-system 'euc-cn)

;;Tramp 远程(依赖plink.exe在当前path可访问)
(require 'tramp) 
(setq tramp-default-method "plink")
