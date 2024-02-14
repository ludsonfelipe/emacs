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

;; Inicia em full screen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Set fonts
(set-face-attribute 'default nil :height 100 :family "JetBrains Mono Medium")

;; Instalando Icons
(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

;; Gerenciador de binds
(use-package which-key
  :ensure t
  :config (which-key-mode))

;; Gerenciador de arquivos
(use-package peep-dired)

(use-package dired-rainbow
  :ensure t
  :config
  (progn
    (dired-rainbow-define-chmod directory "#6cb2eb" "d.*")
    (dired-rainbow-define html "#eb5286" ("css" "less" "sass" "scss" "htm" "html" "jhtm" "mht" "eml" "mustache" "xhtml"))
    (dired-rainbow-define xml "#f2d024" ("xml" "xsd" "xsl" "xslt" "wsdl" "bib" "json" "msg" "pgn" "rss" "yaml" "yml" "rdata"))
    (dired-rainbow-define document "#9561e2" ("docm" "doc" "docx" "odb" "odt" "pdb" "pdf" "ps" "rtf" "djvu" "epub" "odp" "ppt" "pptx"))
    (dired-rainbow-define markdown "#ffed4a" ("org" "etx" "info" "markdown" "md" "mkd" "nfo" "pod" "rst" "tex" "textfile" "txt"))
    (dired-rainbow-define database "#6574cd" ("xlsx" "xls" "csv" "accdb" "db" "mdb" "sqlite" "nc"))
    (dired-rainbow-define media "#de751f" ("mp3" "mp4" "MP3" "MP4" "avi" "mpeg" "mpg" "flv" "ogg" "mov" "mid" "midi" "wav" "aiff" "flac"))
    (dired-rainbow-define image "#f66d9b" ("tiff" "tif" "cdr" "gif" "ico" "jpeg" "jpg" "png" "psd" "eps" "svg"))
    (dired-rainbow-define log "#c17d11" ("log"))
    (dired-rainbow-define shell "#f6993f" ("awk" "bash" "bat" "sed" "sh" "zsh" "vim"))
    (dired-rainbow-define interpreted "#38c172" (".py" "ipynb" "rb" "pl" "t" "msql" "mysql" "pgsql" "sql" "r" "clj" "cljs" "scala" "js"))
    (dired-rainbow-define compiled "#4dc0b5" ("asm" "cl" "lisp" "el" "c" "h" "c++" "h++" "hpp" "hxx" "m" "cc" "cs" "cp" "cpp" "go" "f" "for" "ftn" "f90" "f95" "f03" "f08" "s" "rs" "hi" "hs" "pyc" ".java"))
    (dired-rainbow-define executable "#8cc4ff" ("exe" "msi"))
    (dired-rainbow-define compressed "#51d88a" ("7z" "zip" "bz2" "tgz" "txz" "gz" "xz" "z" "Z" "jar" "war" "ear" "rar" "sar" "xpi" "apk" "xz" "tar"))
    (dired-rainbow-define packaged "#faad63" ("deb" "rpm" "apk" "jad" "jar" "cab" "pak" "pk3" "vdf" "vpk" "bsp"))
    (dired-rainbow-define encrypted "#ffed4a" ("gpg" "pgp" "asc" "bfe" "enc" "signature" "sig" "p12" "pem"))
    (dired-rainbow-define fonts "#6cb2eb" ("afm" "fon" "fnt" "pfb" "pfm" "ttf" "otf"))
    (dired-rainbow-define partition "#e3342f" ("dmg" "iso" "bin" "nrg" "qcow" "toast" "vcd" "vmdk" "bak"))
    (dired-rainbow-define vc "#0074d9" ("git" "gitignore" "gitattributes" "gitmodules"))
    (dired-rainbow-define-chmod executable-unix "#38c172" "-.*x.*")
    )) 

;; Icons no modo dired
(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

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


;; THEME - Transparent
(use-package transwin)
(load-theme 'Lfroes t)

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
  (setq dashboard-display-icons-p t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Consistência é mais importante que velocidade.")
  (setq dashboard-startup-banner "~/.emacs.d/logo/LFroes.png")
  (setq dashboard-center-content t) 
  (setq dashboard-items '((recents . 8)
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
  (setq elpy-modules (delq 'elpy-module-flymake py-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Linha com highlight
(setq elpy-remove-modeline-lighter t)

(advice-add 'elpy-modules-remove-modeline-lighter
            :around (lambda (fun &rest args)
                      (unless (eq (car args) 'flymake-mode)
                        (apply fun args))))

;; Auto pep8 ao salvar
(use-package py-autopep8
  :hook ((python-mode) . py-autopep8-mode))

; Tree folders lateral
(use-package neotree
  :ensure t
  :config
  (progn
    (setq neo-theme (if (display-graphic-p) 'icons))
    (setq neo-window-width 35))) 

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

;; Substitui texto selecionado
(delete-selection-mode 1)

;; Unbind Z
(global-unset-key (kbd "C-z"))

(use-package eshell-toggle
  :custom
  (eshell-toggle-size-fraction 4)
  (eshell-toggle-use-projectile-root t)
  (eshell-toggle-run-command nil)
  (eshell-toggle-init-eshell)
  :bind
  ("C-z s" . eshell-toggle))

(use-package eshell-syntax-highlighting
  :after esh-mode
  :config
  (eshell-syntax-highlighting-global-mode +1))

;; Varios cursores
(use-package multiple-cursors)

;; ###################################
;; ############# BINDs ###############
;; ###################################

(global-set-key [f6] 'transwin-toggle)
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-x f") 'elfeed)
(global-set-key (kbd "C-c d") 'dashboard-open)

;; CTRL + C Window Resize
(global-set-key (kbd "C-c <left>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-c <right>") 'shrink-window-horizontally)
(global-set-key (kbd "C-c <up>") 'enlarge-window)
(global-set-key (kbd "C-c <down>") 'shrink-window)

;; CTRL + Z  Cria, Sobe, Derruba Window
(global-set-key (kbd "C-z <down>") 'delete-window)
(global-set-key (kbd "C-z <up>") 'split-window-right)
(global-set-key (kbd "C-z <left>") 'neotree-toggle)

;; Auxiliares
(global-set-key (kbd "C-z i") 'indent-region) ;; Indentaçao
(global-set-key (kbd "C-z ;") 'comment-dwim) ;; Criar comentário
(global-set-key (kbd "C-z ,") 'beginning-of-line) ;; Começo Da Linha
(global-set-key (kbd "C-z .") 'end-of-line) ;; Final da linha
(global-set-key (kbd "C-z v") 'xref-find-definitions) ;; Definição de uma variavel 
(global-set-key (kbd "C-z l") 'elpy-shell-send-statement-and-step) ;; Código por linha
(global-set-key (kbd "C-z #") 'elpy-shell-send-codecell-and-step) ;; Roda código por ##
(global-set-key (kbd "C-z r") 'elpy-shell-send-region-or-buffer) ;; Roda código por reg
(global-set-key (kbd "C-z e") 'elpy-flymake-next-error) ;; Check erros com flymake
(global-set-key (kbd "C-z d") 'elpy-doc) ;; Check docs
(global-set-key (kbd "C-z h") 'elpy-folding-toggle-at-point) ;; Esconde docs, funcões etc
(global-set-key (kbd "C-z c") 'elpy-multiedit-python-symbol-at-point) ;; Troca variaveis
(global-set-key (kbd "C-z j") 'elpy-refactor-rename) ;; Troca variaveis modo jedi
(global-set-key (kbd "C-z a") 'pyvenv-activate) ;; Ativa env
(global-set-key (kbd "C-z b") 'pyvenv-create) ;; Cria env
(global-set-key (kbd "C-z k") 'pyvenv-workon) ;; Workon 

;; Cursor
(global-set-key (kbd "M-s M-a") 'mc/mark-next-word-like-this) ;; Marca word exata
(global-set-key (kbd "M-s M-s") 'mc/mark-next-like-this) ;; Marca selecao
(global-set-key (kbd "M-s a") 'mc/mark-all-words-like-this) ;; Marca word exata
(global-set-key (kbd "M-s w") 'mc/mark-all-like-this) ;; Marca selecao
(global-set-key (kbd "C->") 'mc/mark-next-like-this) ;; Marca proxima linha
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this) ;; Marca linha anterior
(global-set-key (kbd "M-s e") 'mc/edit-ends-of-lines) ;; End Of Line
(global-set-key (kbd "M-s s") 'mc/edit-beginnings-of-lines) ;; Start Of Line


;; Jupyter Notebook + Ipython
(use-package ein)
;; Use IPython for REPL
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

;; Ative o company-mode globalmente
(add-hook 'after-init-hook 'global-company-mode)

;; Instale e configure o company-terraform
(use-package company-terraform
  :ensure t
  :after company
  :config
  (add-to-list 'company-backends 'company-terraform))

;; Instale e configure o terraform-mode (opcional)
(use-package terraform-mode
  :ensure t
  :custom (terraform-format-on-save-mode t)
    (add-hook 'terraform-mode-hook 'my-terraform-mode-init))

(use-package company-quickhelp)

(use-package docker-compose-mode)
(use-package docker
  :ensure t
  :bind ("C-c C-d" . docker))

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

;; Altera window
(use-package ace-window
  :ensure t
  :bind (("C-z <right>" . ace-window ))
  )

;; Instalação do auto-update
(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "21:00"))

;;(use-package sudo-edit)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(ace-window which-key transwin rainbow-mode py-autopep8 projectile peep-dired neotree multiple-cursors eshell-toggle eshell-syntax-highlighting elpy elfeed-goodies ein doom-themes doom-modeline docker-compose-mode docker dired-rainbow dashboard company-terraform company-quickhelp auto-package-update all-the-icons-dired)))
