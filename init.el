;; requires
(require 'package)
(require 'use-package)
(require 'reftex) ;; latex

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
(use-package pdf-tools) ;; pdf viewing

;; lang modes
(use-package go-mode) ;; for psws
(use-package slime) ;; for lisping
(use-package powershell) ;; shellpower
(use-package auctex) ;; latex
(use-package fennel-mode) ;; Fennel

;; preferences
(setq-default tab-width 3)
(setq-default indent-tabs-mode nil)

;; cc setup
(add-hook 'c-mode-hook #'eglot-ensure)
(add-hook 'c++-mode-hook #'eglot-ensure)
(setq c-default-style '((other . "ellemtel"))) ;; auto ellemtel

;; go setup
(add-hook 'go-mode-hook #'eglot-ensure)
(add-hook 'go-mode-hook (lambda () (setq indent-tabs-mode t)))

;; lisp & slime
;;; slime setup
(slime-setup '(slime-fancy slime-quicklisp slime-asdf slime-mrepl))
(setq inferior-lisp-program "sbcl")
;;; convenience for lisp-mode
(add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode))
(defun my/slime-auto-start ()
  (unless (slime-connected-p)
    (save-selected-window
      (slime))))
(add-hook 'slime-mode-hook #'my/slime-auto-start)

;; powershell setup
(setq powershell-indent 3
      powershell-continuation-indent 3)

;; Fennel setup
(add-hook 'fennel-mode-hook 'eglot-ensure)

;; pdf-tools setup
(pdf-loader-install)

;; Makefile setup
(add-hook 'makefile-mode-hook (lambda () (setq indent-tabs-mode t)))

;; latex setup
;;; AUCTeX
;;;; indentation
(setq LaTeX-indent-level 3)
(setq TeX-brace-indent-level 3)
;;;; config
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
;;; checking & typing
(setq TeX-electric-math '("$" . "$"))
(add-hook 'LaTeX-mode-hook #'flymake-mode)
;;;; compilation
(setq TeX-view-program-selection
      '((output-pdf "PDF Tools")))
(add-hook 'pdf-view-mode-hook #'pdf-view-roll-minor-mode)
(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer) ;; auto-ref
;;; RefTex
(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ;; w/ AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex) ;; w/ Emacs latex mode
