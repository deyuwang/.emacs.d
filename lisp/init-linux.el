

(require 'eim)

(autoload 'eim-use-package "eim" "Another emacs input method")

(set-language-environment 'Chinese-GB)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
(setq-default pathname-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(setq ansi-color-for-comint-mode t)
(setq file-name-coding-system 'utf-8)
(setq path-name-coding-system 'utf-8)

;; Tooltip 暂时还不好用
(setq eim-use-tooltip t)

(register-input-method
 "eim-py" "euc-cn" 'eim-use-package
 "拼音" "汉字拼音输入法" "py.txt")

;(set-default-font "Courier New-18")

(require 'eww)
(setq eww-search-prefix "http://www.haosou.com/s?ie=utf-8&q=")

(provide 'init-linux)
