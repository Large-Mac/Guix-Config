(define-module (home services emacs)
  #:use-module (gnu home services)
  #:use-module (gnu home-services emacs)
  #:use-module (guix gexp)
  #:export (emacs-service))

(define emacs-service
  (service home-emacs-service-type
    (home-emacs-configuration
      (package emacs)
      (init-el #~(setq inhibit-startup-message t)))))
