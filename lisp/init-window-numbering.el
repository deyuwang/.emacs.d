

(require 'window-numbering)

(setq window-numbering-assign-func
      (lambda () (when (equal (buffer-name) "*Calculator*") 9)))
(window-numbering-mode)


(provide 'init-window-numbering)
