


;;---------- ���뷨ƴ�� -----------
(add-to-list 'load-path "~/.emacs.d/eim")

(autoload 'eim-use-package "eim" "Another emacs input method")
;; Tooltip ��ʱ��������
(setq eim-use-tooltip t)

(register-input-method
 "eim-py" "euc-cn" 'eim-use-package
 "ƴ��" "����ƴ�����뷨" "py.txt")