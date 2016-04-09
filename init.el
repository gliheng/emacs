(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-initialize)


(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-word-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-word-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

; (require 'evil)
; (evil-mode 1)

; (load-theme 'atom-dark t)
(load-theme 'dracula t)

; show matching parenthesis
(show-paren-mode 1)

; hide menu bar
; (menu-bar-mode 0) 

; hide scroll bar
(if window-system (scroll-bar-mode 0))

; hide tool bar
(require 'tool-bar)
(tool-bar-mode 0) 

; change default home directory
(setq default-directory "~")


; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))

; yasnippet
(require 'yasnippet)
(yas-global-mode 1)


