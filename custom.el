;;; custom.el -*- lexical-binding: t; -*-

;; map leader pv to dired jump
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#282828" "#fb4934" "#b8bb26" "#fabd2f" "#83a598" "#cc241d" "#8ec07c" "#ebdbb2"])
 '(custom-safe-themes
   '("ba4ab079778624e2eadbdc5d9345e6ada531dc3febeb24d257e6d31d5ed02577" default))
 '(doom-big-font-mode t t)
 '(exwm-floating-border-color "#504945")
 '(fci-rule-color "#7c6f64")
 '(frame-brackground-mode 'dark)
 '(highlight-tail-colors ((("#363627" "#363627") . 0) (("#323730" "#323730") . 20)))
 '(ispell-dictionary nil)
 '(jdee-db-active-breakpoint-face-colors (cons "#0d1011" "#fabd2f"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#0d1011" "#b8bb26"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#0d1011" "#928374"))
 '(linum-format " %3i ")
 '(objed-cursor-color "#fb4934")
 '(package-selected-packages
   '(org-roam-ui ox-hugo orglink auctex cmake-mode org-bullets gruber-darker-theme elfeed elcord))
 '(pdf-view-midnight-colors (cons "#ebdbb2" "#282828"))
 '(rustic-ansi-faces
   ["#282828" "#fb4934" "#b8bb26" "#fabd2f" "#83a598" "#cc241d" "#8ec07c" "#ebdbb2"])
 '(vc-annotate-background "#282828")
 '(vc-annotate-color-map
   (list
    (cons 20 "#b8bb26")
    (cons 40 "#cebb29")
    (cons 60 "#e3bc2c")
    (cons 80 "#fabd2f")
    (cons 100 "#fba827")
    (cons 120 "#fc9420")
    (cons 140 "#fe8019")
    (cons 160 "#ed611a")
    (cons 180 "#dc421b")
    (cons 200 "#cc241d")
    (cons 220 "#db3024")
    (cons 240 "#eb3c2c")
    (cons 260 "#fb4934")
    (cons 280 "#e05744")
    (cons 300 "#c66554")
    (cons 320 "#ac7464")
    (cons 340 "#7c6f64")
    (cons 360 "#7c6f64")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; map leader pv to dired jump
(map! :leader
      :desc "Dired jump" "pv" #'dired-jump)

;; unmap leader pf to find file
(map! :leader
      :desc "Find file" "pf" #'dired)

(map! :leader
      :desc "Open doom dashboard" "oh" #'+doom-dashboard/open)

;; open rss reader
(map! :leader
      :desc "Open elfeed" "rs" #'elfeed)

;; update rss feeds
(map! :leader
      :desc "Update elfeed" "ru" #'elfeed-update)

;; kill elfeed buffer
(map! :leader
      :desc "Update elfeed" "rk" #'elfeed-kill-buffer)

(map! :leader
      :desc "Open shell" "os" #'shell)

;; change emms player to mpv
(setq emms-player-list '(emms-player-mpv))

(map! :leader
      :desc "Open emms" "oe" #'emms)

(map! :leader
      :desc "Load a file into emms" "lf" #'emms-add-file)

(map! :leader
      :desc "Load a directory into emms" "ld" #'emms-add-directory)

(map! :leader
      :desc "Find a org roam node" "nrf" #'org-roam-node-find)

(map! :leader
      :desc "Find a org roam node" "nrf" #'org-roam-node-insert)

(map! :leader
      :desc "Open org roam ui" "ou" #'org-roam-ui-open)
