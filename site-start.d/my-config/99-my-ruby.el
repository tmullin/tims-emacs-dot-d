;; See https://lorefnon.me/2014/02/02/configuring-emacs-for-rails.html

(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'robe-mode-hook 'ac-robe-setup)

(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

(setq ruby-deep-indent-paren nil)

(require 'rvm)
(rvm-use-default) ;; use rvm's default ruby for the current Emacs session

(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))
