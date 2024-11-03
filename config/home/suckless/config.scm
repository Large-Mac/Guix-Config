(define-module (home suckless config)
  #:use-module (home suckless packages)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:export (suckless-config))

(define dwm-patches
  '("patches/dwm-pertag-20200914-61bb8b2.diff"
    "patches/dwm-fibonacci-20200418-c82db69.diff"
    "patches/dwm-vanitygaps-6.2.diff";; syntax is "patches/example-patch.diff"
    ))

(define dmenu-patches
  '("patches/dmenu-alpha-20230110-5.2.diff"
    "patches/dmenu-vi_mode-20230416-0fe460d.diff"
    "patches/dmenu-center-20240616-36c3d68.diff"
    ))

(define st-patches
  '("patches/st-alpha-20220206-0.8.5.diff"
    "patches/st-blinking_cursor-20230819-3a6d6d7.diff"
    "patches/st-autocomplete-20240703-6508693.diff"
    "patches/st-clipboard-0.8.3.diff"
    ))

(define suckless-config
  (home-environment
   (packages
    (list (make-dwm #:patches dwm-patches
                    #:config-file "config/dwm/config.h")
          (make-dmenu #:patches dmenu-patches
                      #:config-file "config/dmenu/config.h")
          (make-st #:patches st-patches
                   #:config-file "config/st/config.h")))
   (services
    (list
     (simple-service 'dwm-xinitrc
                    home-xdg-configuration-files-service-type
                    `(("xinitrc" ,(plain-file "xinitrc"
                                            "exec dwm"))))))))
