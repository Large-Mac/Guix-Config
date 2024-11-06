(use-modules (gnu home)
            (gnu home services)
            (gnu services)
            (gnu home services dotfiles)
            (gnu home services shells)
            (gnu packages emacs)
            (gnu packages shells)
            (guix gexp))

(let* ((config-directory (dirname (current-filename)))
       (dotfiles-root (dirname (dirname config-directory)))  ; Go up two levels to reach dotfiles root
       (files-directory (string-append dotfiles-root "/files")))
  (home-environment
   ;; Packages to install
   (packages 
    (list emacs
          zsh))
          
   ;; Services configuration
   (services
    (list
     (service home-dotfiles-service-type
              (home-dotfiles-configuration
               (directories (list files-directory))))
            
     (simple-service 'emacs-doom-config
                    home-files-service-type
                    `((".emacs.d/init.el"
                       ,(plain-file
                         "init.el"
                         (string-append
                          "(setq doom-directory \"~/.config/emacs/doom.d\")\n"
                          "(condition-case nil\n"
                          "    (progn\n"
                          "      (unless (file-exists-p \"~/.config/emacs/doom-emacs\")\n"
                          "        (make-directory \"~/.config/emacs\" t)\n"
                          "        (call-process \"git\" nil nil nil\n"
                          "                    \"clone\" \"--depth\" \"1\"\n"
                          "                    \"https://github.com/doomemacs/doomemacs\"\n"
                          "                    \"~/.config/emacs/doom-emacs\"))\n"
                          "      (unless (file-exists-p \"~/.config/emacs/doom.d\")\n"
                          "        (make-directory \"~/.config/emacs/doom.d\" t))\n"
                          "      (add-to-list 'load-path \"~/.config/emacs/doom-emacs/lisp\")\n"
                          "      (require 'doom)\n"
                          "      (doom-initialize)\n"
                          "      (doom-setup))\n"
                          "  (error nil))\n")))))
     
     (service home-zsh-service-type
              (home-zsh-configuration
               (environment-variables
                '(("DOOMDIR" . "$HOME/.config/emacs/doom.d")
                  ("DOOMLOCAL" . "$HOME/.config/emacs/doom-local")
                  ("PATH" . "$PATH:$HOME/.config/emacs/doom-emacs/bin")))
               (zshrc (list (local-file (string-append files-directory "/zshrc"))))))))))

