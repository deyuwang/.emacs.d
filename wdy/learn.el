


;;������laxt���滻
;\documentclass{ctexart}


(add-hook 'speedbar-mode-hook
          '(lambda ()
             (message "Hello")))

;;ѧϰElisp��

(define-prefix-command '��-map)
(global-set-key (kbd "��") '��-map)
(define-key ��-map (kbd "��") 'save-buffer)

(define-prefix-command '��-map)
(global-set-key (kbd "��") '��-map)
(define-key ��-map (kbd "��") 'save-buffer)


;����������
;�����Ҿ�һ��������˵�� prefix command ����ι����ġ����ǿ��� �����ĵ� ���� �����ְ󶨵�save-buffer. ���������������뷨 ���롰���̡�������ʱ���Ϳ��԰ѵ�ǰ buffer ����������
(define-prefix-command '��-map)
(global-set-key (kbd "��") '��-map)
(define-key ��-map (kbd "��") 'save-buffer)
;��Ȥ�ɣ�����Բµ�����������ô���°ɣ�̫�����ǲ��ǣ������� �롰�桱��ʱ�򣬿��� minibuffer ��������
;../images/bind-cun.png
;������Ϊ���ǰѡ��桱����ְ󶨵��� ��-map ��� prefix-command. ���������桱��ʱ��Emacs �ͻ�ȴ���һ����� ��������Ƕ����� ��-map ��� map ��ġ����������̡����ͻ�ִ �� save-buffer �ˡ�
;����ע�⣬�����Ҫ���ĵ������롰���̡������־͵��ȴ� C-q �ˡ� �ղ��Ҿʹ��˺ö�� C-q�����۰���������һЩ�����õĴ���ȽϺã� ���߼�һ�� ctrl ʲô��ǰ׺�����������"C-z ����"��
(define-prefix-command 'ctl-z-map)
(global-set-key (kbd "C-z") 'ctl-z-map)
(define-key ctl-z-map (kbd "����") 'save-buffer)

;�����Ǹ� bt һ��:
(define-prefix-command 'ctl-z-map)
(global-set-key (kbd "C-z") 'ctl-z-map)
(define-key ctl-z-map (kbd "���Ҵ�������") 'save-buffer)
;��Ӵ��yes sir!!

(defun loop-alpha ()
  (interactive)
  (let ((h (car alpha-list)))
    ((lambda (a ab)
       (set-frame-parameter (selected-frame) 'alpha (list a ab))
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))) (car h) (car (cdr h)))
    (setq alpha-list (cdr (append alpha-list (list h))))))

;; �ڵ�ǰ���д򿪵�buffer���滻�ַ���-
(defun query-replace-regexp-in-open-buffers (arg1 arg2)
  "query-replace in all open files"
  (interactive "sRegexp:\nsReplace with:") ;;����
  (mapcar
   (lambda (x)
     (find-file x)             ;; �൱��C-x C-f ���������л���
     (save-excursion           ;; ����ǰ��һЩ״̬�������������λ�á�buff�ȵȣ�����ִ�������ݺ󣬻ָ�
       (goto-char (point-min)) ;; ������ƶ����ĵ��ʼ��λ��
       (query-replace-regexp arg1 arg2))) ;; ִ�в�ѯ�滻
   (delq                     ;; ���˵��б���Ϊnil��Ԫ��
    nil
    (mapcar                  ;; �൱��map
     (lambda (x)
       (buffer-file-name x)) ;; ��ȡbuffer���ļ�����·������ʱ�Ļ�ȡ����Ϊnil��
     (buffer-list)))))       ;; ��ȡ����buffer

;; �ڵ�ǰ���д򿪵�buffer���滻�ַ���
(defun query-replace-in-open-buffers (arg1 arg2)
  "query-replace in all open files"
  (interactive "sRegexp:\nsReplace with:")
  (mapcar
   (lambda (x)
     (find-file x)
     (save-excursion
       (goto-char (point-min))
       (query-replace arg1 arg2)))
   (delq
    nil
    (mapcar
     (lambda (x)
       (buffer-file-name x))
     (buffer-list)))))


;;----- �ı��в���-��ʼ---------
;;Alt+���¼����ƶ�һ������
;;move line up down
(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp))) 
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg))
        (forward-line -1))
      (move-to-column column t)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

(global-set-key [M-up] 'move-text-up)
(global-set-key [M-down] 'move-text-down)

;;Alt+w ���ƹ������һ���У�Alt+k�����Ƶ�ǰ�й����������
;; Smart copy, if no region active, it simply copy the current whole line
(defadvice kill-line
  (before check-position activate)
  (if (member major-mode
			  '(emacs-lisp-mode scheme-mode lisp-mode c-mode c++-mode objc-mode js-mode latex-mode plain-tex-mode))
	  (if (and (eolp) (not (bolp))) ;;eolp ����Ƿ�����β; bolp����Ƿ�������
		  (progn (forward-char 1) (just-one-space 0) (backward-char 1)))))

 (defadvice kill-ring-save (before slick-copy activate compile)
   "When called interactively with no active region, copy a single line instead."
   (interactive (if mark-active (list (region-beginning) (region-end))
				  (message "Copied line")
					(list (line-beginning-position) (line-beginning-position 2)))))

 (defadvice kill-region (before slick-cut activate compile)
   "When called interactively with no active region, kill a single line instead."
   (interactive (if mark-active (list (region-beginning) (region-end)) (list (line-beginning-position) (line-beginning-position 2)))))

;; Copy line from point to the end, exclude the line break
(defun qiang-copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (point) (line-end-position))
  (line-beginning-position (+ 1 arg)))
(global-set-key (kbd "M-k") 'qiang-copy-line)




;; Insert a file and convert it to an org table
(defun aleblanc/insert-file-as-org-table (filename)
  "Insert a file into the current buffer at point, and convert it to an org table."
  (interactive (list (ido-read-file-name "csv file: ")))
  (let* ((start (point))
    (end (+ start (nth 1 (insert-file-contents filename)))))
    (org-table-convert-region start end)
    ))


;;org-mode����PDF
�޸�
\documentclass{ctexart}
\hypersetup{
    CJKbookmarks=true, //������ôһ��
��ǩ���룺gbk2uni 

org-mode������Beamer�õ�Ƭģ��
http://www.douban.com/note/270383500/
����:
http://hahack.tk/org-beamer-cn/

;; org-mode����PDF�������⣨article/beamer)
�޸ģ�ox-beamer.el��ox-latex.el

\documentclass
\usepackage{CJK} �������

\hypersetup{
CJKbookmarks=true, �������
 pdfkeywords={},

\begin{document}
\begin{CJK*}{GBK}{song}����һ�У�

\end{CJK*} ����һ��
\end{document}
