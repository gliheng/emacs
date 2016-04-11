(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

; show matching parenthesis
(show-paren-mode 1)
(electric-pair-mode 1)

; hide menu bar
; (menu-bar-mode 0) 

; hide scroll bar
(if window-system (scroll-bar-mode 0))

; hide tool bar
(require 'tool-bar)
(tool-bar-mode 0) 

; change default home directory
(setq default-directory "~")

;; image
; (setq fancy-splash-image (expand-file-name "logo.png" user-emacs-directory)) 

; font settings
(set-default-font "Source Code Pro-12")

;;;;;;;;;;;;;; plugins config ;;;;;;;;;;;;;

; packages to install
(setq 
  my-packages '(auto-complete
               markdown-mode
               web-mode
               yasnippet
               multiple-cursors
               evil
               ))   

; (require 'evil)
; (evil-mode 1)

; (load-theme 'atom-dark t)
(load-theme 'dracula t)

; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))

; yasnippet
(require 'yasnippet)
(yas-global-mode 1)

; multiple-cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-word-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-word-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)


