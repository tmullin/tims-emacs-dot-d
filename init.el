;; Keep "customized" variables in a separate file and load them before anything
;; else.
(setq custom-file
	  (concat user-emacs-directory
			  "init-custom.el"))
(load custom-file)

;; When enabling commands that are disabled by default, write the command that
;; enables them in the future to `custom-file' instead of this file.
;; See http://www.emacswiki.org/emacs/DisabledCommands
(defadvice en/disable-command (around put-in-custom-file activate)
  "Put declarations in `custom-file'."
  (let ((user-init-file custom-file))
	ad-do-it))

;; This is from Tyson's config and is used somewhere...
;; TODO move to better place
(defmacro advise-commands (advice-name commands location &rest body)
  "Apply advice named ADVICE-NAME to multiple COMMANDS.
The advice type (before around after) is in LOCATION.
The body of the advice is in BODY."
  `(progn
	 ,@(mapcar
		(lambda (command)
		  `(defadvice ,command (,location ,(intern (concat (symbol-name command) "-" advice-name)) activate)
			 ,@body))
		commands)))

;; This is from Tyson's config
;; TODO move to better place
(defmacro advise-universal-argument (command &rest val-and-body-list)
  "Apply advice named COMMAND-universal-argument to COMMAND.
VAL-AND-BODY-LIST contains the `universal-argument' value followed by an elisp
form that indicated what to do for that argument. The form can contain
`ad-do-it' in order to continue execution with the advised command."
  `(defadvice ,command (around ,(intern (concat (symbol-name command) "-universal-argument")) activate)
	 (let ((arg current-prefix-arg))
	   (if (number-or-marker-p arg)
		   (cond
			,@(mapcar
			   (lambda (val-and-body)
				 (let ((val (car val-and-body))
					   (body (cdr val-and-body)))
				   `((= arg ,val)
					 ,@body)))
			   val-and-body-list)
			(t ad-do-it))
		 ad-do-it))))

;; Use `my-site-start' to modularize emacs config instead of having a monolithic init.el.
;; See https://github.com/tripleee/my-site-start/
(autoload 'my-site-start "~/.emacs.d/my-site-start/my-site-start" nil t)
(my-site-start "~/.emacs.d/site-start.d/")
