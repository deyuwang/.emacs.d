
(require 'sr-speedbar)

;; ��ʹ��ͼ��  
(setq speedbar-use-images nil)    

;; speedbar�Ŀ��  
(setq sr-speedbar-width 25) 

;; �ŵ����ȥ  
(setq sr-speedbar-right-side nil) 
(global-set-key (kbd "<f7>") (lambda()    
                               (interactive)    
                               (sr-speedbar-toggle)))
;(add-hook 'after-init-hook '(lambda () (sr-speedbar-toggle)));������������

(provide 'init-speedbar)
