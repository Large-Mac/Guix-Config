(define-module (home suckless packages)
  #:use-module (gnu packages)
  #:use-module (guix packages)
  #:use-module (guix build-system gnu)
  #:use-module (guix git-download)
  #:use-module (guix gexp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages fontutils)
  #:export (make-dwm
           make-dmenu
           make-st))

;; Helper function to apply patches
(define (apply-patches patch-files)
  `(lambda _
     (for-each
      (lambda (patch-file)
        (invoke "patch" "-p1" "-i" patch-file))
      ',patch-files)))

;; Function to create customized dwm package
(define* (make-dwm #:key (patches '()) (config-file #f))
  (package
    (name "dwm")
    (version "6.4")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://git.suckless.org/dwm")
                    (commit version)))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "1hjvhp57imr1nkjhzqhni1b0vary3j5l1kx179jrp5qzlkxnlbxp"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f
       #:make-flags
       (list (string-append "PREFIX=" %output)
             "CC=gcc")
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)
         ,@(if (null? patches)
               '()
               `((add-after 'unpack 'apply-patches
                   ,(apply-patches patches))))
         (add-before 'build 'setup-config
           (lambda _
             (when (file-exists? "config.h")
               (delete-file "config.h"))
             ,(if config-file
                  `(copy-file ,config-file "config.h")
                  `(copy-file "config.def.h" "config.h"))
             #t)))))
    (inputs
     `(("libx11" ,libx11)
       ("libxft" ,libxft)
       ("libxinerama" ,libxinerama)))
    (home-page "https://dwm.suckless.org/")
    (synopsis "Dynamic window manager")
    (description "dwm is a dynamic window manager for X.")
    (license license:expat)))

;; Similar functions for dmenu and st...
(define* (make-dmenu #:key (patches '()) (config-file #f))
  (package
    (name "dmenu")
    (version "5.2")
    ;; ... similar structure to make-dwm
    ))

(define* (make-st #:key (patches '()) (config-file #f))
  (package
    (name "st")
    (version "0.9")
    ;; ... similar structure to make-dwm
    ))
