(require 'package)
(setq package-enable-at-startup nil)

(setq package-archives '(("gnu"       . "http://elpa.gnu.org/packages/")
                         ("melpa"     . "https://melpa.org/packages/")
                         ))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(org-babel-load-file (expand-file-name "~/.emacs.d/Readme.org"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ccm-vpos-init '(round (* 21 (ccm-visible-text-lines)) 34))
 '(custom-safe-themes
   '("1aa4243143f6c9f2a51ff173221f4fd23a1719f4194df6cef8878e75d349613d" "266ecb1511fa3513ed7992e6cd461756a895dcc5fef2d378f165fed1c894a78c" default))
 '(git-commit-fill-column 1000)
 '(git-commit-finish-query-functions nil)
 '(git-commit-summary-max-length 1000)
 '(package-selected-packages
   '(org-roam-ui code-review github-review forge ripgrep wgrep-ag wgrep edit-indirect xterm-color nov multi-vterm vterm org-roam rubocop typescript-mode company-tabnine org-bullets multiple-cursors company lsp-mode which-key idle-highlight-mode yaml-mode dockerfile-mode countdown expand-region fill-column-indicator vlf whitespace-cleanup-mode slim-mode highlight-indent-guides indent-guide adoc-mode web-mode undo-tree centered-cursor-mode yasnippet ruby-refactor ruby-electric minitest rspec-mode rvm try centered-window auto-package-update use-package))
 '(rspec-docker-command "docker-compose run --rm")
 '(rspec-docker-container "web")
 '(rspec-use-docker-when-possible t)
 '(ruby-align-chained-calls t)
 '(ruby-refactor-add-parens t)
 '(truncate-lines nil)
 '(warning-suppress-log-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata" :slant normal :weight normal :height 130 :width normal))))
 '(font-lock-comment-face ((t (:foreground "dark gray"))))
 '(fringe ((t (:background "#000000"))))
 '(hl-line ((t (:extend t :background "gray20"))))
 '(magit-section-highlight ((t (:inherit hl-line :extend t :background "SkyBlue4"))))
 '(markup-meta-face ((t (:stipple nil :foreground "light pink" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown" :family "Monospace"))))
 '(markup-title-0-face ((t (:inherit markup-gen-face :height 1.7))))
 '(markup-title-1-face ((t (:inherit markup-gen-face :height 1.6))))
 '(markup-title-2-face ((t (:inherit markup-gen-face :height 1.5))))
 '(markup-title-3-face ((t (:inherit markup-gen-face :weight bold :height 1.4))))
 '(region ((t (:extend t :background "RoyalBlue4")))))
(put 'narrow-to-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
