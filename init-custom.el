 ;; '(yas-snippet-dirs
 ;;   (quote
 ;; 	("~/.emacs.d/snippets" "~tgray/.emacs.d/snippets" yas-installed-snippets-dir)) nil (yasnippet))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backward-delete-char-untabify-method nil)
 '(c-basic-offset 4)
 '(column-number-mode t)
 '(comment-style (quote indent-or-triple))
 '(compile-command "verify_code ")
 '(cperl-close-paren-offset -4)
 '(cperl-continued-statement-offset 0)
 '(cperl-indent-level 4)
 '(cperl-indent-parens-as-block t)
 '(cperl-use-syntax-table-text-property t)
 '(cperl-use-syntax-table-text-property-for-tags t)
 '(custom-safe-themes
   (quote
	("9dae95cdbed1505d45322ef8b5aa90ccb6cb59e0ff26fef0b8f411dfc416c552" "c5a044ba03d43a725bd79700087dea813abcb6beb6be08c7eb3303ed90782482" "e56f1b1c1daec5dbddc50abd00fcd00f6ce4079f4a7f66052cf16d96412a09a9" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" default)))
 '(filesets-cache-save-often-flag t)
 '(fill-column 80)
 '(git-commit-fill-column 99999)
 '(global-auto-complete-mode t)
 '(ido-enable-flex-matching t)
 '(indent-tabs-mode t)
 '(inhibit-startup-screen t)
 '(js3-indent-tabs-mode t)
 '(large-file-warning-threshold nil)
 '(menu-bar-mode nil)
 '(p4-executable "/home/tmullin/bin/p4")
 '(p4-follow-symlinks t)
 '(package-selected-packages
   (quote
	(magit-gh-pulls smex magit dash zenburn-theme yasnippet-bundle yasnippet yaml-mode unfill sqlplus smart-mode-line rvm robe rainbow-delimiters pod-mode plsense-direx php-mode perspective perl-completion p4 multiple-cursors mmm-mode js3-mode imenu-anywhere icicles flymake-ruby flycheck-color-mode-line auto-install anything ace-jump-mode)))
 '(paren-mode (quote paren) nil (paren))
 '(show-paren-mode t)
 '(sml/no-confirm-load-theme t)
 '(sml/replacer-regexp-list
   (quote
	(("^~/org/" ":Org:")
	 ("^~/\\.emacs\\.d/" ":ED:")
	 ("^/sudo:.*:" ":SU:")
	 ("^~/Documents/" ":Doc:")
	 ("^~/Dropbox/" ":DB:")
	 ("^:\\([^:]*\\):Documento?s/" ":\\1/Doc:")
	 ("^~/[Gg]it/" ":Git:")
	 ("^~/[Gg]it[Hh]ub/" ":Git:")
	 ("^~/[Gg]it\\([Hh]ub\\|\\)-?[Pp]rojects/" ":Git:")
	 ("^~/p4/prod/" ":PR:")
	 ("^~/p4/builds/build_\\([^/]+\\)/" ":\\1:")
	 ("^~/p4/" ":P4:"))))
 '(tab-stop-list
   (quote
	(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96)))
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify))
 '(uniquify-separator "¤")
 '(user-mail-address "tmullin@toasttab.com")
 '(yas-also-auto-indent-first-line t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(p4-depot-unmapped-face ((t (:foreground "color-166"))) t))

;; Disabled commands to enable
(put 'scroll-left 'disabled nil)
