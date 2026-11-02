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
(use-package powershell) ;; powershell

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
