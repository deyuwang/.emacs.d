
(require 'org)

(setq org-publish-project-alist
	  '(("org-html"
		  :base-directory "~/org/"
		  :publishing-directory "~/public_html"
		  :publishing-function org-html-publish-to-html
		  :html-head "<link rel=\"stylesheet\" href=\"./style/style.css\" type=\"text/css\"/>")))

(setq org-publish-project-alist
	  '(("org"
		  :base-directory "~/org/"
		  :publishing-directory "~/public_html"
		  :publishing-function org-latex-publish-to-pdf
		  :section-numbers nil
		  :with-toc nil)))


(setq org-publish-project-alist
	  '(("orgfiles"
		 :base-directory "~/org/"
		 :base-extension "org"
		 :publishing-directory "/ssh:user@host:~/html/notebook/"
		 :publishing-function org-html-publish-to-html
		 :exclude "PrivatePage.org" ;; regexp
		 :headline-levels 3
		 :section-numbers nil
		 :with-toc nil
		 :html-head "<link rel=\"stylesheet\"href=\"../other/mystyle.css\" type=\"text/css\"/>"
		 :html-preamble t)
		("images"
		 :base-directory "~/images/"
		 :base-extension "jpg\\|gif\\|png"
		 :publishing-directory "/ssh:user@host:~/html/images/"
		 :publishing-function org-publish-attachment)
		("other"
		 :base-directory "~/other/"
		 :base-extension "css\\|el"
		 :publishing-directory "/ssh:user@host:~/html/other/"
		 :publishing-function org-publish-attachment)
		("website" :components ("orgfiles" "images" "other"))))


(provide 'init-org-mode)
