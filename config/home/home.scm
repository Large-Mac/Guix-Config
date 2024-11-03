(define-module (guix-home-config)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu services)
  #:use-module (guix gexp)
;;  #:use-module (home services neovim))
;;  #:use-module (home suckless config))
  #:use-module (home services emacs))

(define home-config
  (home-environment
    (services
;;      (append
;;	neovim-services
      (list
	emacs-service
	%base-services
           ))))

home-config

;;(suckless-config)
