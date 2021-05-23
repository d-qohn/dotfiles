(setq inhibit-startup-screen t)

(scroll-bar-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(blink-cursor-mode 0)




;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Fix an issue accessing the ELPA archive in Termux
;;(when dw/is-termux
;;  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

(package-initialize)
;; (unless package-archive-contents
;;   (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

; theme
(use-package doom-themes
  :ensure t
  :config
  ;;(load-theme 'doom-vibrant t))
  (load-theme 'doom-opera t))

(use-package all-the-icons
  :ensure t)
(unless (member "all-the-icons" (font-family-list))
  (all-the-icons-install-fonts t))
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

					; evil
(use-package evil
  :ensure t
  :init
  (evil-mode t))

(use-package which-key
             :ensure t
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package lsp-mode
             :ensure t
             :init
             (setq lsp-keymap-prefix "C-c l")
  ;;:straight t
  :commands lsp
  ;;:hook ((typescript-mode web-mode) . lsp)
  :hook (
         (scala-mode . lsp)
         (haskell-mode . lsp)
         (typescript-mode . lsp-deferred)
         (web-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :bind (:map lsp-mode-map
         ("TAB" . completion-at-point))
  :custom (lsp-headerline-breadcrumb-enable nil))

(use-package lsp-ui
             :ensure t
 ;; :straight t
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-sideline-show-hover nil)
  (setq lsp-ui-doc-position 'bottom)
 ;; (lsp-ui-doc-show)
  )

;; Haskell
(use-package lsp-haskell
  :ensure t
  :config
 (setq lsp-haskell-server-path "haskell-language-server-wrapper")
 (setq lsp-haskell-server-args ()))
   ;; Comment/uncomment this line to see interactions between lsp client/server.


;; scala
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
   (setq sbt:program-options '("-Dsbt.supershell=false"))
)


(use-package lsp-metals
  :ensure t
  :custom
  ;; Metals claims to support range formatting by default but it supports range
  ;; formatting of multiline strings only. You might want to disable it so that
  ;; emacs can use indentation provided by scala-mode.
  (lsp-metals-server-args '("-J-Dmetals.allow-multiline-string-formatting=off"))
  :hook (scala-mode . lsp))


;; typescript
(use-package typescript-mode
             :ensure t
  :mode "\\.ts\\'"
  :config
  (setq typescript-indent-level 2))


(use-package web-mode
             :ensure t
  :mode "(\\.\\(html?\\|ejs\\|tsx\\|jsx\\)\\'"
  :config
  (setq-default web-mode-code-indent-offset 2)
  (setq-default web-mode-markup-indent-offset 2)
  (setq-default web-mode-attribute-indent-offset 2))

;; 1. Start the server with `httpd-start'
;; 2. Use `impatient-mode' on any buffer
(use-package impatient-mode
             :ensure t)

(use-package skewer-mode
             :ensure t)

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

(use-package counsel :ensure t
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

(use-package project :ensure t
  :pin elpa
  :general
  (general-define-key
   :keymaps 'normal
   "SPC p p" 'project-switch-project
   "SPC p f" 'project-find-file))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(sbt-mode scala-mode counsel ivy general evil doom-modeline use-package nix-mode magit lsp-ui lsp-metals lsp-java)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
