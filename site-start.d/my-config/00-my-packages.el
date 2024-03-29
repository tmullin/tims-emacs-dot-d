;; my-packages.el
;; http://toumorokoshi.github.io/emacs-from-scratch-part-2-package-management.html


(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)

; No longer necessary with Emacs 28.2
; (package-initialize)


(defvar required-packages
  '(
;    icicles
;    p4
;    yasnippet
;    zenburn-theme
    ) "a list of packages to ensure are installed at launch.")



(require 'cl)

					; Method to check if all packages are installed
(defun packages-installed-p ()
  (loop for p in required-packages
	when (not (package-installed-p p)) do (return nil)
	finally (return t)))

					; if not all packages are installed, check one by one and install the missing ones.
(unless (packages-installed-p)
					; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
					; install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))
