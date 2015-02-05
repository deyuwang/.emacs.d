
(require 'sr-speedbar)

;; 不使用图标  
(setq speedbar-use-images nil)    

;; speedbar的宽度  
(setq sr-speedbar-width 25) 

;; 放到左边去  
(setq sr-speedbar-right-side nil) 
(global-set-key (kbd "<f7>") (lambda()    
                               (interactive)    
                               (sr-speedbar-toggle)))
;(add-hook 'after-init-hook '(lambda () (sr-speedbar-toggle)));开启程序即启用

(provide 'init-speedbar)
