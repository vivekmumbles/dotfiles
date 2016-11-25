

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))

 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Hack" :foundry "unknown" :slant normal :weight normal :height 98 :width normal)))))

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/") t)
  (package-initialize))

(load-theme 'gruvbox t)
					; (load-theme 'base16-tomorrow-dark t)

(require 'multiple-cursors)

(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
	(setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))

(global-set-key (kbd "C-/") 'comment-or-uncomment-region-or-line)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(global-set-key (kbd "M-2") 'mc/mark-next-like-this)
(global-set-key (kbd "M-1") 'mc/mark-previous-like-this)


(setq c-default-style "linux"
      c-basic-offset 4)

(global-linum-mode t)
(setq linum-format "%4d \u2502 ")


(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
	(exchange-point-and-mark))
    (let ((column (current-column))
	  (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (beginning-of-line)
    (when (or (> arg 0) (not (bobp)))
      (forward-line)
      (when (or (< arg 0) (not (eobp)))
	(transpose-lines arg))
      (forward-line -1)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
 arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
 arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

(global-set-key [\M-up] 'move-text-up)
(global-set-key [\M-down] 'move-text-down)

(defun my-c-mode-hook ()
  (setq comment-start "//")
  (setq comment-end ""))
(add-hook 'c-mode-hook 'my-c-mode-hook)

(set-face-attribute 'default nil :height 100)

(global-visual-line-mode t)

;; predictive install location
(add-to-list 'load-path "~/.emacs.d/predictive/")
;; dictionary locations
(add-to-list 'load-path "~/.emacs.d/predictive/latex/")
(add-to-list 'load-path "~/.emacs.d/predictive/texinfo/")
(add-to-list 'load-path "~/.emacs.d/predictive/html/")
;; load predictive package
(autoload 'predictive-mode "~/.emacs.d/predictive/predictive"
  "Turn on Predictive Completion Mode." t)

(require 'redo+)
(global-set-key [(control z)] 'undo)
(global-set-key [(control shift z)] 'redo)

(global-set-key [(control a)] 'mark-whole-buffer)

;; (add-to-list 'load-path "~/.emacs.d/ergoemacs-mode")
;; (require 'ergoemacs-mode)

;; (add-hook 'LaTeX-mode-hook 'predictive-mode)

;; (setq completion-ui-use-dynamic nil)
;; (setq completion-ui-use-echo nil)
;; (setq completion-auto-show nil)
;; (setq completion-auto-show-delay '(global . 4))
;; (setq completion-use-hotkeys nil)

;; (global-set-key [\C-tab] 'completion-show-popup-tip)

;; (add-to-list 'auto-mode-alist '("\\.tex$" . TeX-latex-mode))

;; (electric-pair-mode 1)

;; (add-to-list 'load-path "~/.emacs.d/elpa/hindent-20151113.24")
;; (require 'hindent)
;; (add-hook 'haskell-mode-hook #'hindent-mode)


(when (boundp window-system)
  (set-face-background 'region "white"))

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

