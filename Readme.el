(use-package auto-package-update :ensure t)

(use-package try :ensure t)

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package org-roam :ensure t)

(setq org-roam-directory (file-truename "/home/vagrant/second-brain"))
(org-roam-db-autosync-mode)

(global-set-key (kbd "C-c a") 'org-roam-node-find)
(global-set-key (kbd "C-c t") 'org-roam-tag-add)
(global-set-key (kbd "C-c i") 'org-roam-node-insert)
(global-set-key (kbd "C-c u") 'org-roam-ui-open)

(use-package magit :ensure t)

(global-set-key (kbd "C-c g") 'magit-status)
(global-set-key (kbd "C-c C-g") 'magit-status)

(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows)
  (magit-section-show-level-2-all))

(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))
(define-key magit-status-mode-map (kbd "q") 'magit-quit-session)

(custom-set-variables
 '(git-commit-fill-column 1000)
 '(git-commit-finish-query-functions nil)
 '(git-commit-summary-max-length 1000))

(use-package forge :ensure t)
(ghub-request "GET" "/user" nil
              :forge 'github
              :host "api.github.com"
              :username "iachettifederico"
              :auth 'forge)

(use-package code-review :ensure t)

(setq code-review-auth-login-marker 'forge)

(global-emojify-mode t)

(put 'dired-find-alternate-file 'disabled nil)

(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

(defun dired-back-to-top ()
  (interactive)
  (beginning-of-buffer)
  (dired-next-line 1)
  (dired-next-line 1)
  (dired-next-line 1))

(define-key dired-mode-map
  (vector 'remap 'beginning-of-buffer) 'dired-back-to-top)

(defun dired-jump-to-bottom ()
  (interactive)
  (end-of-buffer)
  (dired-next-line -1))

(define-key dired-mode-map
  (vector 'remap 'end-of-buffer) 'dired-jump-to-bottom)

(setq dired-listing-switches "-aBhl  --group-directories-first")

(setq-default dired-omit-files-p nil) ; Buffer-local variable

(setq dired-omit-files "^\\.?#\\|^\\.$\\|^\\.[^\\.]")
;; (setq dired-omit-mode t) ; Turn on Omit mode.
(setq dired-omit-verbose nil) ; Turn off Omit mode messages.

(require 'dired-x)

(add-hook 'dired-mode-hook
          (lambda ()
            (dired-hide-details-mode t)))

;;;###autoload
(defun fdx/kill-other-buffers ()
  "Kill all buffers but the current one.
Don't mess with special buffers."
  (interactive)
  (dolist (buffer (buffer-list))
    (unless (or (eql buffer (current-buffer)) (not (buffer-file-name buffer)))
      (progn
        (kill-buffer buffer)
        ))
    (delete-other-windows)))

(global-set-key (kbd "C-c k") 'fdx/kill-other-buffers)

(global-set-key (kbd "C-x C-w")
                (lambda ()
                  (interactive)
                  (switch-to-buffer "*scratch*")))

(defun fdx/reuse-buffers ()
  (interactive)
  (add-to-list 'display-buffer-alist
               '(".*". (display-buffer-reuse-window .
                                                    ((reusable-frames . t))))))

;; Make directories on the fly
(defun make-parent-directory ()
  "Make sure the directory of `buffer-file-name' exists."
  (make-directory (file-name-directory buffer-file-name) t))

(add-hook 'find-file-not-found-functions #'make-parent-directory)

(global-set-key (kbd "C-M-<left>")  'windmove-left)
(global-set-key (kbd "C-M-<right>") 'windmove-right)
(global-set-key (kbd "C-M-<up>")    'windmove-up)
(global-set-key (kbd "C-M-<down>")  'windmove-down)

(global-set-key (kbd "C-M-w") 'balance-windows)

(winner-mode 1)

(setq split-width-threshold 0)
(setq split-height-threshold nil)

(use-package swiper
  :ensure t
  :bind (
         ("C-s" . swiper)
         ("C-r" . swiper)
         ("C-c C-r" . ivy-resume)
         ("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         )
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t)
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> l") 'counsel-find-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
    ))

(use-package ivy
  :ensure t
  :config
  (require 'ivy))

(use-package flx
  :ensure t
  :config
  (require 'flx))

(setq ivy-use-virtual-buffers t)

;; intentional space before end of string
(setq ivy-count-format "(%d/%d) ")
(setq ivy-initial-inputs-alist nil)

(setq ivy-re-builders-alist
      '((swiper . ivy--regex-plus)
        (t      . ivy--regex-fuzzy)))

;; Use C-j for immediate termination with current value
(define-key ivy-minibuffer-map (kbd "C-j") #'ivy-immediate-done)
;; Use RET for continuing completion for that directory
(define-key ivy-minibuffer-map (kbd "RET") #'ivy-alt-done)

(ivy-mode 1)

(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode))

(setq undo-tree-auto-save-history nil)

(global-set-key (kbd "H-j") (lambda ()
                              (interactive)
                              (join-line -1)))

(column-number-mode)

;;;###autoload
(defun fdx/toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(global-set-key (kbd "C-x /") 'fdx/toggle-window-split)

(delete-selection-mode 1)

(global-display-line-numbers-mode 1)

(global-hl-line-mode 1)

;;;###autoload
(defun fdx/duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))

;;;###autoload
(defun fdx/move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

;;;###autoload
(defun fdx/move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

;;;###autoload
(defun fdx/open-line-below ()
  "Open an empty line above the current one and move."
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))

;;;###autoload
(defun fdx/open-line-above ()
  "Open an empty line above the current one and move."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key (kbd "C-<return>") 'fdx/open-line-below)
(global-set-key (kbd "C-S-<return>") 'fdx/open-line-above)

(defun fdx/paste-replacing-tabs-with-commas ()
  (interactive)
  (insert (replace-regexp-in-string "\t" "," (car kill-ring)))
  )

(require 'iso-transl)

(save-place-mode 1)

(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (expand-file-name "~/.emacs.d/backups")))))

(setq vc-make-backup-files t)
(setq create-lockfiles nil)

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun fdx/rename-current-file (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive (list (read-string "sNew name: " (buffer-name))))
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

;;;###autoload
(defun fdx/delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (progn
          (delete-file filename)
          (message "Deleted file %s" filename)
          (kill-buffer))))))

(defun fdx/touch-current-file ()
  "updates mtime on the file for the current buffer"
  (interactive)
  (shell-command (concat "touch " (shell-quote-argument (buffer-file-name))))
  (clear-visited-file-modtime))

(defun fdx/chmod-current-file ()
  "updates mtime on the file for the current buffer"
  (interactive)
  (chmod (buffer-file-name) (read-file-modes)))

(require 'ansi-color)
(defun fdx/display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))

(require 'ansi-color)
(defun endless/colorize-compilation ()
  "Colorize from 'compilation-filter-start' to 'point'."
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region
     compilation-filter-start (point))))

(add-hook 'compilation-filter-hook
          'endless/colorize-compilation)

(use-package xterm-color :ensure t)
(require 'xterm-color)
(setq compilation-environment '("TERM=xterm-256color"))
(defun my/advice-compilation-filter (f proc string)
  (funcall f proc (xterm-color-filter string)))
(advice-add 'compilation-filter :around #'my/advice-compilation-filter)

(setenv "TERM" "256colors")

(add-to-list 'auto-mode-alist '("\\.org\\'"      . org-mode))
