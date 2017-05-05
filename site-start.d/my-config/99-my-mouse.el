(require 'mouse)

;; Fix mouse from emacsclient
;; http://stackoverflow.com/a/6798279
(defun my-terminal-mouse-config (&optional frame)
  "Establish settings for the current terminal."
  (if (not frame) ;; The initial call.
	  (xterm-mouse-mode 1)
	;; Otherwise called via after-make-frame-functions.
	(if xterm-mouse-mode
		;; Re-initialise the mode in case of a new terminal.
		(xterm-mouse-mode 1))))
;; Evaluate both now (for non-daemon emacs) and upon frame creation
;; (for new terminals via emacsclient).
(my-terminal-mouse-config)
(add-hook 'after-make-frame-functions 'my-terminal-mouse-config)

(defun track-mouse (e))
(require 'mwheel)

(global-set-key (kbd "<mouse-4>") 'mwheel-scroll)
(global-set-key (kbd "<mouse-5>") 'mwheel-scroll)

(global-set-key (kbd "<mouse-20>") 'scroll-right)
(global-set-key (kbd "<mouse-21>") 'scroll-left)
