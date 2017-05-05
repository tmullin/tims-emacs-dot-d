(defun my-kill-buffer-other-window ()
  (interactive)
  (kill-buffer (window-buffer (next-window))))
(global-set-key (kbd "C-c k") 'my-kill-buffer-other-window)
