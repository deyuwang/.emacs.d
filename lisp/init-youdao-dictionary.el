

(require 'youdao-dictionary)

;(setf youdao-key-from "mysite123") 
;(setf youdao-key "1212400033")
(global-set-key (kbd "C-c C-v") 'youdao-dictionary-search-at-point+)

(provide 'init-youdao-dictionary)
