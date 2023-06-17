;;;$DOOMDIR/config.el-*-lexical-binding: t;-*-
(load "~/.config/doom/private.el")
(setq my-credentials-file "~/.config/doom/private.el")

(setq doom-font(font-spec :family "Iosevka Comfy" :size 20)
      big-font(font-spec :family "Iosevka Comfy" :size 30)
      variable-pitch-font(font-spec :family "Iosevka Comfy" :size 20))

;; sets the cursor to always be a block
;;(setq evil-insert-state-cursor 'box)

;; make the cursor blinking
(blink-cursor-mode 1)

;; relative line numbers
(setq display-line-numbers-type `relative)

;; indent
(setq tab-width 4)

;; spellcheck
(setq ispell-dictionary "english")

(defun haskell-indent-hook ()
  "Setup variables for editing Haskell files."
  (setq whitespace-line-column 70)
  (make-local-variable 'tab-stop-list)
  (setq tab-stop-list (number-sequence 2 80 2))
  (haskell-indentation-mode 0)
  (setq indent-line-function 'indent-relative))

(add-hook 'haskell-mode-hook 'haskell-indent-hook)

(defun my-nickserv-password (server)
  (with-temp-buffer
    (insert-file-contents-literally my-credentials-file)
    (plist-get (read (buffer-string)) :nickserv-password)))

(setq circe-netpersonal-options
      '(("Libera Chat"
         :nick "bardman"
         :channels ("#emacs" "#gentoo")
         :nickserv-password my-nickserv-password)))

(setq doom-theme 'doom-gruvbox)
(require 'modus-themes)
(load-theme 'modus-vivendi :no-confirm)
(define-key global-map (kbd "<f5>") #'modus-themes-toggle)

(setq org-directory "~/Notes/Org/")
(add-hook 'after-save-hook 'org-babel-tangle)

(after! org-agenda
    (setq org-agenda-files (list "~/Notes/Org-Roam/20230202114927-todo.org")))

(use-package ox-moderncv
    :load-path "~/.config/emacs/.local/org-cv"
    :init (require 'ox-moderncv))
(require 'ox-tufte)

(setq org-roam-directory "~/Notes/Org-Roam/")
(setq org-roam-db-autosync t)
(require 'org-roam-export)

(setq citar-bibliography "~/Notes/References/MasterLibrary.bib")

(setq org-roam-capture-templates
    '(("d" "default" plain
          "\n* Tags: \n%? \n\n"
          :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+TITLE: ${title}\n")
          :unnarrowed t)
      ("n" "notes" plain
          "\n\n* Tags :: %? \n\n* ${title} \n"
          :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+TITLE: ${title}\n")
          :unnarrowed t)
      ("s" "snapshot" plain
          (file "~/Notes/Org/snapshot_template.org")
          :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+TITLE: ${title}\n")
          :unnarrowed t)
      ("i" "idea" plain
          "\n* Tags: \n%? \n\n"
          :if-new (file+head "Ideas/%<%Y%m%d%H%M%S>-${slug}.org" "#+TITLE: ${title}\n")
          :unnarrowed t)))

(setq org-roam-dailies-directory "Journal/")
(setq org-roam-dailies-capture-templates
      '(("d" "default" plain
        "\n* Tags :: %? \n\n"
        :target (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n")
        :unnarrowed t)
      ("s" "standup" plain
         (file "~/Notes/Org/standup_template.org")
         :target (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n")
         :unnarrowed t)
      ("r" "reflection" plain
          "\n* Tags:: %? \n\n"
          :target (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
  :after org-roam
  :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(elfeed-org)
(setq rmh-elfeed-org-files (list "~/.config/doom/elfeed.org"))
(setq elfeed-search-filter "+unread -academia")

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-functions :append
(setq fancy-splash-image (concat doom-user-dir "emacswithtext.png")))

(after! doom-modeline
  (setq doom-modeline-enable-word-count t
        doom-modeline-header-line nil
        ;doom-modeline-hud nil
        doom-themes-padded-modeline t))
(add-hook! 'doom-modeline-mode-hook
           (progn
  (set-face-attribute 'header-line nil
                      :background (face-background 'mode-line)
                      :foreground (face-foreground 'mode-line))))

(emms-mode-line-disable)
(display-time)

(setq treemacs-width 25)

(map! :leader
      :desc "Dired jump" "pv" #'dired-jump)
(map! :leader
      :desc "Find file" "pf" #'dired)
(map! :leader
      :desc "Open doom dashboard" "oh" #'+doom-dashboard/open)
(map! :leader
      :desc "Open calendar" "oc" #'calendar)

(map! :leader
      :desc "Open emms" "oe" #'emms)
(map! :leader
      :desc "Load a file into emms" "lf" #'emms-add-file)
(map! :leader
      :desc "Load a directory into emms" "ld" #'emms-add-directory)
(map! :leader
      :desc "Repeat track" "lr" #'emms-toggle-repeat-track)
(map! :leader
      :desc "Repeat playlist" "lp" #'emms-toggle-repeat-playlist)
(map! :leader
      :desc "Shuffle playlist" "ls" #'emms-shuffle)

(map! :leader
      :desc "Open rss" "rs" #'elfeed)
(map! :leader
      :desc "Update feeds" "ru" #'elfeed-update)

(map! :leader
      :desc "Find a org roam node" "nrf" #'org-roam-node-find)
(map! :leader
      :desc "Find a org roam node" "nrf" #'org-roam-node-insert)
(map! :leader
      :desc "Open org roam ui" "ou" #'org-roam-ui-open)
