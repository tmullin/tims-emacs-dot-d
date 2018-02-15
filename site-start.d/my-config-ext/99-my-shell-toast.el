;; Create toast-specific shell buffers.
(dolist (name (reverse '("-wp1" "-wp2" "-wp3")))
  (shell (concat "*sh" name "*"))
  )
