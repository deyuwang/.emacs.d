

(require 'eim)

(autoload 'eim-use-package "eim" "Another emacs input method")

;; Tooltip ��ʱ��������
(setq eim-use-tooltip t)

(register-input-method
 "eim-py" "euc-cn" 'eim-use-package
 "ƴ��" "����ƴ�����뷨" "py.txt")


(require 'eww)
(setq eww-search-prefix "http://www.haosou.com/s?ie=utf-8&q=")

(provide 'init-linux)
