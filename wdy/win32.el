

;;--------------------���Ի����ַ�������(utf-8)------------------
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

;;Ĭ������
;(set-default-font "Courier New-12")

;;����ճ�����������
;(set-clipboard-coding-system 'euc-cn)

;;Tramp Զ��(����plink.exe�ڵ�ǰpath�ɷ���)
(require 'tramp) 
(setq tramp-default-method "plink")
