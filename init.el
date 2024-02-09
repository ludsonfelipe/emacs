;; Verifica e inicia o package.el
(require 'package)

;; Definição de repositórios
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                        ("org"   . "https://orgmode.org/elpa/")
                        ("elpa"  . "https://elpa.gnu.org/packages/")))

;; Inicialização do sistema de pacotes
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

; Instalação do use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(setq inhibit-startup-message t)

;; Instalando Icons
(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("fd1fea4311568a0da48c2e05d1efbb07d31ea625eedb289249156a0d9a115c8f" default))
 '(package-selected-packages
   '(doom-modeline elfeed-goodies elfeed org-ai auto-package-update neotree elpy projectile dashboard rainbow-mode doom-themes all-the-icons-dired all-the-icons use-package)))


;; Desativando Menu
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Numero nas linha
(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

;; Meu Theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'default-frame-alist '(alpha-background . 100))
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t)) ; if nil, italics is universally disabled

(use-package transwin)

(load-theme 'lipe t)

;; Rainbow Mode
(use-package rainbow-mode
  :hook org-mode prog-mode)

;; Projectile
(use-package projectile
  :config
  (projectile-mode 1))

;; DASHBOARD - Tela Inicial
(use-package dashboard
  :ensure t 
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-startup-banner "~/.emacs.d/logo/LFroes.png")  ;; use custom image as banner
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)
                          (registers . 3)))
  :custom 
  (dashboard-modify-heading-icons '((recents . "file-text")
            (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))

;; Suporte para o python
(use-package elpy)
(elpy-enable)

;; Ativa Flycheck para correção tempo real elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

; Tree folders lateral
(use-package neotree)
(setq neo-theme (if (display-graphic-p) 'icons))
(setq neo-window-width 35)

;; Linha em highlight
(global-hl-line-mode t)

;; Salva files de backup em outra pasta
(setq backup-directory-alist `(("." . "~/.saves")))

;; Alerta visual e não com som
(setq visible-bell t)

;; Rolagem mais suave
(setq mouse-wheel-scroll-amount '(2 ((shift) . 1))
      mouse-wheel-progressive-speed nil
      mouse-wheel-follow-mouse 't
      scroll-step 1)

(global-set-key [f6] 'transwin-toggle)
(global-set-key [f7] 'neotree-toggle)
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-x f") 'elfeed)

;; Jupyter Notebook + Ipython
(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)
(add-to-list 'python-shell-completion-native-disabled-interpreters
            "jupyter")

;; feed do reddit
(use-package elfeed
  :config
  (setq elfeed-search-feed-face ":foreground #ffffff :weight bold"
        elfeed-feeds (quote
                       (("https://www.reddit.com/r/dataengineering.rss" reddit data_engineer)
                        ("https://www.reddit.com/r/emacs.rss" reddit emacs)
			("https://www.reddit.com/r/Python.rss" reddit python)
			("https://www.reddit.com/r/scala.rss" reddit scala)
			("https://www.reddit.com/r/SQL.rss" reddit sql)
			))))
 

(use-package elfeed-goodies
  :init
  (elfeed-goodies/setup)
  :config
  (setq elfeed-goodies/entry-pane-size 0.5))

;; Instalação do auto-update
(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "21:00"))

(use-package org-ai
  :ensure t
  :commands (org-ai-mode
             org-ai-global-mode)
  :init
  (add-hook 'org-mode-hook #'org-ai-mode) ; enable org-ai in org-mode
  (org-ai-global-mode) ; installs global keybindings on C-c M-a
  :config
  (setq org-ai-default-chat-model "gpt-3.5-turbo") ; if you are on the gpt-4 beta:
  (setq org-ai-openai-api-token "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")
  (org-ai-install-yasnippets)) ; if you are using yasnippet and want `ai` snippets


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; moodline do footer
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 35)
  (setq doom-modeline-bar-width 3)
  (setq doom-modeline-hud nil)
  (setq doom-modeline-project-detection 'auto)
  (setq doom-modeline-icon t)
  (setq doom-modeline-persp-name t)   ;; adds perspective name to modeline
  (setq doom-modeline-position-column-line-format '("%l:%c"))
  ) 

;;(use-package sudo-edit)