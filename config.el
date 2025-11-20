;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
(setq doom-font (font-spec :family "JetBrains Mono"))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox-light)
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;; (setq display-line-numbers-type nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(use-package org
  :config
  (setq org-startup-with-latex-preview t))

(setq fancy-splash-image (expand-file-name "~/org/RunesRougesEmacs.png" doom-user-dir))

(setq org-hide-emphasis-markers t)
(custom-set-faces
 '(org-level-1 ((t (:weight bold :height 1.4))))
 '(org-level-2 ((t (:weight bold :height 1.15))))
 '(org-level-3 ((t (:weight bold :height 1.1))))
)
(set-face-attribute 'org-level-1 nil :height 1.4)
(set-face-attribute 'org-level-2 nil :height 1.15)
(set-face-attribute 'org-level-3 nil :height 1.1)
(setq display-time-interval 59)

(after! treemacs
  (map! :leader
        :prefix "e"
        :desc "Treemacs" "e" #'treemacs))

(global-display-line-numbers-mode +1)

;; PDF things
(require 'ox-latex)
(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))
(add-to-list 'org-latex-classes
             '("article"
               "\\documentclass{article}"
               ("\\section{%s}" . "\\section*{%s}")))


;; For better images inserting
(require 'org)
(setq org-display-inline-images t)      ; affichage automatique
(setq org-image-actual-width 200)       ; largeur adaptée au texte

;; Another method for inserting images (it's to hard for me to insert pictures like everyone on doom emacs ^^)
;; https://github.com/abo-abo/org-download
(require 'org-download)

;; Drag-and-drop to `dired`
(add-hook 'dired-mode-hook 'org-download-enable)

;; Latex
(setq +latex-viewers '(pdf-tools))
(defun my-org-md-filter-anchors (text back-end info)
  "Masquer les balises <a id=\"orgXXXX\"></a> dans l’export Markdown."
  (when (eq back-end 'md)
    (replace-regexp-in-string "<a id=\"org[0-9a-f]+\"></a>" "" text)))

(add-to-list 'org-export-filter-final-output-functions #'my-org-md-filter-anchors)

;; Markdown preview with an fancy theme in the browser (same has github)
;; Source: https://adam.kruszewski.name/2022-09-17-emacs-markdown-mode-in-browser-preview.html
(use-package markdown-mode
  :hook ((markdown-mode . auto-fill-mode))
  :mode ((".md\\'" . gfm-mode))
  :config
  (setq
   markdown-enable-wiki-links t
   markdown-italic-underscore t
   markdown-asymmetric-header t
   markdown-make-gfm-checkboxes-buttons t
   markdown-gfm-uppercase-checkbox t
   markdown-enable-math t
   markdown-content-type "application/xhtml+xml"
   markdown-css-paths '("https://cdn.jsdelivr.net/npm/github-markdown-css/github-markdown.min.css")
   markdown-xhtml-header-content "
      <style>
      body {
        box-sizing: border-box;
        max-width: 740px;
        width: 100%;
        margin: 40px auto;
        padding: 0 10px;
      }
      </style>
      <script>
      document.addEventListener('DOMContentLoaded', () => {
        document.body.classList.add('markdown-body');
      });
      </script>
      " ))

(defun markdown-filter-impatient-mode (buffer)
  "Markdown filter for impatient-mode"
  (princ
   (with-temp-buffer
     (let ((tmpname (buffer-name)))
       (set-buffer buffer)
       (set-buffer (markdown tmpname))
       (format "
 <!DOCTYPE html>
  <html>
  <head>
      <title>Markdown Preview</title>
      <meta name='viewport' content=
      'width=device-width, initial-scale=1'>
      <link rel='stylesheet' href=
      'https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/4.0.0/github-markdown.min.css'
      integrity=
      'sha512-Oy18vBnbSJkXTndr2n6lDMO5NN31UljR8e/ICzVPrGpSud4Gkckb8yUpqhKuUNoE+o9gAb4O/rAxxw1ojyUVzg=='
      crossorigin='anonymous'>
      <!-- https://github.com/sindresorhus/github-markdown-css -->
      <link rel='stylesheet' href=
      'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.2.0/styles/github.min.css'>
      <!-- https://highlightjs.org -->

      <style>
      .markdown-body {
          box-sizing: border-box;
          margin: 0 auto;
          max-width: 980px;
          min-width: 200px;
          padding: 45px;
       }

       @media (max-width: 767px) {
           .markdown-body {
               padding: 15px;
           }
       }
      </style>
  </head>
  <body>
      <article class='markdown-body'>
          %s
      </article>
      <script src=
      'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.2.0/highlight.min.js'></script>

      <script>

      hljs.highlightAll();
      </script>
  </body>
  </html>"
               (buffer-string))))
   (current-buffer)))


(defun impatient-markdown-preview ()
  (interactive)
  (impatient-mode)
  (imp-set-user-filter `markdown-filter-impatient-mode)
  (httpd-start)
  (imp-visit-buffer))

;;
(setq confirm-kill-emacs nil)
