
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(define-minor-mode sticky-buffer-mode
  "Make the current window always display this buffer."
  nil " sticky" nil
    (set-window-dedicated-p (selected-window) sticky-buffer-mode))

;; skip multiple lines
(global-set-key (kbd "C-n")
                (lambda () (interactive) (next-line 10)))

(global-set-key (kbd "C-p")
                (lambda () (interactive) (previous-line 10)))

(global-set-key "\eg" 'goto-line)

;; display line numbers
(line-number-mode 1)

;; display column numbers
(column-number-mode 1)

(global-font-lock-mode 1)
;; c-mode to get c syntax highlighting

(menu-bar-mode -1)

(global-set-key [f5] 'shell)

;; Use electric buffer list instead of default one
(define-key ctl-x-map "\C-b" 'electric-buffer-list)
;; For "C-x b" use iswitchb-mode instead of default
(iswitchb-mode 1)

(global-set-key [home] 'move-beginning-of-line)
(global-set-key [end] 'move-end-of-line)

;; screen will flash on error, ew, turn off 
(setq ring-bell-function 'ignore)

(setq-default indent-tabs-mode nil)
(setq tab-width 4) ; or any other preferred value

;; look into this again
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Saving-Emacs-Sessions.html
;;(desktop-save-mode 1) ; open saved sessions on startup

;;(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin/"))  
;;(setq exec-path (append exec-path '("/Library/TeX/texbin/")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (auctex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; limit line lenght to 100 characters
(require 'whitespace)
(setq whitespace-line-column 100) ;; limit line length
(setq whitespace-style '(face lines-tail))

(add-hook 'prog-mode-hook 'whitespace-mode)

(global-whitespace-mode 1)

;; navigate panes with arrow keys
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)


;; navigate to specific pane respective to the
;; home/end/page up/page down location
(global-set-key (kbd "C-x <home>")
                (lambda () (interactive)
                  (ignore-errors (windmove-up)) (windmove-left)))
(global-set-key (kbd "C-x <end>")
                (lambda () (interactive)
                  (ignore-errors (windmove-down)) (windmove-left)))
(global-set-key (kbd "C-x <prior>")
                (lambda () (interactive)
                  (ignore-errors (windmove-up)) (windmove-right)))
(global-set-key (kbd "C-x <next>")
                (lambda () (interactive)
                  (ignore-errors (windmove-down)) (windmove-right)))

;; Allows you to create a new shell with M-z <char> where char is
;; a number or letter
(require 'shell)

(defun ashell (arg)
   (interactive "c")
   (if (or (< arg 32) (> arg 126))
       (error "Please use printable character for shell name"))
   (let* ((buffer (get-buffer (format "*shell*<%c>" arg))))
     (if buffer
 	(switch-to-buffer buffer)
       (progn
 	(shell)
         (setq shell-dirtrackp nil)
         (make-local-variable 'comint-input-sender)
         ;(setq comint-input-sender (function shellx-simple-send))
 	(rename-buffer (format "*shell*<%c>" arg))))))

(define-key global-map '[(meta ?z)] 'ashell)
;; end
