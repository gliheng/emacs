(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; show matching parenthesis
(show-paren-mode t)
(electric-pair-mode t)
(global-linum-mode t)

;; fuzzy matching for opening files
(ido-mode t)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)

;; undo window layouts
;; C-c <left>, C-c <right> to move through window history
(winner-mode t)

;; hide menu bar
;; (menu-bar-mode 0) 

;; hide scroll bar
(if window-system (scroll-bar-mode 0))

;; hide tool bar
(require 'tool-bar)
(tool-bar-mode 0) 

;; change default home directory
(setq default-directory "~")

;; image
(setq fancy-splash-image (expand-file-name "emacs.png" user-emacs-directory))

;; font settings
(set-default-font "Source Code Pro-14")

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; customize line number format
(setq linum-format " %2d ")

;; show trailing whiltespace
(setq show-trailing-whitespace t)

;; tab width 4, use space for indentation
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)

;; encoding
(prefer-coding-system 'utf-8)

;; no autosave or backup
; (setq make-backup-files nil)
; (setq auto-save-default nil)

;; save autosave and backup somewhere else
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; window move keys
;; S-<left> S-<right> S-<up> S-<down> to move between windows
(windmove-default-keybindings)

;; pasted text replace current selection
(delete-selection-mode t)

;; revert buffer if file is changed on disk
(global-auto-revert-mode 1)
; (setq auto-revert-verbose nil)

;;;;;;;;;;;;;; plugins config ;;;;;;;;;;;;;

;; packages to install
(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.
 a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

(ensure-package-installed
  'dracula-theme
  'auto-complete
  'markdown-mode
  'projectile
  'web-mode
  'yasnippet
  'multiple-cursors)

;; evil mode
;; (require 'evil)
;; (evil-mode 1)

;; (load-theme 'atom-dark t)
(load-theme 'dracula t)

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))

;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; multiple-cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-word-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-word-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;; projectile
(projectile-global-mode)
