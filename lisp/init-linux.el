

(require 'eim)

(autoload 'eim-use-package "eim" "Another emacs input method")

;; Tooltip 暂时还不好用
(setq eim-use-tooltip t)

(register-input-method
 "eim-py" "euc-cn" 'eim-use-package
 "拼音" "汉字拼音输入法" "py.txt")

(provide 'init-linux)
