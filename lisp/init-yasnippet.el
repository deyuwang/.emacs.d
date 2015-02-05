
(require 'yasnippet)

(yas-global-mode 1)

(add-hook 'prog-mode-hook
          '(lambda ()
             (yas-minor-mode)))

(add-to-list 'yas/root-directory "~/.emacs.d/site-lisp/yasnippet-snippets")

(yas/initialize)

(provide 'init-yasnippet)
