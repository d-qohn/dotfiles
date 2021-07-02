(set-face-font 'default "JetBrains Mono-13")
(global-auto-revert-mode t)

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
  (load-theme 'doom-rouge t)
  ;;(load-theme 'doom-opera-light t)
  (doom-themes-neotree-config)
  (setq doom-themes-neotree-file-icons t)
  (doom-themes-org-config))


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
         (yaml-mode . lsp)
	 (typescript-mode . lsp-deferred)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package plantuml-mode
  :ensure t)

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
  (add-hook 'java-mode-hook 'lsp)
  (setq lsp-java-jdt-download-url  "https://download.eclipse.org/jdtls/milestones/0.57.0/jdt-language-server-0.57.0-202006172108.tar.gz"))

;; protobuf
(use-package protobuf-mode
  :ensure t)

;; yaml 
(use-package yaml-mode
  :ensure t)

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
  :ensure t
  :config
  (yas-global-mode t))
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

(use-package vterm
  :ensure t)

(use-package selectrum
  :ensure t
  :config
  (selectrum-mode +1))

;; Enable richer annotations using the Marginalia package
(use-package marginalia
  :ensure t
  ;; Either bind `marginalia-cycle` globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init configuration is always executed (Not lazy!)
  :init

  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

(use-package consult
  :ensure t
  :config
    (setq consult-project-root-function
        (lambda ()
          (when-let (project (project-current))
            (car (project-roots project)))))
  :general
    (general-define-key
     :keymaps 'normal
     "SPC SPC f" 'consult-find
     "SPC SPC g" 'consult-grep
     "SPC SPC G" 'consult-git-grep
     "SPC SPC r" 'consult-ripgrep))


(use-package highlight-indent-guides
  :ensure t
  :diminish
  :hook
  ((prog-mode yaml-mode) . highlight-indent-guides-mode)
  ((prog-mode scala-mode) . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-auto-enabled t)
  (highlight-indent-guides-responsive t)
  (highlight-indent-guides-method 'character))

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
