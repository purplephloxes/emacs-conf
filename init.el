;; requires
(require 'package)
(require 'use-package)

;; package management
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
	("nongnu" . "https://elpa.nongnu.org/nongnu/")
	("melpa" . "https://melpa.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(setq use-package-always-ensure t)

;; basics
(use-package magit)

;; lang modes
(use-package go-mode) ;; for psws
(use-package slime) ;; for lisping



;; eglot hooks
;;; cc
(add-hook 'c-mode-hook #'eglot-ensure)
(add-hook 'c++-mode-hook #'eglot-ensure)
;;; go
(add-hook 'go-mode-hook #'eglot-ensure)


;; preferences
;;; tab = 3 spaces
(setq-default tab-width 3)
(setq-default indent-tabs-mode nil)

;;; c style = ellemtel
(setq c-default-style '((other . "ellemtel")))

;;; slime config
(slime-setup '(slime-fancy slime-quicklisp slime-asdf slime-mrepl))
(setq inferior-lisp-program "sbcl")
