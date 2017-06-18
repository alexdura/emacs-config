(setq inhibit-splash-screen 1)

(setenv "PATH"
	(concat
	 (getenv "PATH") ":"
	 "/usr/local/bin" ":"
	 "/usr/bin" ":"
	 "/usr/sbin" ":"
	 "/opt/local/sbin" ":"
	 "/opt/local/bin"))

;; Disable toolbars
(tool-bar-mode -1)
;; Disable scrollbars
(scroll-bar-mode -1)
;; (menu-bar-mode -1)

(global-linum-mode 1)

(add-to-list 'load-path "~/.emacs.d/modes/")
(add-to-list 'load-path "~/.emacs.d/sr-speedbar/")
(add-to-list 'load-path "~/.emacs.d/rtags/")


;; Load package.el
(require 'package)
;; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa2" . "http://melpa-stable.milkbox.net/packages/"))
(package-initialize)


;; Hide details when loading dired
(require 'dired-details)
(dired-details-install)
(defun dired-mode-hook ()
  (dired-details-initially-hide))

;; y or n for questions
(fset 'yes-or-no-p 'y-or-n-p)

;; C styles
(c-add-style "cmpbe" '("bsd"
					  (c-basic-offset . 4)
					  (tab-width . 4)
					  (indent-tabs-mode t)))

(setq c-default-style "cmpbe")

;; LLVM Coding style
;; Alternative to setting the global style.  Only files with "llvm" in
;; their names will automatically set to the llvm.org coding style.
(c-add-style "llvm.org"
			 '((fill-column . 80)
			   (c++-indent-level . 2)
			   (c-basic-offset . 2)
			   (indent-tabs-mode . nil)
			   (c-offsets-alist . ((innamespace 0)))))

(c-add-style "llvm.org.tabs"
	     '("llvm.org"
	       (indent-tabs-mode . t)))

(add-hook 'c-mode-hook
	  (function
	   (lambda nil
		 (if (string-match "llvm" buffer-file-name)
		 (progn
		   (c-set-style "llvm.org")
		   )
		 ))))

(add-hook 'c++-mode-hook
	  (function
	   (lambda nil
		 (if (or (string-match "llvm" buffer-file-name) (string-match "Bifrost" buffer-file-name))
		 (progn
		   (c-set-style "llvm.org")
		   )
		 ))))

;; There is a joy in pressing enter. Disable auto-newline.
(add-hook 'c-mode-hook
	  (function
	   (lambda nil
	     (c-toggle-auto-newline -1)
	     )))

(add-hook 'c++-mode-hook
	  (function
	   (lambda nil
	     (c-toggle-auto-newline -1)
	     )))

;; delete trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; (require 'ws-butler)
;; (ws-butler-global-mode)

;; Haskell modes
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-to-list 'exec-path "~/.cabal/bin")
(add-to-list 'exec-path "/usr/local/bin")


;; Whitespace display
(require 'whitespace)			;
(setq whitespace-display-mappings
	  '(
		(space-mark 32 [32])
		(newline-mark 10 [10])
		(tab-mark 9 [62 9])
		))
(setq whitespace-line-column 1024)
;; face for Tabs
(set-face-attribute 'whitespace-tab nil
					:foreground 'unspecified
					:background 'unspecified
					:weight 'bold)
(set-face-attribute 'whitespace-space nil
					:foreground 'unspecified
					:background 'unspecified
					:weight 'bold)

(global-whitespace-mode)

;; Color theme
;; (require 'color-theme)
;; (color-theme-initialize)
;; (color-theme-solarized-light)
;;(if window-system
;;    (load-theme 'atom-one-dark t))
;;    (load-theme 'leuven t))
(load-theme 'solarized-dark)

;; Undo tree
(require 'undo-tree)
(global-undo-tree-mode)

;; (require 'project-explorer)

;; GLSL mode
(autoload 'glsl-mode "glsl-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.comp\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.glsl\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.tese\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.tesc\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.geom\\'" . glsl-mode))

;; LL mode
(autoload 'llvm-mode "llvm-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.ll\\'" . llvm-mode))


;; TD mode
(autoload 'tablegen-mode' "tablegen-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.td\\'" . tablegen-mode))

;; CL files
(add-to-list 'auto-mode-alist '("\\.cl\\'" . c-mode))

;; sconscript
(add-to-list 'auto-mode-alist '("sconscript" . python-mode))
(add-to-list 'auto-mode-alist '("sconstruct" . python-mode))

;; C++ headers with .h extenstion
;; (add-to-list 'auto-mode-alist '("\\llvm.*.h\\" . c++-mode))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(speedbar-file-face ((t (:foreground "dark cyan"))))
 '(whitespace-indentation ((t (:background "gray20" :foreground "firebrick"))))
 '(whitespace-space-after-tab ((t (:background "gray20" :foreground "firebrick"))))
 '(whitespace-tab ((t (:foreground "dim gray" :weight extra-light)))))

;; set the bash as shell
(setq explicit-shell-file-name "/bin/bash")
(setenv "SHELL" "/bin/bash")

;; Force gdb-mi to not dedicate any windows
(defadvice gdb-display-buffer (after undedicate-gdb-display-buffer)
  (set-window-dedicated-p ad-return-value nil))
(ad-activate 'gdb-display-buffer)

(defadvice gdb-set-window-buffer (after undedicate-gdb-set-window-buffer (name &optional ignore-dedi window))
  (set-window-dedicated-p window nil))
(ad-activate 'gdb-set-window-buffer)

;; Package for transposing the entire frame
(require 'transpose-frame)

;; Code navigation
(require 'rtags)
(require 'company)
(setq rtags-completions-enabled t)
(setq rtags-close-taglist-on-focus-lost t)
(push 'company-rtags company-backends)
(define-key c-mode-base-map (kbd "<M-/>") (function company-complete))
(load-file "~/.emacs.d/rtags/rtags_config.el")
(add-hook 'after-init-hook 'global-company-mode)

;; load this before sr-speedbar
(require 'helm)

;; sr-speedbar config
(require 'sr-speedbar)
(setq sr-speedbar-default-width 25)
(setq sr-speedbar-max-width 25)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-skip-other-window-p t)
;;(sr-speedbar-open)

;; 80 column rule
(require 'column-marker)
(add-hook 'c-mode-common-hook (lambda () (interactive) (column-marker-1 80)))
;; automatic indentation in C
(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))
;; disable auto-newline
(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-newline 0)))

;; ediff configuration

(add-hook 'ediff-before-setup-hook 'new-frame)
(add-hook 'ediff-quit-hook 'delete-frame)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-global-modes (quote (not gud-mode)))
 '(csv-separators (quote (";")))
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "43c1a8090ed19ab3c0b1490ce412f78f157d69a29828aa977dae941b994b4147" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(global-company-mode t)
 '(package-selected-packages
   (quote
    (helm solarized-theme undo-tree transpose-frame rtags leuven-theme irony ggtags dired-details company-ghc color-theme cmake-mode atom-one-dark-theme)))
 '(speedbar-directory-button-trim-method (quote trim))
 '(speedbar-show-unknown-files t)
 '(whitespace-line-column 1024))
