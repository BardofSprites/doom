;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Daniel Pinkston"
      user-mail-address "earlgreytea42@outlook.com")

(setq doom-font(font-spec :family "Iosevka" :size 20)
      doom-big-font(font-spec :family "Iosevka" :size 30)
      doom-variable-pitch-font (font-spec :family "Roboto" :style "Regular" :size 12 :weight 'regular))

;; sets the cursor to always be a block
(setq evil-insert-state-cursor 'box)

;; make the cursor blinking
(blink-cursor-mode 1)

;; sets the theme
(setq doom-theme 'catppuccin)
(setq catppuccin-flavor 'macchiato)

(setq display-line-numbers-type `relative)

;; org setup
(setq org-directory "~/Notes/Org/")
(after! org-agenda
  (setq org-agenda-files (list "~/Notes/Org-Roam/20230202115352-agenda.org"
                               "~/Notes/Org-Roam/20230202114927-todo.org")))
;; org-roam setup
(setq org-roam-directory "~/Notes/Org-Roam/")
(setq org-roam-db-autosync t)

;; org-roam-ui setup
(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

;; ox-yaow setup
(use-package ox-yaow
  :config
  ;; Stolen from https://github.com/fniessen/org-html-themes
  (setq org-publish-project-alist
        (append
         `(("wiki-pages"
            ;;-------------------------------
            ;; Standard org publish options
            ;;-------------------------------
            :base-directory "~/Notes/Org-Roam/"
            :base-extension "org"
            :publishing-directory "~/Notes/Wiki/"
            :html-head ,ox-yaow-html-head
            :html-preamble t
            :recursive t
            :publishing-function ox-yaow-publish-to-html
            :preparation-function ox-yaow-preparation-fn
            :completion-function ox-yaow-completion-fn
            ;;------------------------------
            ;; Options specific to ox-yaow
            ;;------------------------------
            ;; Page to be regarded as the "homepage"
            :ox-yaow-wiki-home-file "~/Notes/Org-Roam/20230209193449-wiki.org"
            ;; Don't generate links for these files
            ;;:ox-yaow-file-blacklist ("~/org/maths/answers.org")
             ;; Max depths of sub links on indexing files
            :ox-yaow-depth 4)
           ("wiki-static"
            :base-directory "~/org/"
            :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
            :publishing-directory "~/Notes/Wiki/"
            :recursive t
            :publishing-function org-publish-attachment)
           ("wiki"
            :components ("wiki-pages" "wiki-static")))
         org-publish-project-alist)))

;; Github copilot
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("C-TAB" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         :map copilot-completion-map
         ("<tab>" . 'copilot-accept-completion)
         ("TAB" . 'copilot-accept-completion)))

;; Elfeed stuff
(setq elfeed-feeds (quote
                    (("https://reddit.com/r/unixporn.rss" reddit linux)
                     ("https://www.reddit.com/.rss" reddit main))))

;; Org bullets mode that only opens when in org mode
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; Set default shell to bash
(setenv "SHELL" "/bin/bash")

;; dashboard stuffj
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-functions :append
(setq fancy-splash-image (concat doom-user-dir "shinjiicon.jpeg")))

;; modeline stuff
(after! doom-modeline
  (setq doom-modeline-enable-word-count t
        doom-modeline-header-line nil
        ;doom-modeline-hud nil
        doom-themes-padded-modeline t
        doom-flatwhite-brighter-modeline nil
        doom-plain-brighter-modeline nil))
(add-hook! 'doom-modeline-mode-hook
           (progn
  (set-face-attribute 'header-line nil
                      :background (face-background 'mode-line)
                      :foreground (face-foreground 'mode-line))
  ))
