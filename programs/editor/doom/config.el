;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Peter Barrow"
      user-mail-address "p.barrow@hw.ac.uk"
      doom-font (font-spec :family "Iosevka Term" :size 12 :height 1.0)
      doom-variable-pitch-font (font-spec :family "Iosevka" :height 1.3)
      doom-serif-font (font-spec :family "Iosevka Etoile" :height 1.2)
      doom-big-font (font-spec :family "Iosevka Etoile" :size 18)
      ;doom-variable-pitch-font (font-spec :family "IBM Plex Sans" :height 1.0)
      ;doom-serif-font (font-spec :family "IBM Plex Serif" :height 1.2)
      ;doom-big-font (font-spec :family "IBM Plex Sans" :size 18)
      )

; (setq nano-font-family-monospaced "Iosevka Term")
; (setq nano-font-family-proportional "Iosevka Aile")
; (setq nano-font-size 10)
; (require 'nano)


;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face


;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;(setq doom-theme 'doom-one)
;(setq doom-theme 'doom-flatwhite)
;(load-theme 'modus-operandi)
;(load-theme 'nano-light t)
;(setq doom-theme 'doom-nano-light)
(after! doom-themes
  (load-theme 'doom-nano-light t))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org")


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
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
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
;
;(use-package! evil-escape
;  :config
;  (setq-default evil-escape-key-sequence "fd")
;  (setq-default evil-escape-delay 0.15)
;  (setq-default evil-escape-unordered-key-sequence nil)
;  (setq-default evil-escape-inhibit-functions nil)
;  (evil-escape-mode))
;
;(use-package! evil-surround
;  :config
;  (global-evil-surround-mode 1))


(use-package! org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/Documents/org/roam/") )
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

;; helm-bibtex related stuff
(after! helm
  (use-package! helm-bibtex
    :custom
    ;; In the lines below I point helm-bibtex to my default library file.
    (bibtex-completion-bibliography '("~/Zotero/better-bibtex/My Library.bib")
                                    )
    (reftex-default-bibliography '("~/Zotero/better-bibtex/My Library.bib"))
    ;; The line below tells helm-bibtex to find the path to the pdf
    ;; in the "file" field in the .bib file.
    (bibtex-completion-pdf-field "file")
    :hook (Tex . (lambda () (define-key Tex-mode-map "C-c ]" 'helm-bibtex))))
  ;; I also like to be able to view my library from anywhere in emacs, for example if I want to read a paper.
  ;; I added the keybind below for that.
  (map! :leader
        :desc "Open literature database"
        "o l" #'helm-bibtex)
  ;; And I added the keybinds below to make the helm-menu behave a bit like the other menus in emacs behave with evil-mode.
  ;; Basically, the keybinds below make sure I can scroll through my list of references with C-j and C-k.
  (map! :map helm-map
        "C-j" #'helm-next-line
        "C-k" #'helm-previous-line)
)

;; Set up org-ref stuff
(use-package! org-ref
   :custom
   ;; Again, we can set the default library
   (org-ref-default-bibliography "~/Zotero/better-bibtex/My Library.bib"))
  ;; Add a shortcut to add citations.
  (map! :leader
        :desc "Insert citation"
        "o c" #'org-ref-cite-insert-helm)
   ;; The default citation type of org-ref is cite:, but I use citep: much more often
   ;; I therefore changed the default type to the latter.
   ;(org-ref-default-citation-link "citep")

;; The function below allows me to consult the pdf of the citation I currently have my cursor on.
(defun my/org-ref-open-pdf-at-point ()
 "Open the pdf for bibtex key under point if it exists."
 (interactive)
 (let* ((results (org-ref-get-bibtex-key-and-file))
        (key (car results))
        (pdf-file (funcall org-ref-get-pdf-filename-function key)))
   (if (file-exists-p pdf-file)
       (find-file pdf-file)
     (message "No PDF found for %s" key))))

 (setq org-ref-completion-library 'org-ref-ivy-cite
       org-export-latex-format-toc-function 'org-export-latex-no-toc
       org-ref-get-pdf-filename-function
       (lambda (key) (car (bibtex-completion-find-pdf key)))
       ;; See the function I defined above.
       org-ref-open-pdf-function 'my/org-ref-open-pdf-at-point
       ;; For pdf export engines.
       org-latex-pdf-process (list "latexmk -pdflatex='%latex -shell-escape -interaction nonstopmode' -pdf -bibtex -f -output-directory=%o %f")
       ;; I use orb to link org-ref, helm-bibtex and org-noter together (see below for more on org-noter and orb).
       org-ref-notes-function 'orb-edit-notes)

;; This is to use pdf-tools instead of doc-viewer
;; (use-package! pdf-tools
;;   :config
;;   (pdf-tools-install)
;;   (setq-default pdf-view-display-size 'fit-width)
;;   :custom
;;   (pdf-annot-activate-created-annotations t "automatically annotate highlights"))

;; org-noter stuff
  (after! org-noter
    (setq
          org-noter-notes-search-path '("~/Documents/org/roam/references")
          org-noter-hide-other nil
          org-noter-separate-notes-from-heading t
          org-noter-always-create-frame nil)
    (map!
     :map org-noter-doc-mode-map
     :leader
     :desc "Insert note"
     "m i" #'org-noter-insert-note
     :desc "Insert precise note"
     "m p" #'org-noter-insert-precise-note
     :desc "Go to previous note"
     "m k" #'org-noter-sync-prev-note
     :desc "Go to next note"
     "m j" #'org-noter-sync-next-note
     :desc "Create skeleton"
     "m s" #'org-noter-create-skeleton
     :desc "Kill session"
     "m q" #'org-noter-kill-session
     )
  )

;; org-roam-bibtex stuff
 (use-package! org-roam-bibtex
     :hook (org-roam-mode . org-roam-bibtex-mode))

 (setq orb-preformat-keywords
       '("citekey" "title" "url" "author-or-editor" "keywords" "file")
       orb-process-file-keyword t
       orb-file-field-extensions '("pdf"))

 (setq orb-templates
       '(("r" "ref" plain(function org-roam-capture--get-point)
          ""
          :file-name "${citekey}"
          :head "#+TITLE: ${citekey}: ${title}\n#+ROAM_KEY: ${ref}
 tags ::
 keywords :: ${keywords}

 Notes
PROPERTIES:
Custom_ID: ${citekey}
URL: ${url}
AUTHOR: ${author-or-editor}
NOTER_DOCUMENT: ${file}
NOTER_PAGE:
END:")))


;; org-roam related things
(after! org-roam
  (setq org-roam-directory "~/Documents/org/roam/")

  (add-hook 'after-init-hook 'org-roam-mode)
  )

 ;; Let's set up some org-roam capture templates
 (setq org-roam-capture-templates
       (quote (("d" "default" plain (function org-roam--capture-get-point)
                "%?"
                :file-name "%<%Y-%m-%d-%H%M%S>-${slug}"
                :head "#+title: ${title}\n"
                :unnarrowed t)
               )))

 ;; And now we set necessary variables for org-roam-dailies
 (setq org-roam-dailies-capture-templates
       '(("d" "default" entry
          #'org-roam-capture--get-point
          "* %?"
          :file-name "daily/%<%Y-%m-%d>"
          :head "#+title: %<%Y-%m-%d>\n\n")))

(use-package! org-roam-ui
  :after org-roam
    :config
    (setq org-roam-ui-sync-theme nil
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start nil
    )
    (map!
      :leader
      :desc "Open roam ui"
      "n r u" #'org-roam-ui-open
    )
)

;; use-package! org-super-agenda
;;  :hook (org-agenda-mode . org-super-agenda-mode))

(use-package! org-modern
  :after org
  :config
  (with-eval-after-load 'org (global-org-modern-mode)))

(setq ring-bell-function 'ignore ; no bell
      ;; better scrolling
      scroll-conservatively 101
      scroll-preserve-screen-position 1
      mouse-wheel-follow-mouse t
      pixel-scroll-precision-use-momentum t)
(setq-default line-spacing 1)

;; highlight the current line
(global-hl-line-mode t)

;; Add padding inside buffer windows
(setq-default left-margin-width 2
              right-margin-width 2)
(set-window-buffer nil (current-buffer)) ; Use them now.

;; Add padding inside frames (windows)
(add-to-list 'default-frame-alist '(internal-border-width . 8))
(set-frame-parameter nil 'internal-border-width 8) ; Use them now

;; fix color display when loading emacs in terminal
(defun enable-256color-term ()
  (interactive)
  (load-library "term/xterm")
  (terminal-init-xterm))

(unless (display-graphic-p)
  (if (string-suffix-p "256color" (getenv "TERM"))
    (enable-256color-term)))

; (use-package doom-themes
;   :defer t
;   :config
;   (doom-themes-visual-bell-config)
;   (doom-themes-treemacs-config)
;   (doom-themes-org-config)
;   (doom-themes-set-faces nil
;     ;; extending faces breaks orgmode collapsing for now
;    '(org-block-begin-line :extend nil)
;    '(org-block-end-line :extend nil)
;     ;; different sized headings are nice.
;    '(outline-1 :height 1.3)
;    '(outline-2 :height 1.1)
;    '(outline-3 :height 1.0)))
;
; (use-package modus-themes
;   :defer t
;   :custom
;   (modus-themes-italic-constructs t)
;   (modus-themes-intense-markup t)
;   (modus-themes-mode-line '(borderless moody))
;   (modus-themes-tabs-accented t)
;   (modus-themes-completions
;    '((matches . (extrabold background intense))
;      (selection . (semibold accented intense))
;      (popup . (accented))
;      (t . (extrabold intense))))
;   (modus-themes-org-blocks 'tinted-background)
;   (modus-themes-mixed-fonts t)
;   (modus-themes-headings
;       '((1 . (rainbow))
;         (2 . (rainbow))
;         (3 . (rainbow))
;         (t . (monochrome)))))
;
;(modus-themes-load-operandi)

;(load-theme 'nano-light)
;; org-mode related stuff
 ;; org keyword related stuff
(after! org
  (setq org-todo-keywords
        (quote ((sequence
                 "TODO(t)"
                 "PROJ(p)"
                 "LOOP(r)"
                 "STRT(s)"
                 "IDEA(i)"
                 "NEXT(n)"
                 "|"
                 "DONE(d)")
                (sequence
                 "WAIT(w@/!)"
                 "HOLD(h@/!)"
                 "|"
                 "KILL(k@/!)")
                (sequence
                 "[ ](T)"
                 "[-](S)"
                 "[?](W)"
                 "|"
                 "[X](D)"
                 ))))
  )


(use-package! doom-nano-modeline
  :config
  (doom-nano-modeline-mode 1)
  (global-hide-mode-line-mode 1))

(use-package! mixed-pitch
  :hook (org-mode . mixed-pitch-mode)
  :config
  (setq mixed-pitch-set-height t)
  (set-face-attribute 'variable-pitch nil :height 1.2))

(after! org
  (setq
   ;; Choose some fonts
   ;(set-face-attribute 'default nil :family "Iosevka")
   ;(set-face-attribute 'variable-pitch nil :family "Iosevka Aile")
   ;(set-face-attribute 'org-modern-symbol nil :family "Iosevka")

   ; ;; Add frame borders and window dividers
   ; (modify-all-frames-parameters
   ;  '((right-divider-width . 40)
   ;    (internal-border-width . 40)))
   ; (dolist (face '(window-divider
   ;                 window-divider-first-pixel
   ;                 window-divider-last-pixel))
   ;   (face-spec-reset-face face)
   ;   (set-face-foreground face (face-attribute 'default :background)))
   ; (set-face-background 'fringe (face-attribute 'default :background))
   ;; Edit settings
   org-auto-align-tags nil
   org-indent-mode 0
   org-adapt-indentation nil
   org-tags-column 0
   org-catch-invisible-edits 'show-and-error
   org-special-ctrl-a/e t
   org-insert-heading-respect-content t

   ;; Org styling, hide markup etc.
   org-hide-emphasis-markers t
   org-pretty-entities t
   org-ellipsis "…"

   ;; Agenda styling
   org-agenda-tags-column 0
   org-agenda-block-separator ?─
   org-agenda-time-grid
   '((daily today require-timed)
     (800 1000 1200 1400 1600 1800 2000)
     " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
   org-agenda-current-time-string
   "⭠ now ─────────────────────────────────────────────────")

  (global-org-modern-mode)
  )

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

; (setq doom-theme 'doom-rose-pine-moon)
(setq doom-theme 'doom-nano-light)

; (load-theme 'rose-pine-moon t)
