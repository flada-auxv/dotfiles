(add-to-list 'load-path "~/.emacs.d/elisp")

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
(global-auto-complete-mode t)
(define-key ac-completing-map (kbd "C-n") 'ac-next)
(define-key ac-completing-map (kbd "C-p") 'ac-previous)

(require 'yasnippet)
(yas-global-mode t)

;; key-bind
(global-set-key (kbd "C-m") 'newline-and-indent)

;; other
(show-paren-mode t)


;; ruby-mode
(defun ruby-mode-hook-ruby-elecrtric ()
  (ruby-electric-mode t))
(add-hook 'ruby-mode-hook 'ruby-mode-hook-ruby-elecrtric)

;; for-rbenv
(setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:"
		       (getenv "HOME") "/.rbenv/bin:"
		       (getenv "PATH")))
(setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims")
		      (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))


;; shceme-mode(use gauche)
(setq scheme-program-name "gosh")
(require 'cmuscheme)

(defun scheme-other-window ()
    "Run scheme on other window"
      (interactive)
        (switch-to-buffer-other-window
	    (get-buffer-create "*scheme*"))
	  (run-scheme scheme-program-name))

(define-key global-map
    "\C-cS" 'scheme-other-window)

























