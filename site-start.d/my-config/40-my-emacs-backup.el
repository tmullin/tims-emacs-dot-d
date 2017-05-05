(defun directory-files-recursive (directory &optional full match nosort nodirectories ignore maxdepth)
  "List files in DIRECTORY and in its sub-directories.
If FULL is non-nil, return absolute file names.  Otherwise return names
 that are relative to the specified directory.
If MATCH is non-nil, mention only file names that match the regexp MATCH.
If NOSORT is non-nil, the list is not sorted;; its order is unpredictable.
 Otherwise, the list returned is sorted with `string-lessp'.
 NOSORT is useful if you plan to sort the result yourself.
If NODIRECTORIES is non-nil, do not include directories in the returned list.
 Otherwise, the directory will return ordered before files in that directory,
 unless NOSORT was used.
If IGNORE is non-nil, mention file names that do not match the regexp
 IGNORE.  IGNORE is evaluated before MATCH.
If MAXDEPTH is non-nil, only recurse to depth MAXDEPTH.  If zero or
 negative, do not recurse."
  (let* ((files-list '())
		 (current-directory-list (directory-files directory full nil nosort)))
	;;while we are in the current directory
	(while current-directory-list
	  (let ((file (car current-directory-list)))
		(cond
		 ;;ignore
		 ((and
		   ignore
		   (file-regular-p file)
		   (string-match ignore file))
		  nil)
		 ;;match
		 ((and
		   (file-regular-p file)
		   (file-readable-p file)
		   (string-match match file))
		  (setq files-list (cons file files-list)))
		 ;;recurse
		 ((and
		   ;; recurse only if necessary
		   (or (not maxdepth) (> maxdepth 0))
		   (file-directory-p file)
		   (file-readable-p file)
		   (not (string-equal ".." (substring file -2)))
		   (not (string-equal "." (substring file -1))))
		  (setq files-list (append files-list (directory-files-recursive file full match nosort ignore (if maxdepth (- maxdepth 1)))))
		  (if nodirectories
			  (setq files-list (cons file files-list))))
		 ;;no match
		 (t
		  nil)))
	  (setq current-directory-list (cdr current-directory-list)))
	;;return
	files-list))


;; Set up emacs backups.
(defvar temp-emacs-file-directory "~/tmp/emacs")
(setq
 backup-by-copying t
 backup-directory-alist `((".*" . ,temp-emacs-file-directory)) ;; Back up everything centrally
 auto-save-file-name-transforms `((".*" ,temp-emacs-file-directory t))
 delete-old-versions t
 version-control t ;; Use versioned backups.
 kept-new-versions 6
 kept-old-versions 2)
;; Delete backups not accessed in 2 weeks
(message "Deleting old backup files...")
(let ((biweek (* 60 60 24 14))
	  (current (float-time (current-time))))
  (dolist (file (directory-files temp-emacs-file-directory t nil t))
	(when (and
		   (backup-file-name-p file)
		   (file-regular-p file)
		   (> (- current (float-time (nth 5 (file-attributes file)))) biweek))
	  (message "-%s" file)
	  (delete-file file))))
