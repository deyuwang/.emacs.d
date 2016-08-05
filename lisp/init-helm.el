
(require 'helm)

(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command);old M-x

(helm-mode 1)
(helm-autoresize-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-s") 'helm-occur)
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
(global-set-key (kbd "C-x r l") 'helm-filtered-bookmarks);; 查看书签

(setq helm-split-window-in-side-p	     t
  helm-move-to-line-cycle-in-source     t
  helm-ff-search-library-in-sexp	  t
  helm-M-x-fuzzy-match			t   ; 模糊搜索
  helm-buffers-fuzzy-matching	     t
  helm-locate-fuzzy-match		   t
  helm-recentf-fuzzy-match		  t
  helm-scroll-amount			  8
  helm-ff-file-name-history-use-recentf t)
z

(add-hook 'after-init-hookq
          (lambda ()
            (load-file helm-adaptive-history-file)))

(global-set-key (kbd "C-z") 'ace-jump-word-mode)


(provide 'init-helm)
