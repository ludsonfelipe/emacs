;; Verifica e inicia o package.el
(require 'package)

;; Definição de repositórios
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org"   . "https://orgmode.org/elpa/")
                         ("elpa"  . "https://elpa.gnu.org/packages/")))

;; myPackages contains a list of package names
(defvar myPackages
  '(material-theme                  ;; Theme
    flycheck
    neotree
    elpy
    blacken
    ein
    )
  )

;;(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; Inicialização do sistema de pacotes
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

; Instalação do use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

(setq inhibit-startup-message t)    ;; Hide the startup message

;;(setq neo-theme (if (display-graphic-p) 'arrow))
;; Carregando tema material
(load-theme 'material t)

;; Ativando elpy
(elpy-enable)

;;Setando bind f8 para neotree
(global-set-key [f8] 'neotree-toggle)
(global-set-key [f7] 'pyvenv-activate)
(global-set-key [f6] 'pyvenv-deactivate)
;;(global-set-key (kbd "C-c s") 'shell)

(defun my-shell-below ()
  "Abre um buffer de shell na parte inferior."
  (interactive)
  (split-window-below)
  (other-window 2)
  (shell))

(global-set-key (kbd "C-c s") 'my-shell-below)

;; Use IPython for REPL
(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)
(add-to-list 'python-shell-completion-native-disabled-interpreters
             "jupyter")

;; Enable Flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Instalação do auto-update
(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "21:00"))

; Exibe numeração de linhas
(global-display-line-numbers-mode t)

;; linha colorida
(global-hl-line-mode t)

;; Rolagem mais suave
(setq mouse-wheel-scroll-amount '(2 ((shift) . 1))
      mouse-wheel-progressive-speed nil
      mouse-wheel-follow-mouse 't
      scroll-step 1)

; Inibe Ctrl-Z (suspend frame)
(global-unset-key (kbd "C-z"))

;; alerta visual
(setq visible-bell t)

;; (tool-bar-mode   -1)                 ; Oculta a barra de ferramentas
;; (menu-bar-mode   -1)                 ; Oculta a barra de menu
;; (tooltip-mode -1)
(require 'clipetty)
(global-clipetty-mode)

;; Organizando os backups
(setq backup-directory-alist `(("." . "~/.saves")))
(setq x-select-enable-clipboard t)