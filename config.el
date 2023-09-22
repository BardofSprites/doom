;;;$DOOMDIR/config.el-*-lexical-binding: t;-*-
(setq doom-font(font-spec :family "Iosevka Comfy" :size 20)
      doom-variable-pitch-font(font-spec :family "Iosevka Comfy Wide" :size 20)
      variable-pitch-font(font-spec :family "Iosevka Comfy Wide"))

;; Custom Set faces
;;(custom-set-faces '(org-agenda-structure ((t (:height 1.5)))))

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

(setq cider-stacktrace-supressed-errors t)

(setq inferior-lisp-program "clisp")

(setq doom-theme 'doom-gruvbox-light)
(require 'modus-themes)

(load-theme 'ef-autumn :no-confirm)
(define-key global-map (kbd "<f5>") #'ef-themes-toggle)

(setq ef-themes-to-toggle '(ef-autumn ef-cyprus))

(setq ef-themes-headings
      '((0 variable-pitch 1.8)
        (1 variable-pitch 1.3)
        (2 regular 1.2)
        (3 1.1)
        (agenda-structure variable-pitch 1.5)
        (t variable-pitch)))

(setq org-capture-templates
      '(("h" "Homework" entry (file+olp "~/Notes/Org-Roam/todo.org" "Inbox" "Homework")
         "* TODO %?")
        ("r" "Reading List" entry (file+olp "~/Notes/Org-Roam/todo.org" "Inbox" "Watch/Read List")
         "* %?")
        ("j" "Journal" entry (file+datetree "~/Notes/Org-Roam/journal.org")
         "* %U %^{Title}\n  %?")
        ("a" "Appointment" entry (file+heading "~/Notes/Org-Roam/todo.org" "Appointment")
         "* %^{Task}\n  %^t\n  %?")))

(setq org-directory "~/Notes/Org-Roam/")
(add-hook 'after-save-hook 'org-babel-tangle)

(after! org-agenda
  (setq org-agenda-files (list "~/Notes/Org-Roam/todo.org")))

(define-key global-map (kbd "<f6>") #'org-agenda)

;;(setq org-agenda-block-separator 8411)

(setq org-agenda-custom-commands
      `(("A" "Daily agenda and top priority tasks"
         ((tags-todo "*"
                     ((org-agenda-skip-function '(org-agenda-skip-if nil '(timestamp)))
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                      (org-agenda-overriding-header "All Tasks \n")))
          (agenda "" ((org-agenda-span 1)
                      (org-agenda-start-day nil)
                      (org-deadline-warning-days 0)
                      (org-scheduled-past-days 0)
                      ;; We don't need the `org-agenda-date-today'
                      ;; highlight because that only has a practical
                      ;; utility in multi-day views.
                      (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
                      (org-agenda-format-date "%A %-e %B %Y")
                      (org-agenda-overriding-header "Today's agenda \n")))
          ;; write skip function that skips saturdays and sundays
          (agenda "" ((org-agenda-span 7)
                      (org-deadline-warning-days 0)
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                      (org-agenda-overriding-header "Upcoming this week \n")))))
        ("Y" "Monthly view for all tasks"
         ((agenda "" ((org-agenda-span 365)
                      (org-deadline-warning-days 2)
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                      (org-agenda-overriding-header "Upcoming this Year\n")))))
        ("S" "Monthly view for all tasks"
         ((agenda "" ((org-agenda-span 31)
                      (org-deadline-warning-days 2)
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                      (org-agenda-overriding-header "Upcoming this month\n")))))))

(defun bard/assignment-due-time (day period)
  (interactive)
      (let* ((selected-date (calendar-read-date))
         (day-name (format-time-string "%a" (encode-time 0 0 0 (nth 1 selected-date) (car selected-date) (nth 2 selected-date))))
         (period (completing-read "Select Period: " '("A" "B" "D" "F" "G")))))
      (pcase day
        ("Mon" (pcase period
                 ("A" mon-a)
                 ("B" mon-b)
                 ("D" mon-d)
                 ("F" mon-f)
                 ("G" mon-g)))
        ("Tue" (pcase period
                 ("A" tue-a)
                 ("B" tue-b)
                 ("D" tue-d)
                 ("G" tue-g)))
        ("Wed" (pcase period
                 ("A" wed-a)
                 ("F" wed-f)
                 ("G" wed-g)))
        ("Thu" (pcase period
                 ("B" thu-b)
                 ("D" thu-d)
                 ("F" thu-f)))
        ("Fri" (pcase period
                 ("A" fri-a)
                 ("B" fri-b)
                 ("D" fri-d)
                 ("F" fri-f)
                 ("G" fri-g))))
      (let ((formatted-date (format-time-string "%Y-%m-%d" (org-time-string-to-time start-time))))
          (insert (format "\nDEADLINE: <%s %s>" formatted-date start-time))))

;; A period
(setq mon-a "8:10")
(setq tue-a "9:20")
(setq wed-a "13:55")
(setq fri-a "9:50")

;; B period
(setq mon-b "9:00")
(setq tue-b "12:40")
(setq thu-b "8:10")
(setq fri-b "14:20")

;; D period
(setq mon-d "11:00")
(setq tue-d "8:10")
(setq thu-d "10:40")
(setq fri-d "12:40")

    ;; F period
(setq mon-f "13:30")
(setq wed-f "9:20")
(setq thu-f "13:50")
(setq fri-f "9:00")

;; G period
(setq mon-g "14:20")
(setq tue-g "10:40")
(setq wed-g "12:40")
(setq fri-g "11:00")

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
         "\n\n\n* Tags :: %? \n\n* ${title} \n"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+TITLE: ${title}\n")
         :unnarrowed t)
        ("b" "bio" plain
         "#+ANKI_DECK: Bio \n\n* Tags :: [[id:cfe7bda9-b154-4d6b-989f-6af778a98cbd][Biology]] \n\n* %? \n"
         :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+TITLE: ${title}\n")
         :unnarrowed t)
        ("u" "apush" plain
         "#+ANKI_DECK: APUSH \n\n* Tags :: [[id:06334c1d-5c06-4b70-bfd8-a074c0c36706][APUSH]] \n\n* %? \n"
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
        doom-modeline-icon nil
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
      :desc "Open eshell" "ot" #'eshell)

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

(map! :leader
      :desc "Sync anki card at entry" "nA" #'org-anki-sync-entry)
(map! :leader
      :desc "Delete anki card at entry" "nD" #'org-anki-delete-entry)
(map! :leader
      :desc "Browse card at entry in Anki browser" "nB" #'org-anki-browse-entry)
