(setq make-backup-files t)
(setq inhibit-startup-screen t)

(global-display-line-numbers-mode 1)
(setq line-number-display-limit-width 10000)

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
  (load-theme 'doom-opera t))

(use-package all-the-icons
  :ensure t)
(unless (member "all-the-icons" (font-family-list))
    (all-the-icons-install-fonts t))
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

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

;;(use-package lsp-mode
;;  :ensure t
;;  :commands (lsp lsp-deferred)
;;  )
  ;;:init
  ;;(setq lsp-keymap-prefix "M-c l"))
 
 ;;:config
 ;; (lsp-enable-which-key-integration t))
 ;; ^ Error (use-package): lsp-mode/:config: Symbol’s function definition is void: which-key-add-key-based-replacement

;;(use-package lsp-mode
;;  :commands lsp
;;  :init
;;  (setq lsp-keymap-prefix "C-c l")
;;  :config
;;  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
;;  :hook (lsp-mode . lsp-enable-which-key-integration))

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




;; Haskell
;;(use-package haskell-mode
;;  :ensure t
;;  :config
;;  (setq haskell-interactive-popup-error nil))





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
