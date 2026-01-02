(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-safe-remote-resources
   '("\\`https://fniessen\\.github\\.io/org-html-themes/setup/theme-readtheorg\\.setup\\'"
     "\\`https://github\\.com\\(?:/\\|\\'\\)"
     "\\`https://github\\.com/fniessen/org-html-themes/blob/master/org/theme-bigblow-local\\.setup\\'"
     "\\`https://fniessen\\.github\\.io/org-html-themes/org/theme-bigblow\\.setup\\'"
     "\\`https://fniessen\\.github\\.io/org-html-themes/org/theme-readtheorg\\.setup\\'"))
 '(package-selected-packages
   '(cssh multiple-cursors nice-org-html org-download org-ehtml org-xlatex
     pdf-tools preview-dvisvgm ssh ssh-config-mode))
 '(send-mail-function 'sendmail-send-it)
 '(smtpmail-smtp-server "127.0.0.1")
 '(smtpmail-smtp-service 1025))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:weight bold :height 1.4))))
 '(org-level-2 ((t (:weight bold :height 1.15))))
 '(org-level-3 ((t (:weight bold :height 1.1)))))

(require 'ox-latex)
(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))
(add-to-list 'org-latex-classes
             '("article"
               "\\documentclass{article}"
               ("\\section{%s}" . "\\section*{%s}")))
