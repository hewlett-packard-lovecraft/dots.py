;;; init.el --- Haoming's personal Emacs configuration
;;; Commentary:
;; Bits and pieces copy-pasted from other people's configuration files
;; https://github.com/ianyepan/yay-evil-emacs/blob/master/config.org
;;; Code:

(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

;; automatically install use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

(use-package emacs
  :preface
  (defvar indent-width 4) ; change this value to your preferred width
  :config
  (setq frame-title-format '("Evil Emacs")
        ring-bell-function 'ignore
        frame-resize-pixelwise t
        default-directory "~/")

  (tool-bar-mode -1)
  ;(menu-bar-mode -1)

  ;; better scrolling experience
  (setq scroll-margin 0
        scroll-conservatively 101 ; > 100
        scroll-preserve-screen-position t
        auto-window-vscroll nil)

  (setq mouse-wheel-tilt-scroll t)

;; switch coalescing on and off based on the action.
(defun filter-mwheel-always-coalesce (orig &rest args)
  "A filter function suitable for :around advices that ensures only
   coalesced scroll events reach the advised function."
  (if mwheel-coalesce-scroll-events
      (apply orig args)
    (setq mwheel-coalesce-scroll-events t)))

(defun filter-mwheel-never-coalesce (orig &rest args)
  "A filter function suitable for :around advices that ensures only
   non-coalesced scroll events reach the advised function."
  (if mwheel-coalesce-scroll-events
      (setq mwheel-coalesce-scroll-events nil)
    (apply orig args)))

; Don't coalesce for high precision scrolling
(advice-add 'pixel-scroll-precision :around #'filter-mwheel-never-coalesce)

; Coalesce for default scrolling (which is still used for horizontal scrolling)
; and text scaling (bound to ctrl + mouse wheel by default).
(advice-add 'mwheel-scroll          :around #'filter-mwheel-always-coalesce)
(advice-add 'mouse-wheel-text-scale :around #'filter-mwheel-always-coalesce)

  ;; Always use spaces for indentation
  (setq-default indent-tabs-mode nil
                tab-width indent-width)

  ;; Omit default startup screen
  (setq inhibit-startup-screen t)

  ;; enable tab bar
  (setq tab-bar-mode 1)
  )

;; The Emacs default split doesn't seem too intuitive for most users.
(use-package emacs
  :ensure nil
  :preface
  (defun ian/split-and-follow-horizontally ()
    "Split window below."
    (interactive)
    (split-window-below)
    (other-window 1))
  (defun ian/split-and-follow-vertically ()
    "Split window right."
    (interactive)
    (split-window-right)
    (other-window 1))
  :config
  (global-set-key (kbd "C-x 2") #'ian/split-and-follow-horizontally)
  (global-set-key (kbd "C-x 3") #'ian/split-and-follow-vertically))

(use-package emacs
  :ensure nil
  :config

  ;; Always load newest byte code
  (setq load-prefer-newer t)

  ;; reduce the frequency of garbage collection by making it happen on
  ;; each 50MB of allocated data (the default is on every 0.76MB)
  (setq gc-cons-threshold 50000000)

  ;; warn when opening files bigger than 100MB
  (setq large-file-warning-threshold 100000000)

  ;; remember last opened file
  (recentf-mode 1)

  ;; restore the last cursor location of opened files
  (save-place-mode 1)

  ;; display line numbers
  (global-display-line-numbers-mode)

  ;; context menu
  (context-menu-mode))

;; Replace the active region just by typing text, just like modern editors.
(use-package delsel
  :ensure nil
  :config (delete-selection-mode +1))

;; Disable scroll-bar
(use-package scroll-bar
  :ensure nil
  :config (scroll-bar-mode -1))

;; Enable column numbers
(use-package simple
  :ensure nil
  :config (column-number-mode +1))

;; File-related tweaks
(use-package files
  :ensure nil
  :config

  ;;(setq confirm-kill-processes nil
  ;;      create-lockfiles nil ; don't create .# files (crashes 'npm start')
  ;;      make-backup-files nil)

  ;; store all backup and autosave files in the tmp dir
  (setq backup-directory-alist
        `((".*" . ,temporary-file-directory)))
  (setq auto-save-file-name-transforms
        `((".*" ,temporary-file-directory t)))
  )

;; Automatically refreshes the buffer for changes outside of Emacs
;; Auto refreshes every 2 seconds. Don’t forget to refresh the version control status as well.

(use-package autorevert
  :ensure nil
  :config
  (global-auto-revert-mode +1)
  (setq auto-revert-interval 2
        auto-revert-check-vc-info t
        global-auto-revert-non-file-buffers t
        auto-revert-verbose nil))

;; Slightly shorten eldoc display delay.
(use-package eldoc
  :ensure nil
  :diminish eldoc-mode
  :config
  (setq eldoc-idle-delay 0.4))

;; Indentation improvement
;; C, C++, and Java
(use-package cc-vars
  :ensure nil
  :config
  (setq-default c-basic-offset indent-width)
  (setq c-default-style '((java-mode . "java")
                          (awk-mode . "awk")
                          (other . "k&r"))))

;; Mouse wheel (track-pad) scroll speed
(use-package mwheel
  :ensure nil
  :config (setq mouse-wheel-scroll-amount '(2 ((shift) . 1))
                mouse-wheel-progressive-speed nil))

;; Mouse wheel (track-pad) scroll speed
(use-package paren
  :ensure nil
  :init (setq show-paren-delay 0)
  :config (show-paren-mode +1))

;; ;; hippie expand is dabbrev expand on steroids
;; (use-package hippie-exp
;;   :config
;;   (setq hippie-expand-try-functions-list '(try-expand-dabbrev
;;                                            try-expand-dabbrev-all-buffers
;;                                            try-expand-dabbrev-from-kill
;;                                            try-complete-file-name-partially
;;                                            try-complete-file-name
;;                                            try-expand-all-abbrevs
;;                                            try-expand-list
;;                                            try-expand-line
;;                                            try-complete-lisp-symbol-partially
;;                                            try-complete-lisp-symbol))
;;   )

;; use shift + arrow keys to switch between visible buffers
(use-package windmove
  :config
  (windmove-default-keybindings '(shift))
  )

(use-package dired
  :ensure nil
  :config
  ;; dired - reuse current buffer by pressing 'a'
  (put 'dired-find-alternate-file 'disabled nil)

  ;; always delete and copy recursively
  (setq dired-recursive-deletes 'always)
  (setq dired-recursive-copies 'always)

  ;; if there is a dired buffer displayed in the next window, use its
  ;; current subdir, instead of the current subdir of this dired buffer
  (setq dired-dwim-target t)

  ;; enable some really cool extensions like C-x C-j(dired-jump)
  (require 'dired-x)

  ;; Delete intermediate buffers when navigating through dired.
  (setq delete-by-moving-to-trash t)
  (eval-after-load "dired"
    #'(lambda ()
        (put 'dired-find-alternate-file 'disabled nil)
        (define-key dired-mode-map (kbd "RET") #'dired-find-alternate-file))))

;; meaningful names for buffers with the same name
(use-package uniquify
  :ensure nil
  :config
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-separator "/")
  (setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
  (setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers
  )

;; Enter ediff with side-by-side buffers to better compare the differences.
(use-package ediff
  :ensure nil
  :config
  (setq ediff-window-setup-function #'ediff-setup-windows-plain)
  (setq ediff-split-window-function #'split-window-horizontally))

;; Auto-pairing quotes and parentheses etc.
(use-package elec-pair
  :ensure nil
  :hook (prog-mode . electric-pair-mode))

(use-package whitespace
  :ensure nil
  :hook (before-save whitespace-cleanup)
  :config
  (setq whitespace-style (quote (face tabs empty trailing lines-tail)))
  )

;; (use-package desktop
;;   :config
;;   (desktop-save-mode +1))

;; Dump custom-set-variables to a garbage file and don’t load it
(use-package cus-edit
  :ensure nil
  :config
  (setq custom-file (concat user-emacs-directory "to-be-dumped.el")))


;; 3rd party packages
(use-package modus-themes
  :ensure t
  :config
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil)

  ;; Maybe define some palette overrides, such as by using our presets
  (setq modus-themes-common-palette-overrides
        modus-themes-preset-overrides-intense)

  ;; Load the theme of your choice.
  (load-theme 'modus-operandi)

  (define-key global-map (kbd "<f5>") #'modus-themes-toggle))

;;; For the built-in themes which cannot use `require'.
(use-package emacs
  :config
  (require-theme 'modus-themes) ; `require-theme' is ONLY for the built-in Modus themes

  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil)

  ;; Maybe define some palette overrides, such as by using our presets
  (setq modus-themes-common-palette-overrides
        modus-themes-preset-overrides-intense)

  ;; Load the theme of your choice.
  (load-theme 'modus-operandi)

  (define-key global-map (kbd "<f5>") #'modus-themes-toggle))

;; diminish keeps the modeline tidy
(use-package diminish
  :demand t)

(use-package crux)

(use-package all-the-icons)

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo
        dashboard-items nil
        dashboard-set-footer nil)
  )

;; Vi keybindings
(use-package evil
  :diminish undo-tree-mode
  :ensure t
  :init
  (setq evil-want-C-u-scroll t
        evil-want-keybinding nil
        evil-shift-width indent-width)
  (setq evil-emacs-state-modes nil)
  (setq evil-insert-state-modes nil)
  (setq evil-motion-state-modes nil)
  :hook (after-init . evil-mode)
  :preface
  (defun ian/save-and-kill-this-buffer ()
    (interactive)
    (save-buffer)
    (kill-this-buffer))
  :config
  (with-eval-after-load 'evil-maps ; avoid conflict with company tooltip selection
    (define-key evil-insert-state-map (kbd "C-n") nil)
    (define-key evil-insert-state-map (kbd "C-p") nil))
  (evil-ex-define-cmd "q" #'kill-this-buffer)
  (evil-ex-define-cmd "wq" #'ian/save-and-kill-this-buffer))

(use-package evil-collection
  :after evil
  :config
  (setq evil-collection-company-use-tng nil)
  (evil-collection-init))

;; vim-commentary for Emacs
;; (Use gcc to comment out a line, gc to comment out the target of a motion
;; (for example, gcap to comment out a paragraph), gc in visual mode to comment out the selection etc.)

(use-package evil-commentary
  :after evil
  :diminish
  :config (evil-commentary-mode +1))

(use-package ag)

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("M-p" . projectile-command-map)
              ("C-c p" . projectile-command-map))
  :config
  (setq projectile-project-search-path '("~/git" "~/.config/emacs")))

(use-package tab-bar)

(use-package highlight-numbers
  :hook (prog-mode . highlight-numbers-mode))

(use-package highlight-escape-sequences
  :hook (prog-mode . hes-mode))

(use-package super-save
  :config
  ;; automatically save buffers associated with files on buffer switch
  ;; and on windows switch
  ;; add integration with ace-window
  (add-to-list 'super-save-triggers 'ace-window)
  (super-save-mode +1)
  (diminish 'super-save-mode)
  )

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package ido
  :config
  (ido-mode +1)
  (setq ido-everywhere t
        ido-enable-flex-matching t))

(use-package ido-vertical-mode
  :config
  (ido-vertical-mode +1)
  (setq ido-vertical-define-keys 'C-n-C-p-up-and-down))

(use-package ido-completing-read+ :config (ido-ubiquitous-mode +1))

(use-package flx-ido :config (flx-ido-mode +1))

;; Company for auto-completion - Use C-n and C-p to navigate the tooltip.
(use-package company
  :diminish company-mode
  :hook (prog-mode . company-mode)
  :config
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.1
        company-selection-wrap-around t
        company-tooltip-align-annotations t
        company-frontends '(company-pseudo-tooltip-frontend ; show tooltip even for single candidate
                            company-echo-metadata-frontend))
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous))

;; add icons

;; linter
(use-package flycheck :config (global-flycheck-mode +1))

;; format all with control + shift + i
(use-package format-all
  :preface
  (defun ian/format-code ()
    "Auto-format whole buffer."
    (interactive)
    (if (derived-mode-p 'prolog-mode)
        (prolog-indent-buffer)
      (format-all-buffer)))
  :config
  (global-set-key (kbd "C-S-I") #'ian/format-code)
  (add-hook 'prog-mode-hook #'format-all-ensure-formatter))

(use-package which-key
  :ensure t
  :config
  (which-key-mode +1)
  (diminish 'which-key-mode))

;; Language support
(use-package lsp-mode
  :hook ((c-mode          ; clangd
          c++-mode        ; clangd
          c-or-c++-mode   ; clangd
          ;; java-mode       ; eclipse-jdtls
          js-mode         ; ts-ls (tsserver wrapper)
          js-jsx-mode     ; ts-ls (tsserver wrapper)
          typescript-mode ; ts-ls (tsserver wrapper)
          python-mode     ; pyright
          web-mode        ; ts-ls/HTML/CSS
          haskell-mode    ; haskell-language-server
          lua-mode        ; lua-language-server
          ) . lsp-deferred)

  :config ;; avoid problems with proccessing-mode
  (add-hook 'java-mode-hook #'(lambda () (when (eq major-mode 'java-mode) (lsp-deferred)))))

(use-package lsp-ui)

(use-package dap-mode
  :defer
  :config
  (setq dap-auto-configure-features '(sessions locals controls tooltip)))


(use-package iedit)

;; Org Mode
(use-package org
  :defer t
  :hook ((org-mode . visual-line-mode)
         (org-mode . org-indent-mode)))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

;; Useful major modes
(use-package markdown-mode
  :hook (markdown-mode . visual-line-mode))

(use-package web-mode
  :mode (("\\.html?\\'" . web-mode)
         ("\\.css\\'"   . web-mode)
         ("\\.jsx?\\'"  . web-mode)
         ("\\.tsx?\\'"  . web-mode)
         ("\\.json\\'"  . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2) ; HTML
  (setq web-mode-css-indent-offset 2)    ; CSS
  (setq web-mode-code-indent-offset 2)   ; JS/JSX/TS/TSX
  (setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))

  )

;; Python (both v2 and v3)
(use-package python
  :ensure nil
  :config (setq python-indent-offset indent-width))

(use-package elpy
  :ensure t
  :after python
  :init
  (advice-add 'python-mode :before 'elpy-enable))

;; c/cpp

;; https://emacs-lsp.github.io/lsp-mode/tutorials/CPP-guide/
(setq package-selected-packages '(lsp-mode yasnippet helm-lsp
    projectile hydra flycheck company avy which-key helm-xref dap-mode))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

(use-package cmake-mode
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'"))

(use-package cmake-font-lock
  :after (cmake-mode)
  :hook (cmake-mode . cmake-font-lock-activate))


(use-package yasnippet)

;; (use-package google-c-style
;;   :hook ((c-mode c++-mode) . google-set-c-style)
;;   (c-mode-common . google-make-newline-indent))

(use-package nerd-icons
  ;; :custom
  ;; The Nerd Font you want to use in GUI
  ;; "Symbols Nerd Font Mono" is the default and is recommended
  ;; but you can use any other Nerd Font if you want
  ;; (nerd-icons-font-family "Symbols Nerd Font Mono")
  )

(provide 'init)
;;; init.el ends here.
