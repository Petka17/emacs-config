;; Package setup START
(require 'package)
	    
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmod.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
;; Package setup END

;; Debugging
;; (use-package command-log-mode
;;   :config
;;   (global-command-log-mode t)
;;   (clm/open-command-log-buffer))

;; =Look and feel=

(setq inhibit-startup-message t)

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)

;;(setq visible-bell t)

(set-face-attribute 'default nil :font "JetBrains Mono" :height 150)

;; Icons
(use-package all-the-icons)

;; Doom theme
(use-package doom-themes
  :init (load-theme 'doom-one t))

;; Doom command line
(use-package doom-modeline
  :init (doom-modeline-mode 1))

;; Line Numbers
(global-display-line-numbers-mode t)
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(column-number-mode)

;; Rainbow delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Counsel
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; Don't start searh with ^

;; Fuzzy matching for duffirent lists
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line))
  :config
  (ivy-mode 1))

;; Ivy Rich
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; Which Key
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0))

;; Helpful
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; Evil Mode
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Keybindings
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "M-J") 'counsel-switch-buffer)

;; Projectile
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Developer")
    (setq projectile-project-search-path '("~/Developer/jasper"
					   "~/Developer/bookswap"
					   "~/Developer/crew-new"
					   "~/Developer")))
  (setq projectile-switch-project-action #'projectile-dired))
