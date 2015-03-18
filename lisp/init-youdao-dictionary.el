;(require 'youdao-dictionary)
;(global-set-key (kbd "C-c C-v") 'youdao-dictionary-search-at-point+)

(require 'youdao)
(setf youdao-key-from "mysite123") 
(setf youdao-key "1212400033")
(global-set-key (kbd "C-c C-v") 'youdao-translate-word)

(provide 'init-youdao-dictionary)

