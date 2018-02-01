;; config pathes
(add-to-list 'load-path "~/.emacs.d/lib")
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
(set-default-font "Source Code Pro-16")

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; customize line number format
(setq linum-format " %2d ")

;; show trailing whiltespace
(setq-default show-trailing-whitespace t)

;; tab width 4, use space for indentation
(setq-default tab-width 4)
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
(global-auto-revert-mode t)
; (setq auto-revert-verbose nil)

;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; full path in title bar
(setq-default frame-title-format "%b (%f)")

;; no bell
(setq ring-bell-function 'ignore)

;; show column number
(setq column-number-mode t)

;; use narrow to region
(put 'narrow-to-region 'disabled nil)

;; an easy command for opening new shells
(defun new-shell ()
  "Opens a new shell buffer *shell*
    asterisks (*shell*) in the current directory and changes the
    prompt to 'bash>'."
  (interactive)
  (let ((name "*shell*"))
    (pop-to-buffer name)
    (unless (eq major-mode 'shell-mode)
      (shell (current-buffer))
      (sleep-for 0 200)
      (delete-region (point-min) (point-max))
      (comint-simple-send (get-buffer-process (current-buffer)) 
                          (concat "export PS1=\"\033[33mBash\033[0m:\033[35m\\W\033[0m$ \"")))))
(global-set-key (kbd "C-c s") 'new-shell)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;; commands ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun unix-file ()
  "Change the current buffer to Unix line-ends."
  (interactive)
  (set-buffer-file-coding-system 'unix t))

(defun dos-file ()
  "Change the current buffer to DOS line-ends."
  (interactive)
  (set-buffer-file-coding-system 'dos t))

(defun mac-file ()
  "Change the current buffer to Mac line-ends."
  (interactive)
  (set-buffer-file-coding-system 'mac t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;; plugins config ;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; config package repository
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; Download the ELPA archive description if needed.
(when (not package-archive-contents)
  (package-refresh-contents))

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
  'editorconfig
  'projectile
  'web-mode
  'js2-mode
  'protobuf-mode
  'yasnippet
  'imenu-anywhere
  'multiple-cursors
  'clojure-mode
  'paredit
  'tagedit)

;; evil mode
;; (require 'evil)
;; (evil-mode 1)

;; (load-theme 'atom-dark t)
(load-theme 'dracula t)

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-jsx-mode))

(editorconfig-mode t)

;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; multiple-cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-word-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-word-like-this)
(global-set-key (kbd "C-M->") 'mc/skip-to-next-like-this)
(global-set-key (kbd "C-M-<") 'mc/skip-to-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)

;; auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;; projectile
(projectile-global-mode)

;; imenu-anywhere
(global-set-key (kbd "C-.") 'imenu-anywhere)
