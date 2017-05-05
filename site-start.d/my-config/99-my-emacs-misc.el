
(global-set-key (kbd "C-c SPC") 'ace-jump-char-mode)
(global-set-key (kbd "C-c C-SPC") 'ace-jump-char-mode)

;;(global-set-key (kbd "<f3>") 'find-tag)
;;(global-set-key (kbd "M-<f3>") 'pop-tag-mark)

;;(global-set-key (kbd "C-/") 'comment-region)
;;(global-set-key (kbd "C-?") 'uncomment-region)

;; not a big fan of suspend.
;; (global-set-key "\C-x" ctl-x-map)
(global-unset-key [(control z)])
(global-unset-key [(control x)(control z)])

;; Refresh buffers for files when they change on disk if there aren't any
;; unsaved changes for the buffer.
(global-auto-revert-mode t)


(ido-mode 1)
;; (cua-mode 1)

;; I just always want this
(column-number-mode 1)

;; imenu
(global-set-key (kbd "M-o") 'imenu-anywhere)
;; I'm only interested in imenu options for the current buffer. By default it
;; includes all buffers.
(setq imenu-anywhere-buffer-list-function (lambda ()
											(list (current-buffer))))


; show-paren-mode
(setq show-paren-delay 0)
(show-paren-mode 1)

(menu-bar-mode 0)

;; Auto-save bookmarks
(setq bookmark-save-flag 1)


(setenv "PAGER" "/bin/cat")


;; Stuff for enabling the notion of separate workspaces
(require 'desktop)
(load "~/.emacs.d/nameses.el")

(require 'perspective)
(persp-mode 1)

(filesets-init)


;; Indent by tabs by default instead of spaces
(setq indent-rigidly-map
	  (let ((map (make-sparse-keymap)))
		(define-key map [S-left]  'indent-rigidly-left)
		(define-key map [S-right] 'indent-rigidly-right)
		(define-key map [left]  'indent-rigidly-left-to-tab-stop)
		(define-key map [right] 'indent-rigidly-right-to-tab-stop)
		map))


;;(require 'auto-complete-config)
;;(ac-config-default)


;; Open the current file, except in another user's home directory
(defun open-file-at-home (username)
  "Open the current file except in a different USERNAME's home directory."
  (interactive "sUsername: ")
  (let ((filename (buffer-file-name)))
	(cond (filename
		   (let ((theirfilename (replace-regexp-in-string "~/\\|/home/[[:word:]]+/" (concat "/home/" username "/") filename)))
			 (cond ((file-regular-p theirfilename)
					(message (concat "Opening file: " theirfilename))
					(find-file theirfilename))
				   (t (message (concat "Did not find file: " theirfilename))))))
		  (t (message "Filename for current buffer not found.")))))
