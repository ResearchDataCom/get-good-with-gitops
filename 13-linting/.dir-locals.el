;;; Directory Local Variables            -*- no-byte-compile: t -*-
;;; For more information see (info "(emacs) Directory Variables")

((python-mode . ((eval . (progn
                           ;; sort imports, then style code
                           (add-hook 'before-save-hook #'py-isort-before-save nil t)
                           (add-hook 'before-save-hook #'elpy-black-fix-code nil t))))))
