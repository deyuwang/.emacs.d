

(require 'youdao)

(setf youdao-key-from "mysite123") 
(setf youdao-key "1212400033")
(global-set-key (kbd "C-c C-v") 'youdao-translate-word)

(provide 'init-youdao)
