(when (string-equal system-type "darwin")
  (menu-bar-mode t)
  (tool-bar-mode 0)
  (set-face-attribute 'default nil :font "Menlo-24")
  (delete-other-windows)
  (add-to-list 'default-frame-alist '(maximized))
  )