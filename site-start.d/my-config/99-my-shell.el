;; Environmental variable overrides
(setenv "EDITOR" "emacsclient")
(setenv "TERM" "xterm-256color")

(setenv "GRADLE_OPTS"
		(concat
		 (getenv "GRADLE_OPTS")
		 " "
		 "-Dorg.gradle.console=auto"
		 ))

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)


;; Turn file paths into links in shell.
(defun my-comint-linkify-file-paths (ignored)
  "Turn any file paths found in the output into button links to that file.

IGNORED is a string passed in by comint that we don't care about."
  (let ((start-marker (if (and (markerp comint-last-output-start)
							   (eq (marker-buffer comint-last-output-start)
								   (current-buffer))
							   (marker-position comint-last-output-start))
						  comint-last-output-start
						(point-min-marker)))
		(end-marker (process-mark (get-buffer-process (current-buffer)))))
	(let ((searchtext (buffer-substring-no-properties start-marker end-marker))
		  (matchend 0)
		  ;; Infinite loop prevention. The output is ussually put out
		  ;; line by line so this should never be hit during normal
		  ;; operation.
		  (maxmatch 500)
		  (currentmatch 0))
	  (let ((errormsg
			 (catch 'break
			   ;; There are some arbitrary characters in the path and filename character exclusions
			   ;; below to discount some stranger outputs from something like aglimpse. A long line
			   ;; of JS sometimes gets matched in here and then hangs while tramp tries to see if its
			   ;; a file or something.
			   (while (string-match "\\(\\(?://depot\\|~\\)?/\\(?:[^\\\n[:space:]{,]+?/\\)+[^.\\\n[:space:]{,]+?\\(?:[.][[:alnum:]_]+\\)+\\)\\(?:[[:space:]]*\\(?:)?[[:space:]]*[Ll][Ii][Nn][Ee]\\|:\\)[[:space:]]*\\([[:digit:]]+\\)\\)?" searchtext matchend)
				 (setq matchend (match-end 0))
				 (setq currentmatch (1+ currentmatch))
				 (let ((foundfile (match-string-no-properties 1 searchtext))
					   (linenumber (match-string-no-properties 2 searchtext))
					   (filetextstart (+ (match-beginning 1) start-marker))
					   (filetextend (+ (match-end 1) start-marker)))
				   (let ((filepath (replace-regexp-in-string
									"^~/"
									(replace-regexp-in-string "/*$" "/" (getenv "HOME"))
									(replace-regexp-in-string
									 "^//depot/"
									 (replace-regexp-in-string "/*$" "/" (getenv "P4_HOME"))
									 foundfile))))
					 (cond ((file-readable-p filepath)
							(make-text-button
							 filetextstart filetextend
							 'action `(lambda (ignoredtoo)
										(find-file ,filepath)
										(goto-char (point-min))
										(forward-line (1- (string-to-number ,linenumber)))
										(recenter-top-bottom)))))))
				 (when (>= currentmatch maxmatch)
				   (throw 'break "Long running loop detected!"))))))
		(when errormsg
		  (message errormsg))))))

;; Disabled for now
; (add-hook 'comint-output-filter-functions 'my-comint-linkify-file-paths)

(dolist (file
		 (file-expand-wildcards
		  (concat
		   (file-name-directory load-file-name)
		   "/../my-config-ext/*-shell-*.el")
		  ))
  (load-file file)
  )

;; Create my standard shell buffers.
(ansi-term (getenv "SHELL"))
(dolist (name (reverse '("" "-sql" "-git" "-git2" "-git3" "-err" "-repl")))
  (shell (concat "*sh" name "*"))
  )
