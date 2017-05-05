;; Make ediff commands save my window config and reload it after it's done

(defvar my-pre-ediff-window-state nil)

(advise-commands
 "save-window-configuration"
 (ediff-buffers ediff-buffers3 ediff-files ediff-files3 ediff-directories ediff-directories3)
 before
 (setq my-pre-ediff-window-state (current-window-configuration)))

(defadvice ediff-quit (after ediff-quit-after activate)
  "Reset the window configuration after `ediff-quit'."
  (set-window-configuration my-pre-ediff-window-state))
