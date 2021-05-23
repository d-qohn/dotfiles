(setq make-backup-files t)
(setq backup-directory-alist `(("." . "~/.emacs.d/.saves")) )
(setq inhibit-startup-screen t)

(global-display-line-numbers-mode 1)
(setq line-number-display-limit-width 10000)
(setq lsp-headerline-breadcrumb-enable nil)

(scroll-bar-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(blink-cursor-mode 0)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


;; Bootstrap `use-package'
(unless (package-installed-p 'use-package) ; unless it is already installed
  (package-refresh-contents) ; updage packages archive
  (package-install 'use-package)) ; and install the most recent version of use-package

;;theme
(use-package doom-themes
  :ensure t
  :config
  ;;(load-theme 'doom-challenger-deep t))
  ;;(load-theme 'doom-nova t))
  ;; (load-theme 'doom-losvkem t))
  ;; ^ Not found
  (load-theme 'doom-opera t)
  ;;(load-theme 'doom-peacock t))
  ;; (load-theme 'doom-snazzy t))
  ;;(load-theme 'doom-moonlight t))
  ;; (load-theme 'doom-dracula t))
  ;; (load-theme 'doom-dark+ t))
  ;; (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  ;; (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  (setq doom-themes-neotree-file-icons t)
  ;; or for treemacs users
  ;;(setq doom-themes-treemacs-theme "doom-colors") ; use "doom-colors" for less minimal icon theme
  ;;(doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))


  ;;(require 'doom-themes-ext-treemacs)
  ;;(require 'doom-themes-ext-org)
  ;;(setq doom-themes-treemacs-theme "doom-colors")

(use-package all-the-icons
  :ensure t)
(unless (member "all-the-icons" (font-family-list))
    (all-the-icons-install-fonts t))
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))
(use-package fira-code-mode
  :custom (fira-code-mode-disabled-ligatures '("x"))
  :hook prog-mode)


(use-package general
  :ensure t)

;; Ivy things
(use-package ivy
  :ensure t
  :diminish ivy-mode
  :demand t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-height 15)
  (setq ivy-count-format "(%d/%d) ")
  :general
  (general-define-key
   :keymaps 'ivy-minibuffer-map
   "C-j" 'ivy-next-line
   "C-k" 'ivy-previous-line)
  (general-define-key
   :keymaps 'ivy-switch-buffer-map
   "C-k" 'ivy-previous-line))

(use-package counsel 
  :ensure t
  :general
  (general-define-key
   :keymaps 'normal
   "SPC f f" 'counsel-find-file
   "SPC h f" 'counsel-describe-function
   "SPC u"   'counsel-unicode-char
   "SPC p s" 'counsel-rg
   "SPC SPC" 'counsel-M-x))

(use-package swiper :ensure t
  :general
  (general-define-key
   :keymaps 'normal
   "SPC s" 'swiper))

(use-package project
  :ensure t
  :general
  (general-define-key
   :keymaps 'normal
   ;;"SPC s p" 'project-switch-project
   "SPC p f" 'project-find-file))

(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :init
  (progn
    (setq sp-message-width nil
          sp-show-pair-from-inside t
	  Sp-Autoescape-string-quote nil
	  sp-cancel-autoskip-on-backward-movement nil))
  :config
  (progn
    (sp-local-pair 'minibuffer-inactive-mode "'" nil :actions nil)
    (sp-local-pair 'minibuffer-inactive-mode "`" nil :actions nil)
    (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
    (sp-local-pair 'emacs-lisp-mode "`" nil :actions nil)
    (sp-local-pair 'lisp-interaction-mode "'" nil :actions nil)
    (sp-local-pair 'lisp-interaction-mode "`" nil :actions nil)
    (sp-local-pair 'purescript-mode "\\{" nil :actions nil)
    (sp-local-pair 'purescript-mode "'" nil :actions nil)

    (smartparens-global-mode)
    (show-smartparens-global-mode)))

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (haskell-mode . lsp)
         (scala-mode . lsp)
         (java-mode . lsp)
	 (typescript-mode . lsp-deferred)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)



(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'"
  ;;:hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))
  ;;:hook (haskell-mode . lsp)

;; java
(use-package lsp-java
  :ensure t
  :config
  (add-hook 'java-mode-hook 'lsp))


;; Scala
(use-package scala-mode
  :ensure t
  :interpreter
  ("scala" . scala-mode))

;; Enable sbt mode for executing sbt commands
(use-package sbt-mode
  :ensure t
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
   ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
   (setq sbt:program-options '("-Dsbt.supershell=false")))

(use-package lsp-metals
  :ensure t
  :custom
  (lsp-metals-server-args '("-J-Dmetals.allow-multiline-string-formatting=off"))
  :hook (scala-mode . lsp))


(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))
(use-package yasnippet
  :ensure t)
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package lsp-haskell
  :ensure t
  :config
 (setq lsp-haskell-server-path "haskell-language-server-wrapper")
 (setq lsp-haskell-server-args ())
   ;; Comment/uncomment this line to see interactions between lsp client/server.
  (setq lsp-log-io t))


(use-package company
  :custom
  (company-transformers '(company-sort-by-backend-importance))
  (company-idle-delay 0)
  (company-echo-delay 0)
  (company-minimum-prefix-length 2)
  (company-selection-wrap-around t)
  (completion-ignore-case t)
  :bind
  (("C-M-c" . company-complete))
  (:map company-active-map
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous)
        ("C-s" . company-filter-candidates)
        ("C-i" . company-complete-selection)
        ([tab] . company-complete-selection))
  (:map company-search-map
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous))
  :init
  (global-company-mode t))


;; If you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
;; (use-package company-capfdap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language
;; optional if you want which-key integration
;;(use-package which-key
;;    :config
;;    (which-key-mode))
(use-package which-key
  :ensure t
  :config
  (which-key-mode 1))

(require 'use-package)

(use-package evil
  :ensure t
  :init
  (evil-mode t))

;; magit
(use-package magit
  :ensure t
  :general
  (general-define-key
   :keymaps 'normal
   "SPC g s" 'magit-status)
  (setq magit-completing-read-function 'ivy-completing-read))

;;neotree
(use-package neotree
  :ensure t)



;; treemacs
;;(use-package treemacs
;;  :ensure t
;;  :defer t
;;  :init
;;  (with-eval-after-load 'winum
;;    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
;;  :config
;;  (progn
;;    (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
;;          treemacs-deferred-git-apply-delay      0.5
;;          treemacs-directory-name-transformer    #'identity
;;          treemacs-display-in-side-window        t
;;          treemacs-eldoc-display                 t
;;          treemacs-file-event-delay              5000
;;          treemacs-file-extension-regex          treemacs-last-period-regex-value
;;          treemacs-file-follow-delay             0.2
;;          treemacs-file-name-transformer         #'identity
;;          treemacs-follow-after-init             t
;;          treemacs-expand-after-init             t
;;          treemacs-git-command-pipe              ""
;;          treemacs-goto-tag-strategy             'refetch-index
;;          treemacs-indentation                   2
;;          treemacs-indentation-string            " "
;;          treemacs-is-never-other-window         nil
;;          treemacs-max-git-entries               5000
;;          treemacs-missing-project-action        'ask
;;          treemacs-move-forward-on-expand        nil
;;          treemacs-no-png-images                 nil
;;          treemacs-no-delete-other-windows       t
;;          treemacs-project-follow-cleanup        nil
;;          treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
;;          treemacs-position                      'left
;;          treemacs-read-string-input             'from-child-frame
;;          treemacs-recenter-distance             0.1
;;          treemacs-recenter-after-file-follow    nil
;;          treemacs-recenter-after-tag-follow     nil
;;          treemacs-recenter-after-project-jump   'always
;;          treemacs-recenter-after-project-expand 'on-distance
;;          treemacs-litter-directories            '("/node_modules" "/.venv" "/.cask")
;;          treemacs-show-cursor                   nil
;;          treemacs-show-hidden-files             t
;;          treemacs-silent-filewatch              nil
;;          treemacs-silent-refresh                nil
;;          treemacs-sorting                       'alphabetic-asc
;;          treemacs-space-between-root-nodes      t
;;          treemacs-tag-follow-cleanup            t
;;          treemacs-tag-follow-delay              1.5
;;          treemacs-user-mode-line-format         nil
;;          treemacs-user-header-line-format       nil
;;          treemacs-width                         35
;;          treemacs-workspace-switch-cleanup      nil)
;;
;;    ;; The default width and height of the icons is 22 pixels. If you are
;;    ;; using a Hi-DPI display, uncomment this to double the icon size.
;;    ;;(treemacs-resize-icons 44)
;;
;;    (treemacs-follow-mode t)
;;    (treemacs-filewatch-mode t)
;;    (treemacs-fringe-indicator-mode 'always)
;;    (pcase (cons (not (null (executable-find "git")))
;;                 (not (null treemacs-python-executable)))
;;      (`(t . t)
;;       (treemacs-git-mode 'deferred))
;;      (`(t . _)
;;       (treemacs-git-mode 'simple))))
;;  :general
;;  (general-define-key
;;   :keymaps 'normal
;;   "SPC t" 'treemacs-select-window)
;;   :bind
;;   (:map global-map
;;        ("C-x t 1"   . treemacs-delete-other-windows)
;;        ("C-x t t"   . treemacs)
;;        ("C-x t B"   . treemacs-bookmark)
;;        ("C-x t C-t" . treemacs-find-file)
;;        ("C-x t M-t" . treemacs-find-tag)))
;;
;;(use-package treemacs-evil
;;  :after (treemacs evil)
;;  :ensure t)
;;
;;(use-package treemacs-projectile
;;  :after (treemacs projectile)
;;  :ensure t)
;;
;;(use-package treemacs-icons-dired
;;  :after (treemacs dired)
;;  :ensure t
;;  :config (treemacs-icons-dired-mode))
;;
;;(use-package treemacs-magit
;;  :after (treemacs magit)
;;  :ensure t)
;;
;;(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
;;  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
;;  :ensure t
;;  :config (treemacs-set-scope-type 'Perspectives))
;;
;;(use-package treemacs-all-the-icons
;;  :ensure t
;;  :config
;;  (treemacs-load-theme "all-the-icons"))
;;(require 'treemacs-all-the-icons)
;;(treemacs-load-theme "all-the-icons")

(use-package vterm
  :ensure t)

;;(use-package magit
;; :bind ("C-." . hello))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-log-io nil nil nil "Customized with use-package lsp-mode")
 '(package-selected-packages
   '(lsp-java java company-lsp lsp-metals typescript-mode doom-modeline doom-themes yasnippet lsp-pyright lsp-mode nix-mode magit use-package evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
